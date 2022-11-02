`timescale 1ns/1ps
module KeyExpTest;

reg          clk_tb;
reg  [3:0]   round_num_tb;
reg  [0:127] key_tb;

wire [0:127] round_key_tb;

KeyExpansion kexp(
    .clk(clk_tb),
    .round_num(round_num_tb),
    .key(key_tb),

    .round_key(round_key_tb)
);

initial
begin
    $dumpfile("KeyExp.vcd");
    $dumpvars;
end

initial 
begin
    $monitor($time, ": Key = %h      Round No. = %d    Round Key = %h  ",  key_tb, round_num_tb, round_key_tb);
end

initial 
begin
    clk_tb = 1'b0;
    forever  #10 clk_tb = ~ clk_tb;
end

initial 
begin
    key_tb = 128'h0000_0000_0000_0000_0000_0000_0000_0000;
    round_num_tb = 4'd0;
    #10;
    repeat(11)
    begin
        #20;
        key_tb = round_key_tb;
        round_num_tb = round_num_tb + 4'd1;
    end
    if(round_key_tb == (128'hb4ef_5bcb_3e92_e211_23e9_51cf_6f8f_188e))
        $display("Key Expansion process succeeded!");
    else
        $display("Key Expansion process failed!");
end

endmodule