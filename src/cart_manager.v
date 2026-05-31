module cart_manager(

    input clk,
    input rst,

    input [3:0] user_cart0,
    input [3:0] user_cart1,
    input [3:0] user_cart2,
    input [3:0] user_cart3,

    input [3:0] add0,
    input [3:0] add1,
    input [3:0] add2,
    input [3:0] add3,

    input update_cart,   // enable update signal from FSM

    output reg [3:0] cart0,
    output reg [3:0] cart1,
    output reg [3:0] cart2,
    output reg [3:0] cart3

);

always @(posedge clk or posedge rst)
begin

    if(rst)
    begin
        cart0 <= 4'd0;
        cart1 <= 4'd0;
        cart2 <= 4'd0;
        cart3 <= 4'd0;
    end

    else if(update_cart)
    begin
        cart0 <= user_cart0 + add0;
        cart1 <= user_cart1 + add1;
        cart2 <= user_cart2 + add2;
        cart3 <= user_cart3 + add3;
    end
    
end

endmodule