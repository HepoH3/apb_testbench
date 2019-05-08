`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.05.2019 17:22:06
// Design Name: 
// Module Name: apb_pkg
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
package apb_pkg;
    import uvm_pkg::*;
    `include "apb_configuration.sv"
    `include "apb_seq_item.sv"
    `include "apb_sequence.sv"
    `include "apb_sequencer.sv"
    `include "apb_driver.sv"
    `include "apb_monitor.sv"
    `include "apb_agent.sv"
    `include "apb_subscriber.sv"
    `include "apb_scoreboard.sv"
    `include "apb_env.sv"
    `include "test.sv"
endpackage: apb_pkg
