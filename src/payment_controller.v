module payment_controller(
    input clk,
    input rst,
    input payment_mode,
    input [7:0] coin,
    input [15:0] total_price,
    input [3:0] quantity,
    input qr_valid,
    output reg qr_done,
    output reg cash_done,
    output reg [15:0] balance,
    output reg [15:0] change
);

always @(posedge clk or posedge rst) begin
    if(rst) begin
        balance<=16'b0;
        change<=16'b0;
        qr_done<=1'b0;
        cash_done<=1'b0;
    end
    
    else if(payment_mode==1'b0)
    begin
    qr_done <= 1'b0;

    if(coin != 0 && !cash_done)
    begin
        balance <= balance + coin;

        if(balance + coin >= total_price)
        begin
            cash_done <= 1'b1;
            change <= balance + coin - total_price;

            $display("PAYMENT SUCCESSFUL");
            $display("CHANGE RETURNED = %0d",
                     balance + coin - total_price);
        end

        else
        begin
            cash_done <= 1'b0;

            $display("TOTAL PRICE = %0d", total_price);
            $display("CURRENT AMOUNT IS %0d",
                     balance + coin);

            $display("INSUFFICIENT FUNDS - KINDLY ADD MORE");
        end
    end
    end
    else if(payment_mode==1'b1) begin
        cash_done<=1'b0;
        balance<=16'b0;
        change<=16'b0;

        if(qr_valid) begin
           qr_done<=1'b1;
           $display("QR PAYMENT SUCCESSFUL");
           $display("TOTAL PRICE = %0d", total_price);
        end
        else 
           qr_done<=1'b0;
    end
end
endmodule
        
