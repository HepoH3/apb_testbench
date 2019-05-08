`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 30.04.2019 19:43:10
// Design Name:
// Module Name: apb_sequencer
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
class apb_sequencer extends uvm_sequencer#(apb_seq_item);
    `uvm_component_utils(apb_sequencer)
    function new(string name, uvm_component parent = null);
        super.new(name, parent);
    endfunction: new
endclass: apb_sequencer
