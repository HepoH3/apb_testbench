`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 06.05.2019 15:22:40
// Design Name:
// Module Name: apb_subscriber
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
class apb_fc_subs#(  ADDR_WIDTH = 3
            ,  SEL_WIDTH = 2
            ,WRITE_WIDTH = 32
            , READ_WIDTH = WRITE_WIDTH
            ) extends uvm_subscriber#(apb_seq_item);
    `uvm_component_utils(apb_fc_subs);
    apb_seq_item trans;
    covergroup apb_cg;
        address: coverpoint trans.addr {
            bins low    = {0, 1 << ADDR_WIDTH/4 - 1};
            bins med    = {1 << ADDR_WIDTH/4, 1 << ADDR_WIDTH/2 - 1};
            bins high   = {1 << ADDR_WIDTH/2, 1 << ADDR_WIDTH - 1};
        }
        select: coverpoint trans.sel;
        prot:   coverpoint trans.prot;
        wdata:  coverpoint trans.wdata;// iff(write);
        strb:   coverpoint trans.strb;// iff(write);
        rw:  coverpoint trans.write{
            bins read   = {0};
            bins write  = {1};
        }
    endgroup: apb_cg

    function new(string name, uvm_component parent);
        super.new(name,parent);
        apb_cg = new();
    endfunction: new

    function void write(apb_seq_item t);
        trans = t;
        apb_cg.sample();
    endfunction: write
endclass: apb_fc_subs

typedef class apb_scoreboard;
class apb_sb_subs extends uvm_subscriber#(apb_seq_item);
    `uvm_component_utils(apb_sb_subs)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void write(apb_seq_item t);
        apb_scoreboard apb_sb;
        $cast(apb_sb, m_parent);
        apb_sb.apb_check(t);
    endfunction: write
endclass: apb_sb_subs
