`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 06.05.2019 14:58:56
// Design Name:
// Module Name: apb_agent
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
import uvm_pkg::*;
class apb_agent extends uvm_agent;
    `uvm_component_utils(apb_agent)
    uvm_analysis_port#(apb_seq_item) apb_ap;

    apb_sequencer   apb_seq;
    apb_driver      apb_drv;
    apb_monitor     apb_mon;

    function new(string name, uvm_component parent);
        super.new(name,parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        apb_ap  = new(.name("apb_ap"), .parent(this));
        apb_seq = apb_sequencer ::type_id::create(.name("apb_seq"), .parent(this) );
        apb_drv = apb_driver    ::type_id::create(.name("apb_drv"), .parent(this) );
        apb_mon = apb_monitor   ::type_id::create(.name("apb_mon"), .parent(this) );
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        apb_drv.seq_item_port.connect(apb_seq.seq_item_export);
        apb_mon.apb_ap.connect(apb_ap);
    endfunction: connect_phase
endclass: apb_agent
