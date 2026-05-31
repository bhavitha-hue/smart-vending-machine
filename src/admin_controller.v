module admin_controller(
    input clk,
    input rst,
    input admin_unlock,
    input refill_stock,
    input fraud_detected,

    output reg machine_enable,
    output reg refill_enable
);
always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        machine_enable <= 1'b1;
        refill_enable  <= 1'b0;
    end
    else
    begin
        refill_enable <= 1'b0;
        if(fraud_detected)
            machine_enable <= 1'b0;
        if(admin_unlock)
            machine_enable <= 1'b1;
        if(refill_stock)
            refill_enable <= 1'b1;

    end
end

endmodule