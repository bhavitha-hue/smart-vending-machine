module vending_fsm(
    input clk,
    input rst,
    input start,
    input stock_available,
    input payment_mode,// 0 for cash, 1 for QR
    input qr_done,
    input cash_done,
    input [3:0] quantity,
    input cancel,
    input timeout,
    input machine_enable,
    input fraud_detected,
    output reg [4:0] state
);
parameter IDLE =5'd0,
          SELECT_PRODUCT=5'd1,
          CHECK_STOCK=5'd2,
          DYNAMIC_PRICING=5'd3,
          RECOMMENDED_PRODUCT=5'd4,
          SELECT_PAYMENT=5'd5,
          INSERT_CASH=5'd6,
          GENERATE_QR=5'd7,
          WAIT_FOR_SCAN=5'd8,
          VERIFY_PAYMENT=5'd9,
          PAYMENT_SUCCESS=5'd10,
          RETURN_CHANGE=5'd11,
          DISPENSE_PRODUCT=5'd12,
          UPDATE_INVENTORY=5'd13,
          GENERATE_RECEIPT=5'd14,
          TRANSACTION_LOG=5'd15,
          UPDATE_HISTORY=5'd16,
          CANCEL_TRANSACTION=5'd17,
          TIMEOUT_STATE=5'd18,
          LOCK_MACHINE=5'd19;


reg [4:0] next_state;
always @(posedge clk or posedge rst) begin //shift register
    if(rst) state<=IDLE;
    else state<=next_state;
end
always @(*) begin
    next_state=state;

    case(state)
    
    IDLE : begin
        if(start) 
            next_state=SELECT_PRODUCT;
        else 
            next_state=IDLE;
    end

    SELECT_PRODUCT: begin
    next_state = CHECK_STOCK;
    end

    CHECK_STOCK: begin
        if(stock_available)
            next_state=DYNAMIC_PRICING;
        else begin
            next_state=IDLE;
        end
    end

    DYNAMIC_PRICING: next_state=RECOMMENDED_PRODUCT;
    
    RECOMMENDED_PRODUCT: next_state=SELECT_PAYMENT;

    SELECT_PAYMENT: begin
        if(payment_mode==1'b0) next_state=INSERT_CASH;
        else if (payment_mode==1'b1) next_state=GENERATE_QR;
        else next_state=IDLE;
    end

    INSERT_CASH: begin
        if(cancel)
            next_state=CANCEL_TRANSACTION;
        else if (timeout)
            next_state=TIMEOUT_STATE;
        else if(cash_done)
            next_state=PAYMENT_SUCCESS;
        else next_state=INSERT_CASH;
    end

    GENERATE_QR: next_state=WAIT_FOR_SCAN;

    WAIT_FOR_SCAN: begin
        if(timeout)
            next_state=TIMEOUT_STATE;
        else if (cancel)
            next_state=CANCEL_TRANSACTION;
        else next_state=VERIFY_PAYMENT;
    end


    VERIFY_PAYMENT: begin
        if(fraud_detected)
            next_state=LOCK_MACHINE;
        else if(qr_done)
            next_state=PAYMENT_SUCCESS;
        else next_state=GENERATE_QR;
    end
    
    PAYMENT_SUCCESS: begin
        if(payment_mode==1'b0) 
            next_state=RETURN_CHANGE;
        else next_state=DISPENSE_PRODUCT;
    end
    
    RETURN_CHANGE : next_state=DISPENSE_PRODUCT;

    DISPENSE_PRODUCT : next_state=UPDATE_INVENTORY;

    UPDATE_INVENTORY: next_state=GENERATE_RECEIPT;

    GENERATE_RECEIPT: begin
        $display("================================");
        $display("Thank you for purchasing!");
        $display("Please visit again.");
        $display("================================");
        next_state=TRANSACTION_LOG;
    end
    
    TRANSACTION_LOG: next_state=UPDATE_HISTORY;

    UPDATE_HISTORY:next_state=IDLE;

    CANCEL_TRANSACTION : next_state=IDLE;

    TIMEOUT_STATE: next_state=IDLE;

    LOCK_MACHINE:begin 
        if(machine_enable)
            next_state = IDLE;
        else
            next_state = LOCK_MACHINE;
    end
     
    default: next_state=IDLE;

    endcase
end

endmodule
