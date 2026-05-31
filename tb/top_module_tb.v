`timescale 1ns/1ps

module top_module_tb;

reg clk;
reg rst;
reg start;
reg payment_mode;
reg [3:0] user_cart0;
reg [3:0] user_cart1;
reg [3:0] user_cart2;
reg [3:0] user_cart3;
reg [7:0] coin;
reg qr_valid;
reg cancel;
reg accept_recommendation;
reg [1:0] demand_level;
reg admin_unlock;
reg refill_stock;

wire [4:0] state;
wire stock_available;
wire qr_done;
wire cash_done;
wire timeout;
wire fraud_detected;
wire [15:0] total_price;

top_module DUT(

    .clk(clk),
    .rst(rst),
    .start(start),
    .payment_mode(payment_mode),
    .user_cart0(user_cart0),
    .user_cart1(user_cart1),
    .user_cart2(user_cart2),
    .user_cart3(user_cart3),
    .coin(coin),
    .qr_valid(qr_valid),
    .cancel(cancel),
    .accept_recommendation(accept_recommendation),
    .demand_level(demand_level),
    .admin_unlock(admin_unlock),
    .refill_stock(refill_stock),
    .state(state),
    .stock_available(stock_available),
    .qr_done(qr_done),
    .cash_done(cash_done),
    .timeout(timeout),
    .fraud_detected(fraud_detected),
    .total_price(total_price)
);
initial begin

    $dumpfile("wave.vcd");
    $dumpvars(0, top_module_tb);

    clk = 0;
end
always #5 clk = ~clk;
task reset_system;
begin
    rst = 1;
    #20;
    rst = 0;
end
endtask

task clear_inputs;
begin
    start = 0;
    payment_mode = 0;
    user_cart0 = 0;
    user_cart1 = 0;
    user_cart2 = 0;
    user_cart3 = 0;
    coin = 0;
    qr_valid = 0;
    cancel = 0;
    accept_recommendation = 0;
    demand_level = 2'b01;
    admin_unlock = 0;
    refill_stock = 0;
end
endtask

initial begin
    clk = 0;
    clear_inputs();
    reset_system();

    $display("\nTESTCASE 1 : SINGLE PRODUCT SINGLE QUANTITY CASH SUCCESS\n");

    user_cart0 = 4'd1;
    start = 1;
    #10;
    start = 0;
    payment_mode = 0;
    #20;
    coin = 8'd20;
    #20;
    coin = 0;
    #100;
    clear_inputs();

    $display("\nTESTCASE 2 : SINGLE PRODUCT MULTIPLE QUANTITY\n");
    user_cart1 = 4'd3;
    start = 1;
    #10;
    start = 0;
    payment_mode = 0;
    #20;
    coin = 8'd50;
    #20;
    coin = 8'd50;
    #100;
    clear_inputs(); 

    $display("\nTESTCASE 3 : MULTIPLE PRODUCTS MULTIPLE QUANTITIES\n");
    user_cart0 = 4'd2;
    user_cart2 = 4'd3;
    start = 1;
    #10;
    start = 0;
    payment_mode = 0;
    #20;
    coin = 8'd100;
    #20;
    coin = 8'd100;
    #100;
    clear_inputs();

    $display("\nTESTCASE 4 : INSUFFICIENT CASH PAYMENT\n");
    user_cart3 = 4'd2;
    start = 1;
    #10;
    start = 0;
    payment_mode = 0;
    #20;
    coin = 8'd5;
    #100;
    clear_inputs();

    $display("\nTESTCASE 5 : QR PAYMENT SUCCESS\n");
    user_cart2 = 4'd1;
    start = 1;
    #10;
    start = 0;
    payment_mode = 1;
    #30;
    qr_valid = 1;
    #20;
    qr_valid = 0;
    #100;
    clear_inputs();

    $display("\nTESTCASE 6 : QR TIMEOUT FAILURE\n");
    user_cart1 = 4'd1;
    start = 1;
    #10;
    start = 0;
    payment_mode = 1;
    // wait for timeout
    #400;
    clear_inputs();

    $display("\nTESTCASE 7 : CANCEL TRANSACTION\n");
    user_cart0 = 4'd1;
    user_cart1 = 4'd1;
    start = 1;
    #10;
    start = 0;
    payment_mode = 0;
    #20;
    cancel = 1;
    #20;
    cancel = 0;
    #100;
    clear_inputs();

    $display("\nTESTCASE 8 : FRAUD DETECTION\n");
    user_cart2 = 4'd2;
    start = 1;
    #10;
    start = 0;
    payment_mode = 0;
    // abnormal coin value
    #20;
    coin = 8'd150;
    #100;
    clear_inputs();

    $display("\nTESTCASE 9 : ADMIN UNLOCK\n");
    #20;
    admin_unlock = 1;
    #20;
    admin_unlock = 0;
    #100;
    clear_inputs();

    $display("\nTESTCASE 10 : OUT OF STOCK\n");
    // item3 initially stock = 0
    user_cart3 = 4'd2;
    start = 1;
    #10;
    start = 0;
    #100;
    clear_inputs();

    $display("\nTESTCASE 11 : RECOMMENDATION ACCEPTED\n");
    user_cart0 = 4'd1;
    start = 1;
    #10;
    start = 0;
    accept_recommendation = 1;
    #20;
    accept_recommendation = 0;
    payment_mode = 0;
    #20;
    coin = 8'd50;
    #100;
    clear_inputs();

    $display("\nTESTCASE 12 : HIGH DEMAND DYNAMIC PRICING\n");
    demand_level = 2'b10;
    user_cart0 = 4'd2;
    user_cart1 = 4'd2;
    start = 1;
    #10;
    start = 0;
    payment_mode = 0;
    #20;
    coin = 8'd100;
    #20;
    coin = 8'd100;
    #100;
    clear_inputs();

    $display("\nALL TESTCASES COMPLETED\n");
    #100;
    $finish;

end

endmodule