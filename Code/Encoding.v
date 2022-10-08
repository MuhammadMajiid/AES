//  AUTHOR: Mohamed Maged Elkholy.
//  INFO.: Undergraduate ECE student, Alexandria university, Egypt.
//  AUTHOR'S EMAIL: majiidd17@icloud.com
//  FILE NAME: Encoding.v
//  TYPE: module.
//  DATE: 8/10/2022
//  KEYWORDS: AES Rounds, FSM, Sbox, Mix coloumns, Shift rows, Add Round Key.
//  PURPOSE: An RTL modelling for the AES Top module.

module Encoding 
//-----------------Ports-----------------\\
(
    input  wire clock,
    input  wire reset_n,
    input  wire start,
    input  wire [0:127] plain_text,
    input  wire [0:127] key,

    output reg [0:127] enc_data,
    output reg         valid_flag
);

//-----------------Internal connections-----------------\\
wire [3:0]   round_num_w;
wire [0:127] round_key_w;

//-----------------Design Instances-----------------\\

Rounds rnds(
    .reset_n(reset_n),
    .clk(clock),
    .start(start),
    .plain_text(plain_text),
    .round_key(round_key_w),

    .enc_data(enc_data),
    .round_num(round_num_w),
    .valid_flag(valid_flag)
);

KeyExpansion ke(
    .clk(clock),
    .round_num(round_num_w),
    .key(key),

    .round_key(round_key_w)
);

endmodule