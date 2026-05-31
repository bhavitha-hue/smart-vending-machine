module transaction_logger(
    input clk,
    input rst,
    input log_enable,
    input payment_mode,
    input [15:0] total_price,

    output reg [7:0] transaction_count,
    output reg [15:0] last_transaction
);

always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        transaction_count <= 8'd0;
        last_transaction  <= 16'd0;
    end
    else if(log_enable)
    begin
        transaction_count <= transaction_count + 1'b1;
        last_transaction  <= total_price;
    end
end

endmodule