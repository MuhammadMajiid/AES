`timescale 1ns/1ps
module RndTest;

reg rst_tb;
reg clk_tb;
reg start_tb;
reg [0:127] text_tb;
reg [0:127] rnd_key_tb;

wire valid_flag_tb;
wire [3:0] rnd_num_tb;
wire [0:127] enc_tb;

Rounds rnds(
    .reset_n(rst_tb),
    .clk(clk_tb),
    .start(start_tb),
    .plain_text(text_tb),
    .round_key(rnd_key_tb),

    .enc_data(enc_tb),
    .round_num(rnd_num_tb),
    .valid_flag(valid_flag_tb)
);

initial
begin
    $dumpfile("Rnds.vcd");
    $dumpvars;
end

initial 
begin
    $monitor($time, ": Round Num. = %d     Data = %h    Encrypted Data = %h  ",rnd_num_tb ,text_tb, enc_tb);
end

initial 
begin
    clk_tb = 1'b0;
    forever  #10 clk_tb = ~ clk_tb;
end

initial 
begin
    rst_tb = 1'b0;
    start_tb = 1'b0;
    #1;
    rst_tb = 1'b1;
    start_tb = 1'b1;
end

initial 
begin
    text_tb = 128'h0000_0101_0303_0707_0f0f_1f1f_3f3f_7f7f;
    rnd_key_tb = 128'h0000_0000_0000_0000_0000_0000_0000_0000;

    #30;
    rnd_key_tb = 128'h62636363626363636263636362636363;
    #20;
    rnd_key_tb = 128'h9b9898c9f9fbfbaa9b9898c9f9fbfbaa;
    #20;
    rnd_key_tb = 128'h90973450696ccffaf2f457330b0fac99;
    #20;
    rnd_key_tb = 128'hee06da7b876a1581759e42b27e91ee2b;
    #20;
    rnd_key_tb = 128'h7f2e2b88f8443e098dda7cbbf34b9290;
    #20;
    rnd_key_tb = 128'hec614b851425758c99ff09376ab49ba7;
    #20;
    rnd_key_tb = 128'h217517873550620bacaf6b3cc61bf09b;
    #20;
    rnd_key_tb = 128'h0ef903333ba9613897060a04511dfa9f;
    #20;
    rnd_key_tb = 128'hb1d4d8e28a7db9da1d7bb3de4c664941;
    #20;
    rnd_key_tb = 128'hb4ef5bcb3e92e21123e951cf6f8f188e;
    
end

initial begin
    #210;
    if(enc_tb == 128'hc7d1_2419_489e_3b62_33a2_c5a7_f456_3172)
    begin
        $display("Encoded is done succesfully!");
    end
    else
    begin
        $display("Encoded failed!");
    end
end

endmodule