`uvm_analysis_imp_decl( _drv )
`uvm_analysis_imp_decl( _mon )

class ram_scoreboard extends uvm_scoreboard;
  
  `uvm_component_utils(ram_scoreboard)
  
  uvm_analysis_imp_drv #(ram_sequence_item, ram_scoreboard) aport_drv;
  uvm_analysis_imp_mon #(ram_sequence_item, ram_scoreboard) aport_mon;
  
  uvm_tlm_fifo #(ram_sequence_item) expfifo;
  uvm_tlm_fifo #(ram_sequence_item) outfifo;
  
  int VECT_CNT, PASS_CNT, ERROR_CNT;
  parameter ADDR_WIDTH=16;
  parameter DATA_WIDTH=8;
  
  function new(string name="ram_scoreboard",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  
  function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	aport_drv = new("aport_drv", this);
	aport_mon = new("aport_mon", this);
	expfifo= new("expfifo",this);
	outfifo= new("outfifo",this);
  endfunction

  reg [DATA_WIDTH-1:0] mem_test[(2**ADDR_WIDTH-1):0];
  
  reg [ADDR_WIDTH-1:0] t_data_out;
  
  function void write_drv(ram_sequence_item tr);
    `uvm_info("write_drv STIM", tr.convert2string(), UVM_MEDIUM)
    if(tr.rst_p==1) 
      begin
        $display("------------------------------ RESET ------------------");
        `uvm_info("RESET in scoreboard", "----- RESET ---------", UVM_MEDIUM)
        for(int unsigned i=0;i<2**ADDR_WIDTH;i++)
          begin
          	mem_test[i]=0;
            tr.addr=0;
            tr.data_in=0;
            t_data_out=0;
            tr.rdn_wr=0;
          end
      end
   if(tr.rdn_wr==1)
      begin
        mem_test[tr.addr]=tr.data_in;
      end
   if(tr.rdn_wr==0)
      begin
        t_data_out=mem_test[tr.addr];
      end
    else 
      begin
        t_data_out=t_data_out;
      end
    tr.data_out=t_data_out;
    void'(expfifo.try_put(tr));
  endfunction

  function void write_mon(ram_sequence_item tr);
    `uvm_info("write_mon OUT ", tr.convert2string(), UVM_MEDIUM)
	void'(outfifo.try_put(tr));
  endfunction
  
  task run_phase(uvm_phase phase);
	ram_sequence_item exp_tr, out_tr;
	forever begin
		`uvm_info("scoreboard run task","WAITING for expected output", UVM_DEBUG)
		expfifo.get(exp_tr);
		`uvm_info("scoreboard run task","WAITING for actual output", UVM_DEBUG)
		outfifo.get(out_tr);
      
     // `uvm_info("[exp]", exp_tr.convert2string(), UVM_MEDIUM)
      
     // `uvm_info("[out]", out_tr.convert2string(), UVM_MEDIUM)
        
      
      	if(out_tr.rst_p==1) begin
        	$display("RESET Do not compare");
      	end
        /*
        else if (out_tr.compare(exp_tr)) begin
			PASS();
         `uvm_info ("PASS ",out_tr.convert2string() , UVM_LOW)
		end
        */
      
        else if(out_tr.data_out==exp_tr.data_out)
        	begin
          	  PASS();
         	  `uvm_info ("PASS ",out_tr.convert2string() , UVM_LOW)
        	end
      
      	else begin
			ERROR();
          `uvm_info ("ERROR [ACTUAL_OP]",out_tr.convert2string() , UVM_LOW)
          `uvm_info ("ERROR [EXPECTED_OP]",exp_tr.convert2string() , UVM_LOW)
          `uvm_warning("ERROR",out_tr.convert2string())
		end
      
    end
  endtask

  function void PASS();
	VECT_CNT++;
	PASS_CNT++;
  endfunction

  function void ERROR();
  	VECT_CNT++;
  	ERROR_CNT++;
  endfunction

      
endclass