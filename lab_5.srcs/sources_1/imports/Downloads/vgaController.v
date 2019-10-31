`timescale 1ns / 1ps

`define MAX_HCOUNT      799
`define MAX_VCOUNT      524
`define HSYNC_LOW_BEGIN 659
`define HSYNC_LOW_END   755
`define VSYNC_LOW_BEGIN 493
`define VSYNC_LOW_END   494

`define BLACK           8'h00
`define BLUE            8'h01
`define BROWN           8'h02
`define CYAN            8'h04
`define RED             8'h08
`define MAGENTA         8'h10
`define YELLOW          8'h20
`define WHITE           8'h40

module vgaController(
    CLK,
    pixelClk,
    pixel_color,
    drawSnake,
    hsync,
    vsync,
    R,
    G,
    B,
    hcount,
    vcount
    );
    
    input               CLK, pixelClk, drawSnake;
    input [7:0]         pixel_color;
    output reg   [9:0]  hcount,
                        vcount;
    reg			        visible;
    output reg          hsync,
                        vsync;
//    output reg [3:0]    Ro,
//                        Go,
//                        Bo;
    output reg [3:0]           R,
                        G,
                        B;
    
    initial begin
        hcount <= 0;
        vcount <= 0;
        visible <= 1;
    end
    
//    DFF ffR(.D(R), .CLK(CLK), .Q(Ro), .QN());
//    DFF ffG(.D(G), .CLK(CLK), .Q(Go), .QN());
//    DFF ffB(.D(B), .CLK(CLK), .Q(Bo), .QN());
    
    always @(posedge pixelClk) begin
        if ((hcount < 640) && (vcount < 480)) begin
            visible <= 1;
        end
        else begin
            visible <= 0;
        end
        
        if (hcount < `MAX_HCOUNT) begin
            if ((hcount < `HSYNC_LOW_BEGIN) || (hcount > `HSYNC_LOW_END)) begin
                hsync <= 1;
            end
            else begin
                hsync <= 0;
            end
            
            hcount <= hcount + 1;
        end
        else begin
            hcount <= 0;
            
            if ((vcount < `VSYNC_LOW_BEGIN) || (vcount > `VSYNC_LOW_END)) begin
                vsync <= 1;
            end
            else begin
            	vsync <= 0;
            end
            
            if (vcount <  `MAX_VCOUNT) begin
                vcount <= vcount + 1;
            end
            else begin
                vcount <= 0;
            end
        end
        
        if (visible) begin
            if(drawSnake) begin
                if(pixel_color == `BLUE) begin
                    R <= 4'hF;
                    G <= 4'h0;
                    B <= 4'h0;
                end
                else begin
                    R <= 4'h0;
                    G <= 4'h0;
                    B <= 4'hF;
                end
            end
            else begin
                // Determines what color to output to the screen
                case(pixel_color)
                    `BLACK: begin
                        R <= 4'hF;
                        G <= 4'hF;
                        B <= 4'hF;
                    end
                    `BLUE: begin
                        R <= 4'h0;
                        G <= 4'h0;
                        B <= 4'hF; // xFF -> xF
                    end
                    `BROWN: begin
                        R <= 4'h9;
                        G <= 4'h4;
                        B <= 4'h1;
                    end
                    `CYAN: begin
                        R <= 4'h0;
                        G <= 4'hF;
                        B <= 4'hF;
                    end
                    `RED: begin // Red
                        R <= 4'hF;
                        G <= 4'h0;
                        B <= 4'h0;
                    end
                    `MAGENTA: begin
                        R <= 4'h8; // x8B -> x8
                        G <= 4'h0;
                        B <= 4'h8;
                    end
                    `YELLOW: begin
                        R <= 4'hF;
                        G <= 4'hF;
                        B <= 4'h0;
                    end
                    `WHITE: begin // White
                        R <= 4'hF;
                        G <= 4'hF;
                        B <= 4'hF;
                    end
                    default: begin
                        R <= 4'hF;
                        G <= 4'hF;
                        B <= 4'hF;
                    end
                endcase
            end
        end
        else begin
            R <= 4'h0;
            G <= 4'h0;
            B <= 4'h0;
        end
        
        // End of always block
    end
endmodule
