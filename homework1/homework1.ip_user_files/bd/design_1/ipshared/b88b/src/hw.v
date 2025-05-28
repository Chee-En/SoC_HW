`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/04/17 22:50:04
// Design Name: 
// Module Name: hw1
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


module hw(
    input wire clk,
    input wire rst,
    input wire start,
    output reg [7:0] led,
    output reg [2:0] led_index
);

    reg [2:0] count;
    reg start_d;
    reg dir; // 方向：0 表示向左移動，1 表示向右移動

    // 偵測 start 的上升沿（避免 SDK 重複觸發）
    wire start_pulse = start & ~start_d;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 3'd0;
            led_index <= 3'd0;
            led <= 8'b11111111;
            start_d <= 1'b0;
            dir <= 1'b0; // 初始為向左移動
        end else begin
            start_d <= start; // 暫存 start

            if (start_pulse) begin
                // 若方向為右（從 LSB -> MSB）
                if (dir == 1'b0) begin
                    if (count == 3'd7) begin
                        dir <= 1'b1; // 到頭後轉方向
                        count <= count - 1;
                    end else begin
                        count <= count + 1;
                    end
                end
                // 若方向為左（從 MSB -> LSB）
                else begin
                    if (count == 3'd0) begin
                        dir <= 1'b0; // 到頭後轉方向
                        count <= count + 1;
                    end else begin
                        count <= count - 1;
                    end
                end

                led_index <= count;
                led <= 8'b00000001 << count;
            end
        end
    end

endmodule


