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
import uvm_pkg::*;
class apb_test extends uvm_test;
    `uvm_component_utils(apb_test);
    apb_env env;
    function new(string name, uvm_component parent);
        super.new(name,parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        begin
            apb_configuration apb_cfg;
            apb_cfg = new;
            assert(apb_cfg.randomize());
            uvm_config_db#(apb_configuration)::set(.cntxt(this), .inst_name("*"), .field_name("config"), .value(apb_cfg) );
            env = apb_env::type_id::create(.name("env"), .parent(this));
        end
    endfunction: build_phase

    task run_phase(uvm_phase phase);
        apb_sequence apb_seq;
        phase.raise_objection(.obj(this));
        apb_seq = apb_sequence::type_id::create(.name("apb_seq"));
        assert(apb_seq.randomize());
        `uvm_info("apb_test", {"\n",apb_seq.sprint()}, UVM_LOW)
        apb_seq.start(env.agent.apb_seq);
        #1000ns;
        phase.drop_objection(.obj(this));
    endtask: run_phase
endclass: apb_test
