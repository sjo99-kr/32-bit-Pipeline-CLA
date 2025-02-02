`timescale 1ns / 1ps

module cla_16bit(
    input [15:0] in_1,
    input [15:0] in_2,
    input       i_clk,
    input       c_in,
    
    output [15:0] sum,
    output      c_out
    );
    
    wire [15:0] a, b;
    
    wire [3:0] sum_4_1, sum_4_2, sum_4_3, sum_4_4;
    wire [3:0] sum_8_1, sum_8_2, sum_8_3;
    wire [3:0] sum_12_1, sum_12_2;
    
    wire        c_1, c_2, c_3, c_4;
    wire c_1_reg, c_2_reg, c_3_reg;
    
    // calculation for 4-bits 
    wire [3:0] sum1;
    FF_16bit FF_1_1(.i_clk(i_clk), .i_data(in_1), .o_data(a));
    FF_16bit FF_1_2(.i_clk(i_clk), .i_data(in_2), .o_data(b));
    
    cla_4bit CLA0   (.a(a[3:0]), .b(b[3:0]), .c_in(c_in), .sum(sum_4_1), .c_out(c_1));
    
    FF_carry FF_2_1 (.i_clk(i_clk), .i_data(c_1), .o_data(c_1_reg));
    
    FF_4bit  FF_2_2 (.i_clk(i_clk), .i_data(sum_4_1), .o_data(sum_4_2));
    FF_4bit  FF_3_1 (.i_clk(i_clk), .i_data(sum_4_2), .o_data(sum_4_3));
    FF_4bit  FF_4_1 (.i_clk(i_clk), .i_data(sum_4_3), .o_data(sum_4_4));
    FF_4bit  FF_5_1 (.i_clk(i_clk), .i_data(sum_4_4), .o_data(sum1));
    
    wire [3:0] reg_a_4_7, reg_b_4_7;
    wire [3:0] sum2;
    
    // calculation for 4-bits 
    FF_4bit FF2_3   (.i_clk(i_clk), .i_data(a[7:4]), .o_data(reg_a_4_7));
    FF_4bit FF2_4   (.i_clk(i_clk), .i_data(b[7:4]), .o_data(reg_b_4_7));
    
    cla_4bit CLA1   (.a(reg_a_4_7), .b(reg_b_4_7), .c_in(c_1_reg), .sum(sum_8_1), .c_out(c_2));
    
    FF_carry FF3_2  (.i_clk(i_clk), .i_data(c_2), .o_data(c_2_reg));
     
    FF_4bit  FF3_3   (.i_clk(i_clk), .i_data(sum_8_1), .o_data(sum_8_2));
    FF_4bit  FF4_2   (.i_clk(i_clk), .i_data(sum_8_2), .o_data(sum_8_3));
    FF_4bit  FF5_2   (.i_clk(i_clk), .i_data(sum_8_3), .o_data(sum2));
    
    wire [3:0] reg_a_8_11_1, reg_b_8_11_1;
    wire [3:0] reg_a_8_11_2, reg_b_8_11_2;
    wire [3:0] sum3;
    
    // calculation for 4-bits 
    FF_4bit FF2_5   (.i_clk(i_clk), .i_data(a[11:8]), .o_data(reg_a_8_11_1));
    FF_4bit FF2_6   (.i_clk(i_clk), .i_data(b[11:8]), .o_data(reg_b_8_11_1));
    FF_4bit FF3_4   (.i_clk(i_clk), .i_data(reg_a_8_11_1), .o_data(reg_a_8_11_2));
    FF_4bit FF3_5   (.i_clk(i_clk), .i_data(reg_b_8_11_1), .o_data(reg_b_8_11_2));
    
    cla_4bit CLA2   (.a(reg_a_8_11_2), .b(reg_b_8_11_2), .c_in(c_2_reg), .sum(sum_12_1), .c_out(c_3));
    
    FF_carry FF4_3  (.i_clk(i_clk), .i_data(c_3), .o_data(c_3_reg));
    
    FF_4bit  FF4_4  (.i_clk(i_clk), .i_data(sum_12_1), .o_data(sum_12_2));
    FF_4bit  FF5_3  (.i_clk(i_clk), .i_data(sum_12_2), .o_data(sum3));

    
    wire [3:0] reg_a_12_15_1, reg_a_12_15_2, reg_a_12_15_3;
    wire [3:0] reg_b_12_15_1, reg_b_12_15_2, reg_b_12_15_3;
    wire [3:0] sum4;
    wire carry_out;
    wire [3:0] sum_16_1;
    
    // calculation for 4-bits 
    FF_4bit FF2_7   (.i_clk(i_clk), .i_data(a[15:12]), .o_data(reg_a_12_15_1));
    FF_4bit FF2_8   (.i_clk(i_clk), .i_data(b[15:12]), .o_data(reg_b_12_15_1));
    FF_4bit FF3_6   (.i_clk(i_clk), .i_data(reg_a_12_15_1), .o_data(reg_a_12_15_2));
    FF_4bit FF3_7   (.i_clk(i_clk), .i_data(reg_b_12_15_1), .o_data(reg_b_12_15_2));
    FF_4bit FF4_5   (.i_clk(i_clk), .i_data(reg_a_12_15_2), .o_data(reg_a_12_15_3));
    FF_4bit FF4_6   (.i_clk(i_clk), .i_data(reg_b_12_15_2), .o_data(reg_b_12_15_3));
    
    cla_4bit CLA_3  (.a(reg_a_12_15_3), .b(reg_b_12_15_3), .c_in(c_3_reg), .sum(sum_16_1), .c_out(c_4));
    FF_4bit FF5_4   (.i_clk(i_clk), .i_data(sum_16_1), .o_data(sum4));
    FF_4bit FF5_5   (.i_clk(i_clk), .i_data(c_4), .o_data(carry_out));
    
    assign c_out = carry_out;
    assign sum = {sum4, sum3, sum2, sum1};

endmodule
