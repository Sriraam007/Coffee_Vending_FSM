module COFFEE_BALANCE(clk,rst,coffee,amt,count,balance);
    input clk,rst;
    input [5:0]amt;
    output reg [1:0]coffee;
    output reg [2:0]count=3'b000;
    output reg [5:0]balance=3'b000000;
    parameter IDLE = 6'b000000,
              RS5  = 6'b000001,
              RS10 = 6'b000010,
              RS15 = 6'b000011,
              RS20 = 6'b000100;
    reg [5:0]state;
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
                    if(amt==6'b000101)
                    state<=RS5;
                    else if(amt==6'b001010)
                    state<=RS10;
                    else if(amt==6'b001111)
                    state<=RS15;
                    else if(amt==6'b010100)
                    state<=RS20;
                    else
                    state<=IDLE;
                end
                RS5:
                begin
                    coffee<=2'b00;
                    if(amt==6'b000101)
                    state<=RS10;
                    else if(amt==6'b001010)
                    state<=RS15;
                    else if(amt==6'b001111)
                    state<=RS20;
                    else
                    state<=RS5;
                end
                RS10:
                begin
                    coffee<=2'b00;
                    if(amt==6'b000101)
                    state<=RS15;
                    else if(amt==6'b001010)
                    state<=RS20;
                    else
                    state<=RS10;
                end
                RS15:
                begin
                    coffee<=2'b00;
                    if(amt==6'b000101)
                    state<=RS20;
                    else
                    state<=RS15;
                end
                RS20:
                begin
                    coffee<=2'b01;
                    state<=IDLE;
                    count<=count+1;
                    
                end
                default:
                begin
                    balance <= ((amt)+(6'b101100));
                    state<=RS20;
                end
                endcase
        end
    end
endmodule
    
