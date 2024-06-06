`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/14 13:09:47
// Design Name: 
// Module Name: linebuffer
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


module linebuffer(
    input i_clk,
    input i_en,
    input i_data_ready,
    input i_data_valid,
    input [7:0] i_data,
    output reg [23:0] o_data,
    output reg o_data_valid,
    output reg next
    );
    
reg [7:0] BUFF[511:0];
reg [9:0] addr;
 
always @(posedge i_clk) begin
    if(!i_data_valid)    begin
        addr <= -10'd1;
        o_data_valid <= 1'b0;
        o_data <= 24'd0;
        next <= 1'b0;
    end
    else    begin
        if(i_en)
            BUFF[addr] = i_data;
        if(addr == 0 || addr == 1) begin
            o_data_valid <= 1'b0;
            o_data <= 24'd0;
        end
        else    begin
            o_data_valid <= 1'b1;
            o_data <= {BUFF[addr - 2],BUFF[addr - 1],BUFF[addr]};
        end

        if(i_data_ready)    begin
            if(addr == 511) begin
                addr <= 10'd0;
                next <= 1'b1;
            end
            else    begin
                addr <= addr + 1;
                next <= 1'b0;
            end
        end
        else
            addr <= addr;
    end
end
endmodule
