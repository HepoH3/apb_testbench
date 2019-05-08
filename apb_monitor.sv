`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 06.05.2019 13:44:07
// Design Name:
// Module Name: apb_monitor
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
class apb_monitor extends uvm_monitor;
    `uvm_component_utils(apb_monitor);
    uvm_analysis_port#(apb_seq_item) apb_ap;
    virtual apb_if apb_vi;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        void'(uvm_resource_db#(virtual apb_if)::read_by_name(.scope("ifs"), .name("apb_if"), .val(apb_vi) ) );
        apb_ap = new(.name("apb_ap"), .parent(this));
    endfunction: build_phase

    task run_phase(uvm_phase phase);
        forever begin
            apb_seq_item trans;
            // assert property(@apb_vi.monitor_cb |apb_vi.monitor_cb.sel |=> apb_vi.monitor_cb.enable)
            // else $error("Err at apb start");
            //
            // assert property(@apb_vi.monitor_cb apb_vi.monitor_cb.enable |-> ##[0:16] apb_vi.monitor.ready)
            // else $error("Err at apb mid");
            //
            // assert property(@apb_vi.monitor_cb apb_vi.monitor_cb.ready |=> !apb_vi.monitor_cb.enable)
            // else $error("Err at apb finish");

            // while(!(apb_vi.monitor_cb.enable && apb_vi.monitor_cb.ready))begin
            //     @apb_vi.monitor_cb;
            // end
            trans = apb_seq_item#()::type_id::create(.name("trans"));
            trans.addr      <= apb_vi.monitor_cb.addr;
            trans.prot      <= apb_vi.monitor_cb.prot;
            trans.sel       <= apb_vi.monitor_cb.sel;
            trans.write     <= apb_vi.monitor_cb.write;
            trans.wdata     <= apb_vi.monitor_cb.wdata;
            trans.strb      <= apb_vi.monitor_cb.strb;
            trans.rdata     <= apb_vi.monitor_cb.rdata;
            trans.slv_err   <= apb_vi.monitor_cb.slv_err;
            uvm_report_info("APB_MONITOR", $psprintf("Got Transaction %s", trans.convert2string()));
            apb_ap.write(trans);
        end
    endtask: run_phase
endclass: apb_monitor
