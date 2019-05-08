`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.05.2019 17:12:14
// Design Name: 
// Module Name: apb_configuration
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
class apb_configuration extends uvm_object;
   `uvm_object_utils( apb_configuration )

   function new( string name = "" );
      super.new( name );
   endfunction: new
endclass: apb_configuration
