`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/14 18:17:10
// Design Name: 
// Module Name: control
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


module control(
    input i_clk,
    input next,
    input i_data_valid,
    input [7:0] i_data,
    output reg [2:0] buffer_en,
    output reg o_data_valid,
    output reg [7:0] o_data
    );

reg [1:0] statu;
reg key;

always @(negedge i_clk) begin
    if(i_data_valid)
        o_data <= i_data;
    else
        o_data <= 8'b0;
end

always @(negedge i_clk)  begin
    if(i_data_valid)    begin
        if(!next)
            key <= 1'b1;
        if(next & key)    begin
            key <= 1'b0;
            case(statu)
                2'b00:   begin
                    buffer_en <= 3'b001;
                    statu <= 2'b01;
                end
                2'b01:   begin
                    buffer_en <= 3'b010;
                    statu <= 2'b10;
                end
                2'b10:   begin
                    buffer_en <= 3'b100;
                    o_data_valid <= 1'b1;
                    statu <= 2'b00;
                end
            endcase
        end
    end
    else    begin
        statu <= 2'd1;
        key <= 1'b1; 
        buffer_en <= 3'b001;
        o_data_valid <= 1'b0;
    end
end
endmodule
