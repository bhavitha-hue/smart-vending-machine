module fraud_detector(
    input clk,
    input rst,
    input qr_valid,
    input payment_mode,
    input timeout,
    input cancel,
    input [7:0] coin,

    output reg fraud_detected
);

always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        fraud_detected <= 1'b0;
    end
    else
    begin
        fraud_detected <= 1'b0;

        //  invalid QR attempt
        if(payment_mode == 1'b1 && !qr_valid && timeout)
            fraud_detected <= 1'b1;

        // repeated cancel/timeout
        else if(cancel && timeout)
            fraud_detected <= 1'b1;

        // abnormal coin input 
        else if(payment_mode == 1'b0 && coin > 8'd100)
            fraud_detected <= 1'b1;
    end
end

endmodule