`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 30.04.2019 19:28:40
// Design Name:
// Module Name: apb_sequence
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
class apb_sequence extends uvm_sequence#(apb_seq_item);
    `uvm_object_utils(apb_sequence)

    function new(string name = "");
        super.new(name);
    endfunction: new

    // task body();
    //     req = apb_seq_item#()::type_id::create("ap_it");
    //     wait_for_grant();
    //     assert(req.randomize());
    //     send_request(req);
    //     wait_for_item_done();
    //     get_response(rsp);
    // endtask: body
    task body();
        apb_seq_item trans;
        forever begin
            trans = apb_seq_item#()::type_id::create("ap_it");
            start_item(trans);
            assert(trans.randomize());
            finish_item(trans);
        end
    endtask: body
endclass: apb_sequence
