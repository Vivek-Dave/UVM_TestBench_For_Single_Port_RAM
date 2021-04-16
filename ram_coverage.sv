
class ram_coverage extends uvm_subscriber #(ram_sequence_item);

  //----------------------------------------------------------------------------
  `uvm_component_utils(ram_coverage)
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function new(string name="",uvm_component parent);
    super.new(name,parent);
    dut_cov=new();
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  ram_sequence_item txn;
  real cov;
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  covergroup dut_cov;
    option.per_instance=1;
    
    ADDR:coverpoint txn.addr { option.auto_bin_max=65535;}
    
    RDN_WR:coverpoint txn.rdn_wr;
    
    ADDR_X_RDN_WR:cross ADDR,RDN_WR;
    
    // ADDR_X_RDN_WR:cross ADDR,RDN_WR {option.cross_auto_bin_max=131072;}
    // option.cross_auto_bin_max gives error in Aldec
    DATA:coverpoint txn.data_in { option.auto_bin_max=255; }
    
  endgroup:dut_cov

  //----------------------------------------------------------------------------

  //---------------------  write method ----------------------------------------
  function void write(ram_sequence_item t);
    txn=t;
    dut_cov.sample();
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function void extract_phase(uvm_phase phase);
    super.extract_phase(phase);
    cov=dut_cov.get_coverage();
  endfunction
  //----------------------------------------------------------------------------


  //----------------------------------------------------------------------------
  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name(),$sformatf("Coverage is %f",cov),UVM_LOW)
  endfunction
  //----------------------------------------------------------------------------
  
endclass:ram_coverage

