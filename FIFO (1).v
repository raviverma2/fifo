`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.07.2021 00:21:11
// Design Name: 
// Module Name: FIFO
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


module FIFO(
clock, data_In, read, write, enable, data_Out, reset, isEmpty, isFull
    );
//defining input and output
input clock, read,write, enable, reset;
// 16 bits data input
input [15:0] data_In;
output isEmpty, isFull;
//use reg so that output can store some value(internal registers) 16 bits
output reg [15:0] data_Out;
reg [15:0] FIFO [0:9];
//we also need to know about when FIFO is full or Empty for that we require counters
reg [3:0] Count = 0;
reg [3:0] readCount = 0;
reg [3:0] writeCount = 0;

//defining whether empty or full
assign isEmpty = (Count==0)?1'b1:1'b0;
assign isFull = (Count==10)?1'b1:1'b0;

//starting
always @ (posedge clock)
begin
if(enable==0); //checking for enable
else begin
// working of reset
      if(reset)
        begin
        readCount=0;
        writeCount=0;
        end
// reading output
      else if(read==1'b1 && Count!=0) 
         begin
         data_Out = FIFO[readCount];
         readCount = readCount+1;
         end
//writing input
      else if(write==1'b1 && Count<10)
          begin
          FIFO[writeCount]=data_In;
          writeCount= writeCount+1;
          end   
       else;
       end

if(writeCount==10) writeCount=0;
else if(readCount==10) readCount=0;
else;

if(readCount > writeCount) begin
  Count = readCount-writeCount;
  end
else if(readCount<writeCount) begin
  Count=writeCount-readCount;
  end
else;
end
endmodule
   




