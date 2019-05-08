`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 06.05.2019 11:23:17
// Design Name:
// Module Name: apv_driver
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
class apb_driver extends uvm_driver#(apb_seq_item);
    `uvm_component_utils(apb_driver)
    virtual apb_if apb_vi;
    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        void'(uvm_resource_db#(virtual apb_if)::read_by_name
        (.scope("ifs"), .name("apb_if"), .val(apb_vi) ) );
    endfunction: build_phase

    task run_phase(uvm_phase phase);
        apb_seq_item trans;
        //super.run_phase(phase);
        apb_vi.master_cb.sel    <= 0;
        apb_vi.master_cb.enable <= 1'b0;
        forever begin
            seq_item_port.get_next_item(trans);
            uvm_report_info("APB_DRIVER ", $psprintf("Got Transaction %s",trans.convert2string()));
            @apb_vi.master_cb;
            apb_vi.master_cb.addr   <= trans.addr;
            apb_vi.master_cb.sel    <= trans.sel;
            apb_vi.master_cb.prot   <= trans.prot;
            if(trans.write)begin
                apb_vi.master_cb.write  <= 1'b1;
                //apb_vi.master_cb.wdata  <= trans.wdata;
                apb_vi.master_cb.strb   <= trans.strb;
                @apb_vi.master_cb;
                apb_vi.master_cb.enable <= 1'b1;
                // while(!apb_vi.master_cb.ready)begin
                //     @apb_vi.master_cb;
                // end
            end
            else begin
                apb_vi.master_cb.write  <= 1'b0;
                @apb_vi.master_cb;
                apb_vi.master_cb.enable <= 1'b1;
                // while(!apb_vi.master_cb.ready)begin
                //     @apb_vi.master_cb;
                // end
                trans.rdata     <= apb_vi.master_cb.rdata;
                trans.slv_err   <= apb_vi.master_cb.slv_err;
            end
            apb_vi.master_cb.sel    <= 0;
            apb_vi.master_cb.enable <= 1'b0;
            seq_item_port.item_done();
        end
    endtask: run_phase

    // task write;
    //     apb_vi.master_cb.write  <= 1'b1;
    //     apb_vi.master_cb.wdata  <= trans.wdata;
    //     apb_vi.master_cb.strb   <= trans.strb;
    //     @apb_vi.master_cb;
    //     apb_vi.master_cb.enable <= 1'b1;
    //     while(!apb_vi.master_cb.ready)begin
    //         @apb_vi.master_cb;
    //     end
    // endtask: write
    //
    // task read;
    //     apb_vi.master_cb.write  <= 1'b0;
    //     @apb_vi.master_cb;
    //     apb_vi.master_cb.enable <= 1'b1;
    //     while(!apb_vi.master_cb.ready)begin
    //         @apb_vi.master_cb;
    //     end
    //     trans.wdata     <= apb_vi.master_cb.wdata;
    //     trans.slv_err   <= apb_vi.master_cb.slv_err;
    // endtask: read
endclass: apb_driver
