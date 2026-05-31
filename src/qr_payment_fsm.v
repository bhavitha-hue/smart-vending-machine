module qr_payment_fsm(
    input clk,
    input rst,
    input qr_valid,
    input start_qr,
    input cancel,
    input fraud_detected,
    input timeout,

    output reg qr_done,
    output reg qr_fail,
    output reg qr_active
);
always @(posedge clk or posedge rst) begin
    if(rst) begin
        qr_done<=1'b0;
        qr_fail<=1'b0;
        qr_active<=1'b0;
    end
    else begin
        qr_done<=0;
        qr_fail<=0;
        qr_active<=0; 
        if(start_qr) qr_active<=1'b1;

        if(start_qr && qr_valid && !fraud_detected) begin
            qr_active<=1'b1;
            qr_done<=1'b1;
            qr_fail<=1'b0;
        end
        if(start_qr &&(cancel ||fraud_detected||timeout)) begin
            qr_active<=1'b0;
            qr_fail<=1'b1;
            qr_done<=1'b0;
        end
    end
end
endmodule
