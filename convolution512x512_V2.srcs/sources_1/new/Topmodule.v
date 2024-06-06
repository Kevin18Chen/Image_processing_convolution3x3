`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/15 13:05:04
// Design Name: 
// Module Name: Topmodule
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Topmodule(
    input i_clk,
    input i_rst,
    input [7:0] i_data,
    input i_data_valid,
    input i_data_ready, 
    input i_data_last,
    output [7:0] o_data,
    output o_data_valid,
    output o_data_ready,
    output o_data_last
);

wire [2:0] buffer_en;
wire [7:0] ctrl_data;
wire [7:0] tf_data;
wire [23:0] conv_data0;
wire [23:0] conv_data1;
wire [23:0] conv_data2;
wire LB0_valid;
wire LB1_valid;
wire LB2_valid;
wire ctrl_valid;
wire tf_data_valid;
wire LB0_next;
wire LB1_next;
wire LB2_next;
wire next;

assign next = LB0_next | LB1_next | LB2_next;
assign tf_data_valid = ctrl_valid & (LB0_valid | LB1_valid | LB2_valid);

control ctrl(
    .i_clk(i_clk),
    .next(next),
    .i_data_valid(i_data_valid),
    .i_data(i_data),
    .buffer_en(buffer_en),
    .o_data_valid(ctrl_valid),
    .o_data(ctrl_data)
);

linebuffer LB0(
    .i_clk(i_clk),
    .i_en(buffer_en[0]),
    .i_data_ready(i_data_ready),
    .i_data_valid(i_data_valid),
    .i_data(ctrl_data),
    .o_data(conv_data0),
    .o_data_valid(LB0_valid),
    .next(LB0_next)
);

linebuffer LB1(
    .i_clk(i_clk),
    .i_en(buffer_en[1]),
    .i_data_ready(i_data_ready),
    .i_data_valid(i_data_valid),
    .i_data(ctrl_data),
    .o_data(conv_data1),
    .o_data_valid(LB1_valid),
    .next(LB1_next)
);

linebuffer LB2(
    .i_clk(i_clk),
    .i_en(buffer_en[2]),
    .i_data_ready(i_data_ready),
    .i_data_valid(i_data_valid),
    .i_data(ctrl_data),
    .o_data(conv_data2),
    .o_data_valid(LB2_valid),
    .next(LB2_next)
);

conv conv(
    .i_data_valid(tf_data_valid),
    .i_en(buffer_en),
    .i_data_0(conv_data0),
    .i_data_1(conv_data1),
    .i_data_2(conv_data2),
    .o_data(tf_data)
);

fifo_generator_0 FIFO (
  .wr_rst_busy(),        // output wire wr_rst_busy
  .rd_rst_busy(),        // output wire rd_rst_busy
  .s_aclk(i_clk),                  // input wire s_aclk
  .s_aresetn(i_rst),            // input wire s_aresetn
  .s_axis_tvalid(tf_data_valid),    // input wire s_axis_tvalid
  .s_axis_tready(o_data_ready),    // output wire s_axis_tready
  .s_axis_tdata(tf_data),      // input wire [7 : 0] s_axis_tdata
  .s_axis_tlast(i_data_last),      // input wire s_axis_tlast
  .m_axis_tvalid(o_data_valid),    // output wire m_axis_tvalid
  .m_axis_tready(i_data_ready),    // input wire m_axis_tready
  .m_axis_tdata(o_data),      // output wire [7 : 0] m_axis_tdata
  .m_axis_tlast(o_data_last),      // output wire m_axis_tlast
  .axis_prog_full()  // output wire axis_prog_full
);

endmodule