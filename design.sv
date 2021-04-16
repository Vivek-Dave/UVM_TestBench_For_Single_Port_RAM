////////////////////////////////////////////////////////////////////////////
// design of 64KB Ram
// data input width = 8
// data output width = 8
// address width = 16
// address range 0 to 65535
// synchronous with clk
// rdn_wr signal -> when rdn_wr=0 means read rdn_wr=1 means write
// synchronous reset -> rst_p means active high reset
////////////////////////////////////////////////////////////////////////////
module RAM(clk,
           rst_p,
           data_in,
           data_out,
           addr,
           rdn_wr
           );

    parameter ADDR_WIDTH=16;
    parameter DATA_WIDTH=8;

    input clk;
    input rst_p;
    input rdn_wr;
    input [DATA_WIDTH-1:0]data_in;
    input [ADDR_WIDTH-1:0]addr;

  output reg [DATA_WIDTH-1:0]data_out;

    reg [DATA_WIDTH-1:0] mem[(2**ADDR_WIDTH-1):0];

    always@(posedge clk )
        begin
            if(rst_p==1'b1)
                begin
                    for(int unsigned i=0;i<2**ADDR_WIDTH;i++)
                        begin
                            mem[i]<=0;
                            data_out<=0;
                        end
                end
        end

    always@(addr,data_in,rdn_wr)
        begin
            if(rdn_wr==1'b1)      //write into RAM
                begin
                    mem[addr]=data_in;
                end
            else if (rdn_wr==1'b0) // read from RAM
                begin
                    data_out=mem[addr];
                end
            else  
                begin
                    data_out=data_out;
                end
        end
endmodule
          
  