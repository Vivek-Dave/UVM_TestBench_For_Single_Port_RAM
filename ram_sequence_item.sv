
class ram_sequence_item extends uvm_sequence_item;

  //------------ i/p || o/p field declaration-----------------

  parameter ADDR_WIDTH=16;
  parameter DATA_WIDTH=8;

  rand logic [DATA_WIDTH-1:0]data_in;
  rand logic rdn_wr;
  rand logic [ADDR_WIDTH-1:0]addr;
  logic rst_p;

  logic [DATA_WIDTH-1:0]data_out;
  
  //---------------- register ram_sequence_item class with factory --------
  `uvm_object_utils_begin(ram_sequence_item) 
     `uvm_field_int( data_in ,UVM_ALL_ON)
     `uvm_field_int( rdn_wr ,UVM_ALL_ON)
     `uvm_field_int( rst_p ,UVM_ALL_ON)
     `uvm_field_int( addr ,UVM_ALL_ON)
  	 `uvm_field_int( data_out ,UVM_ALL_ON)
  `uvm_object_utils_end
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function new(string name="ram_sequence_item");
    super.new(name);
  endfunction
  //----------------------------------------------------------------------------
  
  function void printf();
    `uvm_info("mux_sequence_item",$sformatf("data_in=%0f addr=%0f rdn_wr=%0b rst_p=%0b",
    data_in,addr,rdn_wr,rst_p),UVM_MEDIUM)
  endfunction

  function string convert2string();
    return $sformatf("mux_sequence_item",$sformatf("data_in=%0f addr=%0f rdn_wr=%0b rst_p=%0b data_out=%0f",data_in,addr,rdn_wr,rst_p,data_out));
  endfunction
  
  
endclass:ram_sequence_item
