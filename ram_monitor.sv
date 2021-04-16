
class ram_monitor extends uvm_monitor;
  //----------------------------------------------------------------------------
  `uvm_component_utils(ram_monitor)
  //----------------------------------------------------------------------------

  //------------------- constructor --------------------------------------------
  function new(string name="",uvm_component parent);
    super.new(name,parent);
  endfunction
  //----------------------------------------------------------------------------
  
  //---------------- sequence_item class ---------------------------------------
  ram_sequence_item  txn;
  //----------------------------------------------------------------------------
  
  //------------------------ virtual interface handle---------------------------  
  virtual interface intf vif;
  //----------------------------------------------------------------------------

  //------------------------ analysis port -------------------------------------
  uvm_analysis_port#(ram_sequence_item) ap_mon;
  //----------------------------------------------------------------------------
  
  //------------------- build phase --------------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!(uvm_config_db#(virtual intf)::get(this,"","vif",vif)))
    begin
      `uvm_fatal("monitor","unable to get interface")
    end
    
    ap_mon=new("ap_mon",this);
    txn=ram_sequence_item::type_id::create("txn",this);
  endfunction
  //----------------------------------------------------------------------------

  //-------------------- run phase ---------------------------------------------
  task run_phase(uvm_phase phase);
    forever
    begin
      // write monitor code here
      @(negedge vif.clk);
      txn.addr 		= vif.addr;
      txn.data_in   = vif.data_in;
      txn.data_out  = vif.data_out;
      txn.rdn_wr    = vif.rdn_wr;
      txn.rst_p     = vif.rst_p; 
      ap_mon.write(txn);
     
     // txn.printf();
    end
  endtask
  //----------------------------------------------------------------------------


endclass:ram_monitor

