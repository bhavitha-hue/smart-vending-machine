module recommendation_engine(

    input clk,
    input rst,
    input [3:0] cart0,
    input [3:0] cart1,
    input [3:0] cart2,
    input [3:0] cart3,
    input [1:0] product_select,
    input accept_recommendation,

    output reg [3:0] rec_item,   // suggested item index
    output reg rec_valid,
    output reg [3:0] add0,
    output reg [3:0] add1,
    output reg [3:0] add2,
    output reg [3:0] add3

);

always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        rec_item <= 4'd0;
        rec_valid <= 1'b0;
        add0 <= 0;
        add1 <= 0;
        add2 <= 0;
        add3 <= 0;
    end

    else
    begin
        rec_valid <= 1'b1;

        if(cart0 > 0)
            rec_item <= 4'd1;   // if item0 bought → suggest item1

        else if(cart1 > 0)
            rec_item <= 4'd0;   // if item1 bought → suggest item0

        else if(cart2 > 0)
            rec_item <= 4'd3;   // if item2 bought → suggest item3

        else if(cart3 > 0)
            rec_item <= 4'd2;   // if item3 bought → suggest item2

        else
            rec_item <= 4'd0;   // default only when nothing selected

        

        if(accept_recommendation)
        begin
            add0 <= (rec_item == 0);
            add1 <= (rec_item == 1);
            add2 <= (rec_item == 2);
            add3 <= (rec_item == 3);
            
        end

        else
        begin
            add0 <= 0;
            add1 <= 0;
            add2 <= 0;
            add3 <= 0;
        end

    end

end

endmodule