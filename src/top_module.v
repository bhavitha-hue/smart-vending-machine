module top_module(
    input clk,
    input rst,
    input start,
    input payment_mode,
    input [3:0] user_cart0,
    input [3:0] user_cart1,
    input [3:0] user_cart2,
    input [3:0] user_cart3,
    input [7:0] coin,
    input qr_valid,
    input cancel,
    input accept_recommendation,
    input admin_unlock,
    input refill_stock,
    input [1:0] demand_level,
    output [4:0] state,
    output stock_available,
    output qr_done,
    output cash_done,
    output timeout,
    output fraud_detected,
    output [15:0] total_price
);

wire [3:0] cart0, cart1, cart2, cart3;
wire [3:0] add0, add1, add2, add3;
wire [3:0] rec_item;
wire rec_valid;
wire [15:0] balance;
wire [15:0] change;
wire [7:0] stock_count;
wire qr_fail;
wire qr_active;
wire machine_enable;
wire refill_enable;
cart_manager CM(
    .clk(clk),
    .rst(rst),
    .user_cart0(user_cart0),
    .user_cart1(user_cart1),
    .user_cart2(user_cart2),
    .user_cart3(user_cart3),
    .add0(add0),
    .add1(add1),
    .add2(add2),
    .add3(add3),
    .update_cart(start),
    .cart0(cart0),
    .cart1(cart1),
    .cart2(cart2),
    .cart3(cart3)
);
recommendation_engine RE(
    .clk(clk),
    .rst(rst),
    .cart0(cart0),
    .cart1(cart1),
    .cart2(cart2),
    .cart3(cart3),
    .product_select(2'b00),
    .accept_recommendation(accept_recommendation),
    .rec_item(rec_item),
    .rec_valid(rec_valid),
    .add0(add0),
    .add1(add1),
    .add2(add2),
    .add3(add3)
);
inventory_manager IM(
    .clk(clk),
    .rst(rst),
    .cart0(cart0),
    .cart1(cart1),
    .cart2(cart2),
    .cart3(cart3),
    .dispense(state == 5'd12),
    .check_stock(state == 5'd2),
    .stock_available(stock_available),
    .stock_count(stock_count)
);
dynamic_pricing DP(
    .cart0(cart0),
    .cart1(cart1),
    .cart2(cart2),
    .cart3(cart3),
    .price0(8'd10),
    .price1(8'd15),
    .price2(8'd20),
    .price3(8'd25),
    .demand_level(demand_level),
    .total_price(total_price)
);
payment_controller PC(
    .clk(clk),
    .rst(rst),
    .payment_mode(payment_mode),
    .coin(coin),
    .total_price(total_price),
    .quantity(cart0 + cart1 + cart2 + cart3),
    .qr_valid(qr_valid),
    .qr_done(qr_done),
    .cash_done(cash_done),
    .balance(balance),
    .change(change)
);
qr_payment_fsm QR(
    .clk(clk),
    .rst(rst),
    .qr_valid(qr_valid),
    .start_qr(state == 5'd7),
    .cancel(cancel),
    .fraud_detected(fraud_detected),
    .timeout(timeout),
    .qr_done(qr_done),
    .qr_fail(qr_fail),
    .qr_active(qr_active)
);
fraud_detector FD(
    .clk(clk),
    .rst(rst),
    .qr_valid(qr_valid),
    .payment_mode(payment_mode),
    .timeout(timeout),
    .cancel(cancel),
    .coin(coin),
    .fraud_detected(fraud_detected)
);
timeout_controller TC(
    .clk(clk),
    .rst(rst),
    .enable(state == 5'd6 || state == 5'd8),
    .timeout(timeout)
);
transaction_logger TL(
    .clk(clk),
    .rst(rst),
    .log_enable(state == 5'd15),
    .payment_mode(payment_mode),
    .total_price(total_price)
);
admin_controller AC(
    .clk(clk),
    .rst(rst),
    .admin_unlock(admin_unlock),
    .refill_stock(refill_stock),
    .fraud_detected(fraud_detected),
    .machine_enable(machine_enable),
    .refill_enable(refill_enable)
);
vending_fsm FSM(
    .clk(clk),
    .rst(rst),
    .start(start),
    .stock_available(stock_available),
    .payment_mode(payment_mode),
    .qr_done(qr_done),
    .cash_done(cash_done),
    .quantity(cart0 + cart1 + cart2 + cart3),
    .cancel(cancel),
    .timeout(timeout),
    .fraud_detected(fraud_detected),
    .machine_enable(machine_enable),
    .state(state)
);

endmodule