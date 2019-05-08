`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 06.05.2019 15:57:01
// Design Name:
// Module Name: apb_scoreboard
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
class apb_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(apb_scoreboard)

    uvm_analysis_export#(apb_seq_item) apb_analysis_export;

    local apb_sb_subs sb_sub;

    function new(string name, uvm_component parent);
        super.new(name,parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        apb_analysis_export = new(.name("apb_analysis_export"), .parent(this));
        sb_sub = apb_sb_subs::type_id::create(.name("sb_sub"), .parent(this));
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        apb_analysis_export.connect(sb_sub.analysis_export);
    endfunction: connect_phase

    virtual function void apb_check(apb_seq_item trans);
        `uvm_info("SCOREBOARD","Dummy check",UVM_LOW);
    endfunction: apb_check
endclass: apb_scoreboard
