`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/15 11:42:32
// Design Name: 
// Module Name: control_tb
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


module control_tb();
reg i_clk = 0;
reg next;
reg i_data_valid;
reg [7:0] i_data;
wire [2:0] buffer_en;
wire o_data_valid;
wire [7:0] o_data;

control UUT(
    .i_clk(i_clk),
    .next(next),
    .i_data_valid(i_data_valid),
    .i_data(i_data),
    .buffer_en(buffer_en),
    .o_data_valid(o_data_valid),
    .o_data(o_data)
);

always #5 i_clk = ~i_clk;

initial begin
    next = 1'b0;i_data_valid = 1'b0;i_data = 8'b0;  #10;
    i_data_valid = 1'b1;
    repeat(512) begin
        repeat(511) begin
            i_data = {$random} % 256;   #10;
        end
        i_data = {$random} % 256; next = 1'b1;  #10;
        next = 1'b0;
    end
    i_data_valid = 1'b0;
    #100;$finish;
end
endmodule
