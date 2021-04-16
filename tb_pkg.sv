
`ifndef TB_PKG
`define TB_PKG
`include "uvm_macros.svh"
package tb_pkg;
 import uvm_pkg::*;
 `include "ram_sequence_item.sv"        // transaction class
 `include "ram_sequence.sv"             // sequence class
 `include "ram_sequencer.sv"            // sequencer class
 `include "ram_driver.sv"               // driver class
 `include "ram_monitor.sv"
 `include "ram_agent.sv"                // agent class  
 `include "ram_coverage.sv"             // coverage class
 `include "ram_scoreboard.sv"
 `include "ram_env.sv"                  // environment class

 `include "ram_test.sv"                 // test
 //`include "test2.sv"
 //`include "test3.sv"

endpackage
`endif 


