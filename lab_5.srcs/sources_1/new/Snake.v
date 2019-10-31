module Snake(Key, btns, CLK, frameClk, Xpos, Ypos, drawSnake);
input CLK, frameClk;
input[7:0] Key;
input[9:0] Xpos, Ypos;
input[4:0] btns;
output drawSnake;
wire Pause, Start, Esc, L, R, U, D;
reg drawSnake, draw;
reg ded, GameOn, paused;
reg[1:0] dir;   //00 up, 01 right, 11 down, 10 left
reg[9:0] SnakeX[127:0];
reg[8:0] SnakeY[127:0];
reg[6:0] len;
reg[7:0] i, j;

KeyDecode kd(Key, btns, Pause, Start, Esc, L, R, U, D);

initial begin
    j <= 0;
    GameOn <= 0;
    draw <= 0;
    drawSnake <= 0;
    len <= 5;
    ded <= 0;
    dir <= 2'b01;
    SnakeX[0] <= 40;
    SnakeX[1] <= 30;
    SnakeX[2] <= 20;
    SnakeX[3] <= 10;
    SnakeX[4] <= 0;
    SnakeY[0] <= 100;
    SnakeY[1] <= 100;
    SnakeY[2] <= 100;
    SnakeY[3] <= 100;
    SnakeY[4] <= 100;
end

//Move Snake and control game
always@(posedge frameClk) begin
    //Read control inputs
    if(Pause) begin
        paused = 1;
    end
    else if(Esc) begin
        GameOn = 0;
    end
    else if(Start && paused) begin
        paused = 0;
    end
    else begin end

    //Game is on going
    if(GameOn && ~ded && ~paused) begin
        //Update Snakes body
        for(i = 127; i > 0; i = i - 1) begin
            if(i < len) begin
                SnakeX[i] <= SnakeX[i - 1];
                SnakeY[i] <= SnakeY[i - 1];
            end
        end
        
        //Update Movement direction
        case(dir)
            2'b00: begin    //Up
                if(L) begin
                    dir = 2'b10;
                end
                else if(R) begin
                    dir = 2'b01;
                end
                else begin end
            end
            2'b01: begin    //Right
                if(U) begin
                    dir = 2'b00;
                end
                else if(D) begin
                    dir = 2'b11;
                end
                else begin end
            end
            2'b10: begin    //Left
                if(U) begin
                    dir = 2'b00;
                end
                else if(D) begin
                    dir = 2'b11;
                end
                else begin end
            end
            2'b11: begin    //Down
                if(L) begin
                    dir = 2'b10;
                end
                else if(R) begin
                    dir = 2'b01;
                end
                else begin end
            end
        endcase
        
        //Move snake in direction
        case(dir)
            2'b00: SnakeY[0] <= SnakeY[0] - 10;  //Up
            2'b01: SnakeX[0] <= SnakeX[0] + 10;  //Right
            2'b10: SnakeX[0] <= SnakeX[0] - 10;  //Left
            2'b11: SnakeY[0] <= SnakeY[0] + 10;  //Down
        endcase
        
        //See if run into wall
        if(((SnakeY[0] == 0) && (dir == 2'b00)) 
            || ((SnakeX[0] == 0) && (dir == 2'b10)) 
            || ((SnakeX[0] == 640) && (dir == 2'b01)) 
            || ((SnakeY[0] == 480) && (dir == 2'b11))) 
        begin
            ded = 1;
        end
        else begin end
    end
    
    //Game is stopped
    else begin 
        //Restart Game
        if(Start && ~paused) begin
            GameOn <= 1;
            len <= 5;
            ded <= 0;
            dir <= 2'b01;
            SnakeX[0] <= 40;
            SnakeX[1] <= 30;
            SnakeX[2] <= 20;
            SnakeX[3] <= 10;
            SnakeX[4] <= 0;
            SnakeY[0] <= 100;
            SnakeY[1] <= 100;
            SnakeY[2] <= 100;
            SnakeY[3] <= 100;
            SnakeY[4] <= 100;
        end
        else begin end
    end
end

//Determine pixel to draw
always@(negedge CLK) begin
    draw = 0;
    for(j = 0; j <= 127; j = j + 1) begin
        if(j < len) begin
            if(SnakeX[j] <= Xpos && SnakeX[j] + 10 > Xpos
                && SnakeY[j] <= Ypos && SnakeY[j] + 10 > Ypos)
            begin
                draw = 1;
            end
            else begin end
        end
        else begin end
    end
    drawSnake = draw;
end
endmodule
