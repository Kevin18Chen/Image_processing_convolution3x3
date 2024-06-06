`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/15 13:41:24
// Design Name: 
// Module Name: conv
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


module conv(
    input i_data_valid,
    input [2:0] i_en,
    input [23:0] i_data_0,
    input [23:0] i_data_1,
    input [23:0] i_data_2,
    output [7:0] o_data
    );

reg [9:0] sumdata_0;
reg [9:0] sumdata_1;
reg [9:0] sumdata_2;
/*
integer sumdata_0;
integer sumdata_1;
integer sumdata_2;
*/
assign o_data = ((sumdata_0 + sumdata_1 + sumdata_2 < 0) ? 0:(sumdata_0 + sumdata_1 + sumdata_2))/9;

reg [7:0] kernel[8:0];
//integer kernel[8:0];

initial begin
    kernel[0] = 1;
    kernel[1] = 1;
    kernel[2] = 1;
    kernel[3] = 1;
    kernel[4] = 1;
    kernel[5] = 1;
    kernel[6] = 1;
    kernel[7] = 1;
    kernel[8] = 1;

end

always  @(*)    begin
    if(i_data_valid)
        case(i_en)
            4'd1:   begin
                sumdata_0 <= i_data_2[7:0] * kernel[8] + i_data_2[15:8] * kernel[7] + i_data_2[23:16] * kernel[6];
                sumdata_1 <= i_data_0[7:0] * kernel[2] + i_data_0[15:8] * kernel[1] + i_data_0[23:16] * kernel[0];
                sumdata_2 <= i_data_1[7:0] * kernel[5] + i_data_1[15:8] * kernel[4] + i_data_1[23:16] * kernel[3];
            end
            4'd2:   begin
                sumdata_0 <= i_data_1[7:0] * kernel[5] + i_data_1[15:8] * kernel[4] + i_data_1[23:16] * kernel[3];
                sumdata_1 <= i_data_2[7:0] * kernel[8] + i_data_2[15:8] * kernel[7] + i_data_2[23:16] * kernel[6];
                sumdata_2 <= i_data_0[7:0] * kernel[2] + i_data_0[15:8] * kernel[1] + i_data_0[23:16] * kernel[0];
            end
            4'd4:   begin
                sumdata_0 <= i_data_0[7:0] * kernel[2] + i_data_0[15:8] * kernel[1] + i_data_0[23:16] * kernel[0];
                sumdata_1 <= i_data_1[7:0] * kernel[5] + i_data_1[15:8] * kernel[4] + i_data_1[23:16] * kernel[3];
                sumdata_2 <= i_data_2[7:0] * kernel[8] + i_data_2[15:8] * kernel[7] + i_data_2[23:16] * kernel[6];
            end
        endcase
end
endmodule
