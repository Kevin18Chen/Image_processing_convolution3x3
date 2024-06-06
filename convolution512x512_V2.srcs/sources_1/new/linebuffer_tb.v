`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/14 13:11:58
// Design Name: 
// Module Name: linebuffer_tb
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


module linebuffer_tb();
reg i_clk = 0;
reg i_en;
reg i_data_ready;
reg i_data_valid;
reg [7:0] i_data;
wire [23:0] o_data;
wire o_data_valid;
wire next;

linebuffer UUT(
    .i_clk(i_clk),
    .i_en(i_en),
    .i_data_ready(i_data_ready),
    .i_data_valid(i_data_valid),
    .i_data(i_data),
    .o_data(o_data),
    .o_data_valid(o_data_valid),
    .next(next)
);
integer cnt = 0;

always #5 i_clk = ~i_clk;

initial begin
    i_en = 1'b0;i_data_valid = 1'b0;i_data_ready = 1'b0;i_data = 8'b0; #10;
    i_en = 1'b1;i_data_valid = 1'b1;i_data_ready = 1'b1;
    repeat(512) begin
        i_data = cnt;   #10;
        cnt = cnt + 1;
    end
    i_en = 1'b0;i_data_valid = 1'b1;i_data_ready = 1'b1;
    repeat(512) #10;
    #50;
    $finish;
end
endmodule

