
class ram_test extends uvm_test;

    //--------------------------------------------------------------------------
    `uvm_component_utils(ram_test)
    //--------------------------------------------------------------------------

    //--------------------------------------------------------------------------
    function new(string name="",uvm_component parent);
	super.new(name,parent);
    endfunction
    //--------------------------------------------------------------------------

    ram_env env_h;
    int file_h;

    reset_sequence rst_seq;
    write_only write_seq;
    read_only read_seq;
	read_only read_seq1;
    //--------------------------------------------------------------------------
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      env_h     = ram_env::type_id::create("env_h",this);

    endfunction
    //--------------------------------------------------------------------------

    //--------------------------------------------------------------------------
    function void end_of_elobartion_phase(uvm_phase phase);
      $display("End of eleboration phase in agent");
      // print topology
      // print();
    endfunction
    //--------------------------------------------------------------------------

    //--------------------------------------------------------------------------
    function void start_of_simulation_phase(uvm_phase phase);
      $display("start_of_simulation_phase");
      file_h=$fopen("LOG_FILE.log","w");
      set_report_default_file_hier(file_h);
      set_report_severity_action_hier(UVM_INFO,UVM_DISPLAY+UVM_LOG);
      env_h.set_report_verbosity_level_hier(UVM_LOW);  
      print();  //prints topologi
    endfunction
    //--------------------------------------------------------------------------

    //--------------------------------------------------------------------------
    task run_phase(uvm_phase phase);
	      phase.raise_objection(this);
            
            rst_seq   = reset_sequence::type_id::create("rst_seq");
	        write_seq = write_only::type_id::create("write_seq");
            read_seq  = read_only::type_id::create("resd_seq");
            read_seq1  = read_only::type_id::create("resd_seq1");
       
            rst_seq.start(env_h.agent_h.sequencer_h); 
            read_seq.start(env_h.agent_h.sequencer_h);
            write_seq.start(env_h.agent_h.sequencer_h);
            read_seq.start(env_h.agent_h.sequencer_h);
            #10;
	      
          phase.drop_objection(this);
    endtask
    //--------------------------------------------------------------------------

endclass:ram_test


class test1 extends ram_test;

  //--------------------------------------------------------------------------
  `uvm_component_utils(test1)
  //--------------------------------------------------------------------------

  //--------------------------------------------------------------------------
  function new(string name="",uvm_component parent);
    super.new(name,parent);
  endfunction
  //--------------------------------------------------------------------------

  ram_env env_h;
  int file_h;
  write_and_read_2nd seq;
  reset_sequence rst_seq;
  //--------------------------------------------------------------------------
  function void build_phase(uvm_phase phase);
    env_h = ram_env::type_id::create("env_h",this);
  endfunction
  //--------------------------------------------------------------------------

  //--------------------------------------------------------------------------
  function void end_of_elobartion_phase(uvm_phase phase);
    $display("End of eleboration phase in agent");
  endfunction
  //--------------------------------------------------------------------------

  //--------------------------------------------------------------------------
  function void start_of_simulation_phase(uvm_phase phase);
    $display("start_of_simulation_phase");
    file_h=$fopen("LOG_FILE.log","w");
  	set_report_default_file_hier(file_h);
 	set_report_severity_action_hier(UVM_INFO,UVM_DISPLAY+UVM_LOG);
    env_h.set_report_verbosity_level_hier(UVM_MEDIUM);
  endfunction
  //--------------------------------------------------------------------------

  //--------------------------------------------------------------------------
  task run_phase(uvm_phase phase);
      phase.raise_objection(this);
     	seq     = write_and_read_2nd::type_id::create("seq");
    	rst_seq = reset_sequence::type_id::create("rst_seq");
    	rst_seq.start(env_h.agent_h.sequencer_h);
      	seq.start(env_h.agent_h.sequencer_h);
      	#10;
      phase.drop_objection(this);
  endtask
  //--------------------------------------------------------------------------

endclass:test1



class test_write_read_all0 extends ram_test;

  //--------------------------------------------------------------------------
  `uvm_component_utils(test_write_read_all0)
  //--------------------------------------------------------------------------

  //--------------------------------------------------------------------------
  function new(string name="",uvm_component parent);
    super.new(name,parent);
  endfunction
  //--------------------------------------------------------------------------

  ram_env env_h;
  int file_h;
  write_and_read_all0 seq;
  reset_sequence rst_seq;

  //--------------------------------------------------------------------------
  function void build_phase(uvm_phase phase);
   // super.build_phase(phase);
    env_h     = ram_env::type_id::create("env_h",this);
  endfunction
  //--------------------------------------------------------------------------

  //--------------------------------------------------------------------------
  function void end_of_elobartion_phase(uvm_phase phase);
  //  super.end_of_elobartion_phase(phase);
    //factory.print();
    $display("End of eleboration phase in agent");
  endfunction
  //--------------------------------------------------------------------------

  //--------------------------------------------------------------------------
  function void start_of_simulation_phase(uvm_phase phase);
   // super.start_of_simulation_phase(phase);
    $display("start_of_simulation_phase");
	
    file_h=$fopen("LOG_FILE.log","w");
      set_report_default_file_hier(file_h);
      set_report_severity_action_hier(UVM_INFO,UVM_DISPLAY+UVM_LOG);
      env_h.set_report_verbosity_level_hier(UVM_MEDIUM);
  endfunction
  //--------------------------------------------------------------------------

  //--------------------------------------------------------------------------
  task run_phase(uvm_phase phase);
      phase.raise_objection(this);
    	
        seq=write_and_read_all0::type_id::create("seq");
    	rst_seq=reset_sequence::type_id::create("rst_seq");
        
        rst_seq.start(env_h.agent_h.sequencer_h);
        seq.start(env_h.agent_h.sequencer_h);
        
        #10;
      phase.drop_objection(this);
  endtask
  //--------------------------------------------------------------------------

endclass:test_write_read_all0


class test_first_write_then_read_1_by_1 extends ram_test;

  //--------------------------------------------------------------------------
  `uvm_component_utils(test_first_write_then_read_1_by_1)
  //--------------------------------------------------------------------------

  //--------------------------------------------------------------------------
  function new(string name="",uvm_component parent);
    super.new(name,parent);
  endfunction
  //--------------------------------------------------------------------------

  ram_env env_h;
  int file_h;
  first_write_then_read_1_by_1 seq;
  reset_sequence rst_seq;

  //--------------------------------------------------------------------------
  function void build_phase(uvm_phase phase);
   // super.build_phase(phase);
    env_h     = ram_env::type_id::create("env_h",this);
  endfunction
  //--------------------------------------------------------------------------

  //--------------------------------------------------------------------------
  function void end_of_elobartion_phase(uvm_phase phase);
  //  super.end_of_elobartion_phase(phase);
    //factory.print();
    $display("End of eleboration phase in agent");
  endfunction
  //--------------------------------------------------------------------------

  //--------------------------------------------------------------------------
  function void start_of_simulation_phase(uvm_phase phase);
    $display("start_of_simulation_phase");
    file_h=$fopen("LOG_FILE.log","w");
    set_report_default_file_hier(file_h);
    set_report_severity_action_hier(UVM_INFO,UVM_DISPLAY+UVM_LOG);
    env_h.set_report_verbosity_level_hier(UVM_MEDIUM);
  endfunction
  //--------------------------------------------------------------------------

  //--------------------------------------------------------------------------
  task run_phase(uvm_phase phase);
      phase.raise_objection(this);
    	
        seq=first_write_then_read_1_by_1::type_id::create("seq");
    	rst_seq=reset_sequence::type_id::create("rst_seq");
        
        rst_seq.start(env_h.agent_h.sequencer_h);
        seq.start(env_h.agent_h.sequencer_h);
        
        #10;
      phase.drop_objection(this);
  endtask
  //--------------------------------------------------------------------------

endclass



class test_write_read_allFF extends ram_test;

  //--------------------------------------------------------------------------
  `uvm_component_utils(test_write_read_allFF)
  //--------------------------------------------------------------------------

  //--------------------------------------------------------------------------
  function new(string name="",uvm_component parent);
    super.new(name,parent);
  endfunction
  //--------------------------------------------------------------------------

  ram_env env_h;
  int file_h;
  write_and_read_allFF seq;
  reset_sequence rst_seq;

  //--------------------------------------------------------------------------
  function void build_phase(uvm_phase phase);
    //super.build_phase(phase);
    env_h     = ram_env::type_id::create("env_h",this);
  endfunction
  //--------------------------------------------------------------------------

  //--------------------------------------------------------------------------
  function void end_of_elobartion_phase(uvm_phase phase);
    $display("End of eleboration phase in agent");
  endfunction
  //--------------------------------------------------------------------------

  //--------------------------------------------------------------------------
  function void start_of_simulation_phase(uvm_phase phase);
    $display("start_of_simulation_phase");
    file_h=$fopen("LOG_FILE.log","w");
    set_report_default_file_hier(file_h);
    set_report_severity_action_hier(UVM_INFO,UVM_DISPLAY+UVM_LOG);
    env_h.set_report_verbosity_level_hier(UVM_MEDIUM);
  endfunction
  //--------------------------------------------------------------------------

  //--------------------------------------------------------------------------
  task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      	
        seq=write_and_read_allFF::type_id::create("seq");
      	rst_seq=reset_sequence::type_id::create("rst_seq");
      	
        rst_seq.start(env_h.agent_h.sequencer_h);
      	seq.start(env_h.agent_h.sequencer_h);
      	
        #10;
      phase.drop_objection(this);
  endtask
  //--------------------------------------------------------------------------

endclass:test_write_read_allFF



class test_write_read_2_by_2 extends ram_test;

  //--------------------------------------------------------------------------
  `uvm_component_utils(test_write_read_2_by_2)
  //--------------------------------------------------------------------------

  //--------------------------------------------------------------------------
  function new(string name="",uvm_component parent);
    super.new(name,parent);
  endfunction
  //--------------------------------------------------------------------------

  ram_env env_h;
  int file_h;
  first_write_then_read_2_by_2 seq;
  reset_sequence rst_seq;

  //--------------------------------------------------------------------------
  function void build_phase(uvm_phase phase);
    //super.build_phase(phase);
    env_h     = ram_env::type_id::create("env_h",this);
  endfunction
  //--------------------------------------------------------------------------

  //--------------------------------------------------------------------------
  function void end_of_elobartion_phase(uvm_phase phase);
    $display("End of eleboration phase in agent");
  endfunction
  //--------------------------------------------------------------------------

  //--------------------------------------------------------------------------
  function void start_of_simulation_phase(uvm_phase phase);
    $display("start_of_simulation_phase");
    file_h=$fopen("LOG_FILE.log","w");
    set_report_default_file_hier(file_h);
    set_report_severity_action_hier(UVM_INFO,UVM_DISPLAY+UVM_LOG);
    env_h.set_report_verbosity_level_hier(UVM_LOW);
  endfunction
  //--------------------------------------------------------------------------

  //--------------------------------------------------------------------------
  task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      	
        seq=first_write_then_read_2_by_2::type_id::create("seq");
      	rst_seq=reset_sequence::type_id::create("rst_seq");
      
      	rst_seq.start(env_h.agent_h.sequencer_h);
      	seq.start(env_h.agent_h.sequencer_h);
      	
        #10;
      phase.drop_objection(this);
  endtask
  //--------------------------------------------------------------------------

endclass:test_write_read_2_by_2








