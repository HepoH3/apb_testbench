`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 06.05.2019 17:30:56
// Design Name:
// Module Name: apb_memory
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


module apb_memory #( parameter ADDR_WIDTH
                    ,parameter SEL_WIDTH
                    ,parameter WRITE_WIDTH
                    ,parameter READ_WIDTH
                   )
                   (apb_if.slave_mp apb_intf);
    localparam IDLE = 2'd0;
    localparam WRITE= 2'd1;
    localparam READ = 2'd2;

    bit [1:0] state;

    bit [ADDR_WIDTH-1:0]addr;
    bit [WRITE_WIDTH-1:0]data[1<<ADDR_WIDTH];
    initial begin
        state = 0;
    end

    always@(apb_intf.clk) begin
    if(!apb_intf.reset_n) state <= IDLE;
    else
        case(state)
        IDLE:   if(apb_intf.sel != 0) begin
                    if(apb_intf.write)begin
                        state <= WRITE;
                    end
                    else begin
                        state <= READ;
                        apb_intf.rdata <= data[apb_intf.addr];
                    end
                    apb_intf.ready <= 1;
                end
        WRITE:  if(apb_intf.enable) begin
                    data[apb_intf.addr] <= apb_intf.wdata;
                    apb_intf.ready <= 0;
                    state <= IDLE;
                end
        READ:   if(apb_intf.enable) begin
                    apb_intf.slv_err <= 0;
                    state <= IDLE;
                end
        default: state <= IDLE;
        endcase
    end
endmodule
