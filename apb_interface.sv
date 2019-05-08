`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 30.04.2019 17:12:58
// Design Name:
// Module Name: apb_interface
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


interface apb_if #(  ADDR_WIDTH = 3
            ,  SEL_WIDTH = 2
            ,WRITE_WIDTH = 32
            , READ_WIDTH = WRITE_WIDTH
            )
            (input bit clk, reset_n);

    localparam STRB_WIDTH = WRITE_WIDTH%8? (WRITE_WIDTH/8)+1 : WRITE_WIDTH/8;


    logic [ADDR_WIDTH:0]    addr;
    logic [ 2:0]            prot;
    logic [SEL_WIDTH-1:0]   sel;
    logic                   enable;
    logic                   write;
    logic [WRITE_WIDTH-1:0] wdata;
    logic [STRB_WIDTH-1:0]  strb;
    logic                   ready;
    logic [READ_WIDTH-1:0]  rdata;
    logic                   slv_err;

    clocking master_cb @ (posedge clk);
        default input #3ns output #3ns;
        output addr, prot, sel, enable, write, wdata, strb;
        input reset_n, ready, rdata, slv_err;
    endclocking: master_cb

    clocking slave_cb @(posedge clk);
        default input #3ns output #3ns;
        input reset_n, addr, prot, sel, enable, write, wdata, strb;
        output ready, rdata, slv_err;
    endclocking: slave_cb

    clocking monitor_cb @(posedge clk);
        default input #1ns output #1ns;
        input addr, prot, sel, enable, write, wdata, strb, ready, rdata, slv_err;
    endclocking: monitor_cb

    modport master_mp (input clk, reset_n, ready, rdata, slv_err, output addr, prot, sel, enable, write, wdata, strb);
    modport slave_mp  (input clk, reset_n, addr, prot, sel, enable, write, wdata, strb, output ready, rdata, slv_err);
    modport master_sync_mp (clocking master_cb);
    modport slave_sync_mp  (clocking slave_cb );

endinterface: apb_if
