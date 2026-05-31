module inventory_manager(
    input clk,
    input rst,
    input [3:0] cart0,
    input [3:0] cart1,
    input [3:0] cart2,
    input [3:0] cart3,
    input dispense,
    input check_stock,

    output reg stock_available,
    output reg[7:0] stock_count
);
reg [7:0] stock [0:3];

always @(posedge clk or posedge rst) begin
    if(rst) begin
        stock[0]<=8'd10;
        stock[1]<=8'd5;
        stock[2]<=8'd7;
        stock[3]<=8'd0;
        stock_available <= 1'b0;
        stock_count <= 8'd0;
    end
    else if(check_stock)
    begin
        if(stock[0] >= cart0 &&
           stock[1] >= cart1 &&
           stock[2] >= cart2 &&
           stock[3] >= cart3)
        begin
            stock_available <= 1'b1;
        end
        else
        begin
            stock_available <= 1'b0;

            $display("INSUFFICIENT STOCK");

            $display("STOCK : %0d %0d %0d %0d",
                     stock[0], stock[1], stock[2], stock[3]);

            $display("CART  : %0d %0d %0d %0d",
                     cart0, cart1, cart2, cart3);
        end
    end


    else if(dispense) begin
        if(stock_available)
         begin
            stock[0] <= stock[0] - cart0;
            stock[1] <= stock[1] - cart1;
            stock[2] <= stock[2] - cart2;
            stock[3] <= stock[3] - cart3;

            $display("DISPENSE SUCCESSFUL (ALL ITEMS)");


        end
        else begin
            $display("DISPENSE FAILED - INSUFFICIENT STOCK");

            $display("STOCK: %0d %0d %0d %0d",
                     stock[0], stock[1], stock[2], stock[3]);

            $display("CART : %0d %0d %0d %0d",
                     cart0, cart1, cart2, cart3);

        end
    end

end
always @(*)
begin
    stock_count = stock[0] + stock[1] + stock[2] + stock[3];
end


endmodule

    





