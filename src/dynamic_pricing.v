module dynamic_pricing(
    input [3:0]cart0,
    input [3:0]cart1,
    input [3:0]cart2,
    input [3:0]cart3,
    input [7:0]price0,
    input [7:0]price1,
    input [7:0]price2,
    input [7:0]price3,
    input [1:0]demand_level,

    output reg [15:0] total_price
);
reg [15:0] base_total;
always @(*) begin
    base_total= (cart0*price0)+(cart1*price1)+(cart2*price2)+(cart3*price3);
    case(demand_level) 
        2'b00: total_price=(base_total* 9)/10;      //less demand-10% discount
        2'b01: total_price=base_total;             //normal demand-normal price
        2'b10: total_price=(base_total* 11)/10;     // high demand-10%hike
        default: total_price=base_total;
endcase
end
endmodule