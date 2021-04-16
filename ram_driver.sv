
class ram_driver extends uvm_driver #(ram_sequence_item);
  //----------------------------------------------------------------------------
  `uvm_component_utils(ram_driver)
  //----------------------------------------------------------------------------

  uvm_analysis_port #(ram_sequence_item) drv2sb;
  //----------------------------------------------------------------------------
  function new(string name="",uvm_component parent);
    super.new(name,parent);
    drv2sb=new("drv2sb",this);
  endfunction
  //---------------------------------------------------------------------------- 

  //--------------------------  virtual interface handel -----------------------  
  virtual interface intf vif;
  //----------------------------------------------------------------------------
  
  //-------------------------  get interface handel from top -------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!(uvm_config_db#(virtual intf)::get(this,"","vif",vif))) begin
      `uvm_fatal("driver","unable to get interface");
    end
  endfunction
  //----------------------------------------------------------------------------
  
  //---------------------------- run task --------------------------------------
  task run_phase(uvm_phase phase);
    ram_sequence_item txn;
    forever begin
      seq_item_port.get_next_item(txn);
      // write driver code here
      @(posedge vif.clk);
      vif.data_in <= txn.data_in;
      vif.rdn_wr  <= txn.rdn_wr;
      vif.rst_p   <= txn.rst_p;
      vif.addr    <= txn.addr;
      #1;
      drv2sb.write(txn);   // send data to scoreboard
      `uvm_info(get_type_name(),txn.convert2string(),UVM_MEDIUM)
     // txn.printf();
      seq_item_port.item_done();    
    end
  endtask
  //----------------------------------------------------------------------------
  
endclass:ram_driver

