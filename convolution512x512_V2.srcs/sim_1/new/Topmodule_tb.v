`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/15 13:25:03
// Design Name: 
// Module Name: Topmodule_tb
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


module Topmodule_tb();
reg i_clk = 0;
reg i_data_valid;
reg i_data_ready;
reg [7:0] i_data;
wire o_data_valid;
wire [7:0] o_data;
    
Topmodule UUT(
    .i_clk(i_clk),
    .i_data_valid(i_data_valid),
    .i_data_ready(i_data_ready),
    .i_data(i_data),
    .o_data_valid(o_data_valid),
    .o_data(o_data)
);

integer cnt = 0;

always #5 i_clk = ~i_clk;

initial begin
    i_data_valid = 1'b0;i_data_ready = 1'b0;i_data = 8'b0;  #10;
    i_data_valid = 1'b1;i_data_ready = 1'b1;
    repeat(512) begin
        repeat(512) begin
            i_data = cnt % 256; #10;
            cnt = cnt + 1;
        end
    end
    i_data_valid = 1'b0;i_data_ready = 1'b0;
    #200;$finish;
end
endmodule
