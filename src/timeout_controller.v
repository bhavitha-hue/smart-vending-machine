module timeout_controller(
    input clk,
    input rst,
    input enable,
    output reg timeout
);

reg [7:0] counter;
always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        counter <= 8'd0;
        timeout <= 1'b0;
    end

    else if(enable)
    begin
        if(counter == 8'd19)
        begin
            timeout <= 1'b1;
            counter <= 8'd0;
        end
        else
        begin
            counter <= counter + 1'b1;
            timeout <= 1'b0;
        end
    end
    else
    begin
        counter <= 8'd0;
        timeout <= 1'b0;
    end
end

endmodule