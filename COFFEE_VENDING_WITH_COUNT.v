module COFFEE_VENDING_WITH_COUNT(clk,rst,coffee,amt,count);
    input clk,rst;
    input [4:0]amt;
    output reg [1:0]coffee;
    output reg [2:0]count=3'b000;
    parameter IDLE = 5'b00000,
              RS5  = 5'b00001,
              RS10 = 5'b00010,
              RS15 = 5'b00011,
              RS20 = 5'b00100;
    reg [4:0]state;
    always @(posedge clk or negedge rst)
    begin
        if(!rst)
        state<=IDLE;
        else
        begin
            case(state)
                IDLE:
                begin
                    coffee<=2'b00;
                    if(amt==5'b00101)
                    state<=RS5;
                    else if(amt==5'b01010)
                    state<=RS10;
                    else if(amt==5'b01111)
                    state<=RS15;
                    else if(amt==5'b10100)
                    state<=RS20;
                    else
                    state<=IDLE;
                end
                RS5:
                begin
                    coffee<=2'b00;
                    if(amt==5'b00101)
                    state<=RS10;
                    else if(amt==5'b01010)
                    state<=RS15;
                    else if(amt==5'b01111)
                    state<=RS20;
                    else
                    state<=RS5;
                end
                RS10:
                begin
                    coffee<=2'b00;
                    if(amt==5'b00101)
                    state<=RS15;
                    else if(amt==5'b01010)
                    state<=RS20;
                    else
                    state<=RS10;
                end
                RS15:
                begin
                    coffee<=2'b00;
                    if(amt==5'b00101)
                    state<=RS20;
                    else
                    state<=RS15;
                end
                RS20:
                begin
                    coffee<=2'b01;
                    state<=IDLE;
                    count=count+1;
                end
                default:
                state<=IDLE;
                endcase
        end
    end
endmodule
    
