`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:48:57 11/25/2019 
// Design Name: 
// Module Name:    memory_testBench 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module memory_testBench(clk,rst,din,wr_en,rd_en,dout,full,wr_ack,empty,valid,data_count
    );
	input clk;
	input rst;
	input [57 : 0] din;
	input wr_en;
	input rd_en;
	output [57 : 0] dout;
	output full;
	output wr_ack;
	output empty;
	output valid;
	output [8 : 0] data_count;
	

memoria_fifo test (
  .clk(clk), // input clk
  .rst(rst), // input rst
  .din(din), // input [57 : 0] din
  .wr_en(wr_en), // input wr_en
  .rd_en(rd_en), // input rd_en
  .dout(dout), // output [57 : 0] dout
  .full(full), // output full
  .wr_ack(wr_ack), // output wr_ack
  .empty(empty), // output empty
  .valid(valid), // output valid
  .data_count(data_count) // output [8 : 0] data_count
);



endmodule
