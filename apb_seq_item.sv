`include "uvm_macros.svh"
import uvm_pkg::*;
class apb_seq_item #(  ADDR_WIDTH = 3
            ,  SEL_WIDTH = 2
            ,WRITE_WIDTH = 32
            , READ_WIDTH = WRITE_WIDTH
            ) extends uvm_sequence_item;
    localparam STRB_WIDTH = WRITE_WIDTH%8? (WRITE_WIDTH/8)+1 : WRITE_WIDTH/8;
    `uvm_object_utils(apb_seq_item)

    // Control information
    rand bit [31:0]            addr;
    rand bit [ 2:0]            prot;
    rand bit [SEL_WIDTH-1:0]   sel;
    rand bit                   write;
         bit                   ready;
    // Payload information
    rand bit [WRITE_WIDTH-1:0] wdata;
    rand bit [STRB_WIDTH-1:0]  strb;
    // Analysis information
         bit [READ_WIDTH-1:0]  rdata;
         bit                   slv_err;
    constraint read_constr {
        write == 0 -> strb == 0;
        sel != 0;
        (sel & (sel-1)) == 0;
    }
    function new(string name = "apb_seq_item");
        super.new(name);
    endfunction: new

    virtual function void do_copy(uvm_object rhs);
        apb_seq_item rhs_;
        if(!$cast(rhs_, rhs)) begin
          uvm_report_error("do_copy:", "Cast failed");
          return;
        end
        super.do_copy(rhs); // Chain the copy with parent classes
        addr    = rhs_.addr;
        prot    = rhs_.prot;
        sel     = rhs_.sel;
        write   = rhs_.write;
        ready   = rhs_.ready;
        wdata   = rhs_.wdata;
        strb    = rhs_.strb;
        rdata   = rhs_.rdata;
        slv_err = rhs_.slv_err;
    endfunction: do_copy

    virtual function bit do_compare(uvm_object rhs, uvm_comparer comparer);
        apb_seq_item rhs_;
        // If the cast fails, comparison has also failed
         // A check for null is not needed because that is done in the compare()
         // function which calls do_compare()
         if(!$cast(rhs_, rhs)) begin
           return 0;
         end
         return( super.do_compare(rhs,comparer) &&
                (addr   = rhs_.addr)    &&
                (prot   = rhs_.prot)    &&
                (sel    = rhs_.sel)     &&
                (write  = rhs_.write)   &&
                (ready  = rhs_.ready)   &&
                (wdata  = rhs_.wdata)   &&
                (strb   = rhs_.strb)    &&
                (rdata  = rhs_.rdata)   &&
                (slv_err= rhs_.slv_err));
    endfunction: do_compare

    virtual function string convert2string();
        string s;

        s = super.convert2string();
        // Note the use of \t (tab) and \n (newline) to format the data in columns
        // The enumerated op_code types .name() method returns a string corresponding to its value
        s = {s, $psprintf("\naddr\t\t: %0h",addr)};
        s = {s, $psprintf("\nprot\t\t: %0b",prot)};
        s = {s, $psprintf("\nsel\t\t: %0b",sel)};
        s = {s, $psprintf("\nwrite\t\t: %0b",write)};
        s = {s, $psprintf("\nready\t\t: %0b",ready)};
        s = {s, $psprintf("\nwdata\t\t: %0h",wdata)};
        s = {s, $psprintf("\nstrb\t\t: %0b",strb)};
        s = {s, $psprintf("\nrdata\t\t: %0h",rdata)};
        s = {s, $psprintf("\nslv_err\t: %0b",slv_err)};
        return s;
    endfunction: convert2string

    virtual function void do_print(uvm_printer printer);
        $display(convert2string());
    endfunction: do_print

    // This implementation is simulator specific.
    // In order to get transaction viewing to work with Questa you need to
    // Set the recording_detail config item to UVM_FULL:
    // set_config_int("*", "recording_detail", UVM_FULL);
    virtual function void do_record(uvm_recorder recorder);
        super.do_record(recorder); // To record any inherited data members
        `uvm_record_field("addr", addr)
        `uvm_record_field("prot", prot)
        `uvm_record_field("sel", sel)
        `uvm_record_field("write", write)
        `uvm_record_field("ready", ready)
        `uvm_record_field("wdata", wdata)
        `uvm_record_field("strb", strb)
        `uvm_record_field("rdata", rdata)
        `uvm_record_field("slv_err", slv_err)
    endfunction: do_record

    virtual function void do_pack(uvm_packer packer);
        super.do_pack(packer);
        `uvm_pack_int(addr);
        `uvm_pack_int(prot);
        `uvm_pack_int(sel);
        `uvm_pack_int(write);
        `uvm_pack_int(ready);
        `uvm_pack_int(wdata);
        `uvm_pack_int(strb);
        `uvm_pack_int(rdata);
        `uvm_pack_int(slv_err);
    endfunction: do_pack

    virtual function void do_unpack(uvm_packer packer);
        super.do_unpack(packer);
        `uvm_unpack_int(addr);
        `uvm_unpack_int(prot);
        `uvm_unpack_int(sel);
        `uvm_unpack_int(write);
        `uvm_unpack_int(ready);
        `uvm_unpack_int(wdata);
        `uvm_unpack_int(strb);
        `uvm_unpack_int(rdata);
        `uvm_unpack_int(slv_err);
    endfunction: do_unpack

endclass: apb_seq_item
