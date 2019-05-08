`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 06.05.2019 16:19:19
// Design Name:
// Module Name: apb_env
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
class apb_env extends uvm_env;
    `uvm_component_utils(apb_env)

    apb_agent       agent;
    apb_fc_subs     fc_sub;
    apb_scoreboard  sco;

    function new(string name, uvm_component parent);
        super.new(name,parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agent   = apb_agent     ::type_id::create(.name("agent")    , .parent(this));
        fc_sub  = apb_fc_subs#()::type_id::create(.name("fc_sub")   , .parent(this));
        sco     = apb_scoreboard::type_id::create(.name("sco")      , .parent(this));
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        agent.apb_ap.connect(fc_sub.analysis_export);
        agent.apb_ap.connect(sco.apb_analysis_export);
    endfunction: connect_phase
endclass: apb_env
