
`timescale 1ns/1ps
module EncTest;

reg          clk_tb;
reg          rst_n_tb;
reg          start_tb;
reg  [0:127] key_tb;
reg  [0:127] plain_text_tb;

wire [0:127] enc_data_tb;
wire         valid_flag_tb;

Encryption enc(
    .clock(clk_tb),
    .reset_n(rst_n_tb),
    .start(start_tb),
    .key(key_tb),
    .plain_text(plain_text_tb),

    .enc_data(enc_data_tb),
    .valid_flag(valid_flag_tb)
);

initial
begin
    $dumpfile("Enc.vcd");
    $dumpvars;
end

initial 
begin
    $monitor($time, ": Data = %h    Encrypted Data = %h  ", plain_text_tb, enc_data_tb);
end

initial 
begin
    clk_tb = 1'b0;
    forever  #10 clk_tb = ~ clk_tb;
end

initial 
begin
    rst_n_tb = 1'b0;
    start_tb = 1'b0;
    #1;
    rst_n_tb = 1'b1;
    #9;
    start_tb = 1'b1;
end

initial 
begin
    plain_text_tb = 128'h0000_0101_0303_0707_0f0f_1f1f_3f3f_7f7f;
    key_tb = 128'h0000_0000_0000_0000_0000_0000_0000_0000;
    #230;
    if(enc_data_tb == 128'hc7d1_2419_489e_3b62_33a2_c5a7_f456_3172)
        $display("Encoded is done succesfully!");
    else
        $display("Encoded failed!");
end

endmodule