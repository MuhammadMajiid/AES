
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
    clk_tb = 1'b1;
    forever  #10 clk_tb = ~ clk_tb;
end

initial 
begin
    rst_n_tb = 1'b0;
    start_tb = 1'b0;
    #10;
    rst_n_tb = 1'b1;
    start_tb = 1'b1;
end

initial 
begin
    plain_text_tb = 128'h0000_0101_0303_0707_0f0f_1f1f_3f3f_7f7f;
    key_tb = 128'h0000_0000_0000_0000_0000_0000_0000_0000;
    #230;
    if(enc_data_tb == 128'hc7d1_2419_489e_3b62_33a2_c5a7_f456_3172)
    begin
        $display("Encoded is done succesfully!      Encrypted data is: %h ", enc_data_tb);
    end
    else
    begin
        $display("Encoded failed!");
    end
    
    plain_text_tb = 128'h1234_abcd_5678_efef_910a_1fe2_893f_7abb;
    key_tb = 128'h4500_6000_00ff_ab00_cb00_bddd_0056_6644;
    #240;
    if(enc_data_tb == 128'h98e8_f827_e554_4bdf_58d4_2211_47dc_2b28)
    begin
        $display("Encoded is done succesfully!      Encrypted data is: %h ", enc_data_tb);
    end
    else
    begin
        $display("Encoded failed!");
    end
end

endmodule