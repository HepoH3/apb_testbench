`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 06.05.2019 16:26:58
// Design Name:
// Module Name: test_bench
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

`include "uvm_macros.svh"
`include "apb_memory.sv"
`include "apb_interface.sv"
import uvm_pkg::*;
module test_bench;
    import apb_pkg::*;
    parameter ADDR_WIDTH    = 3;
    parameter SEL_WIDTH     = 2;
    parameter WRITE_WIDTH   = 32;
    parameter READ_WIDTH    = WRITE_WIDTH;
    bit clk,reset;
    apb_if #(  ADDR_WIDTH
                ,  SEL_WIDTH
                ,WRITE_WIDTH
                , READ_WIDTH
                )apb_intf(clk,~reset);
    apb_memory #(  ADDR_WIDTH
                ,  SEL_WIDTH
                ,WRITE_WIDTH
                , READ_WIDTH
                )DUT(apb_intf.slave_sync_mp);
    initial begin
        clk = 0;
        reset = 1;
        #10ns;
        reset = 0;
       forever #10ns clk = ! clk;
    end

    initial begin
        uvm_config_db#( virtual apb_if )::set
      ( .cntxt(null), .inst_name(""),.field_name("apb_if"),.value(apb_intf));
        run_test("apb_test");
    end
endmodule
