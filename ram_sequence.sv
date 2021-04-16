

typedef class write_and_read;
class ram_sequence extends uvm_sequence#(ram_sequence_item);
  //----------------------------------------------------------------------------
  `uvm_object_utils(ram_sequence)            
  //----------------------------------------------------------------------------

  ram_sequence_item txn;

  //----------------------------------------------------------------------------
  function new(string name="ram_sequence");  
    super.new(name);
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  virtual task body();
    
  endtask:body
  //----------------------------------------------------------------------------
endclass:ram_sequence

/********************************************************************
class name  : reset_sequence
description : ->reset sequence for resetting RAM
*********************************************************************/
class reset_sequence extends ram_sequence;
  //----------------------------------------------------------------------------   
  `uvm_object_utils(reset_sequence)      
  //----------------------------------------------------------------------------
  
  ram_sequence_item txn;
  
  //----------------------------------------------------------------------------
  function new(string name="reset_sequence");
      super.new(name);
  endfunction
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  task body();
    txn=ram_sequence_item::type_id::create("txn");
    start_item(txn);
    txn.rst_p=1;
    txn.data_in=0;
    txn.rdn_wr=0;
    txn.addr=0;
    finish_item(txn);
  endtask:body
  //----------------------------------------------------------------------------
  
endclass:reset_sequence

/********************************************************************
class name  : write_only
description : ->it will only write in RAM , in which data , address 
                are random
              ->you can change iteration to any value  
*********************************************************************/
class write_only extends ram_sequence;
  //----------------------------------------------------------------------------   
  `uvm_object_utils(write_only)      
  //----------------------------------------------------------------------------
  ram_sequence_item txn;
  int unsigned iteration=100;
  //----------------------------------------------------------------------------
  function new(string name="write_only");
      super.new(name);
  endfunction
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  task body();
    repeat(iteration)
    begin
      txn=ram_sequence_item::type_id::create("txn");
      start_item(txn);
      txn.randomize()with{txn.rdn_wr==1;};
      txn.rst_p=0;
      finish_item(txn);
    end
  endtask:body
  //----------------------------------------------------------------------------
  
endclass:write_only

/********************************************************************
class name  : read_only
description : ->it will only read from RAM , address is random
              ->you can change iteration to any value
*********************************************************************/
class read_only extends ram_sequence;
  //----------------------------------------------------------------------------   
  `uvm_object_utils(read_only)      
  //----------------------------------------------------------------------------
  
  ram_sequence_item txn;
  int unsigned iteration=100;
  //----------------------------------------------------------------------------
  function new(string name="read_only");
      super.new(name);
  endfunction
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  task body();
    repeat(iteration)
    begin
      txn=ram_sequence_item::type_id::create("txn");
      start_item(txn);
      txn.randomize()with{txn.rdn_wr==0;};
      txn.rst_p=0;
      finish_item(txn);
    end
  endtask:body
  //----------------------------------------------------------------------------
  
endclass:read_only

class write_and_read extends ram_sequence;
  //----------------------------------------------------------------------------   
  `uvm_object_utils(write_and_read)      
  //----------------------------------------------------------------------------
  
  ram_sequence_item txn;
  int count=100;
  
  //----------------------------------------------------------------------------
  function new(string name="write_and_read");
      super.new(name);
  endfunction
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  task body();
    for(int i=0;i<count;i++)
      begin
        if(i<50)
          begin
            start_item(txn);
            txn.randomize()with{txn.rdn_wr==1;};
            txn.rst_p=0;
            finish_item(txn);
          end
        else  
          begin
            start_item(txn);
            txn.randomize()with{txn.rdn_wr==0;};
            txn.rst_p=0;
            finish_item(txn);
          end
      end

  endtask:body
  //----------------------------------------------------------------------------
  
endclass:write_and_read
  
  
  
/********************************************************************
class name  : write_and_read_2nd
description : ->it will first write into RAM and then read from it.
                read and write location control by if condition.
              ->you can change count , also according to it change
                if coundition in body.
              ->address and data are same as value of i in for loop.
*********************************************************************/  
class write_and_read_2nd extends ram_sequence;
  //----------------------------------------------------------------------------   
  `uvm_object_utils(write_and_read_2nd)      
  //----------------------------------------------------------------------------
  
  ram_sequence_item txn;
  int count=100;
  
  //----------------------------------------------------------------------------
  function new(string name="write_and_read_2nd");
      super.new(name);
  endfunction
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  task body();
    txn=ram_sequence_item::type_id::create("txn");
    for(int i=0;i<count;i++)
      begin
        if(i<50)
          begin
            start_item(txn);
            txn.randomize()with{txn.rdn_wr==1;txn.addr==i;txn.data_in==i;};
            txn.rst_p=0;
            finish_item(txn);
          end
        else  
          begin
            start_item(txn);
            txn.randomize()with{txn.rdn_wr==0;txn.addr==(i-50);txn.data_in==i;};
            txn.rst_p=0;
            finish_item(txn);
          end
      end

  endtask:body
  //----------------------------------------------------------------------------
  
endclass:write_and_read_2nd
  
  
  
/********************************************************************
class name  : write_and_read_all0
description : ->it will first write 0 in all address , and then read 0
                from all address.
              ->at the time of readind from RAM output must remain 0 ,
                if it is not then there is a bug in design.
              ->address value is same as value of i in for loop.
*********************************************************************/  
class write_and_read_all0 extends ram_sequence;
  //----------------------------------------------------------------------------   
  `uvm_object_utils(write_and_read_all0)      
  //----------------------------------------------------------------------------
  
  ram_sequence_item txn;
  bit [17:0] count=200;
  bit [17:0] i;
  
  //----------------------------------------------------------------------------
  function new(string name="write_and_read_all0");
      super.new(name);
  endfunction
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  task body();
    txn=ram_sequence_item::type_id::create("txn");
        for(i=0;i<count;i++)
          begin
            start_item(txn);
            txn.randomize()with{txn.rdn_wr==1;txn.addr==i;txn.data_in==0;};
            txn.rst_p=0;
            finish_item(txn);
          end
        for(i=0;i<count;i++)
          begin
            start_item(txn);
            txn.randomize()with{txn.rdn_wr==0;txn.addr==i;txn.data_in==0;};
            txn.rst_p=0;
            finish_item(txn);
          end
        
  endtask:body
  //----------------------------------------------------------------------------
  
endclass:write_and_read_all0

/********************************************************************
class name  : first_write_then_read_1_by_1 
description : ->it will first write in RAM in onle location(address),
                and then read from same location(address).
*********************************************************************/
class first_write_then_read_1_by_1 extends ram_sequence;
  //----------------------------------------------------------------------------   
  `uvm_object_utils(first_write_then_read_1_by_1)      
  //----------------------------------------------------------------------------
  
  ram_sequence_item txn;
  bit [17:0] count=200;
  bit [15:0] i;
  bit [15:0]temp_addr;
  
  //----------------------------------------------------------------------------
  function new(string name="first_write_then_read_1_by_1");
      super.new(name);
  endfunction
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  task body();
    txn=ram_sequence_item::type_id::create("txn");
        for(i=0;i<count;i++)
          begin
            if(i%2 != 0)
              begin
                start_item(txn);
               // txn.randomize()with{txn.rdn_wr==1;txn.addr==i;txn.data_in==i;};
                txn.addr=i;
                txn.data_in = i;
                txn.rdn_wr = 1;
                temp_addr=txn.addr;
                txn.rst_p=0;
                finish_item(txn);
              end
            else 
              begin
                start_item(txn);
                //txn.randomize()with{txn.rdn_wr==0;txn.data_in==i;};
                txn.data_in = 0;
                txn.rdn_wr = 0;
                txn.addr=temp_addr;
                txn.rst_p=0;
                finish_item(txn);
              end
          end
        
  endtask:body
  //----------------------------------------------------------------------------
  
endclass:first_write_then_read_1_by_1
  
  
  
/********************************************************************
class name  : write_and_read_allFF
description : ->it will first write value FF in all address of RAM ,
                and then read from it.
              ->at the time of reading output value must remain FF ,
                if it is not then there is a bug in design.
              ->addess value is same as value of i in for loop.
*********************************************************************/
class write_and_read_allFF extends ram_sequence;
  //----------------------------------------------------------------------------   
  `uvm_object_utils(write_and_read_allFF)      
  //----------------------------------------------------------------------------
  
  ram_sequence_item txn;
  bit [17:0] count=300;
  bit [17:0] i;
  
  //----------------------------------------------------------------------------
  function new(string name="write_and_read_allFF");
      super.new(name);
  endfunction
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  task body();
    txn=ram_sequence_item::type_id::create("txn");
        for(i=0;i<count;i++)
          begin
            start_item(txn);
            txn.randomize()with{txn.rdn_wr==1;txn.addr==i;txn.data_in==8'hFF;};
            txn.rst_p=0;
            finish_item(txn);
          end
        for(i=0;i<count;i++)
          begin
            start_item(txn);
            txn.randomize()with{txn.rdn_wr==0;txn.addr==i;txn.data_in==0;};
            txn.rst_p=0;
            finish_item(txn);
          end
        
  endtask:body
  //----------------------------------------------------------------------------
  
endclass:write_and_read_allFF

/********************************************************************
class name  : first_write_then_read_2_by_2
description : ->first it will write in 2 memory location and then
                it will read form those 2 memory locations
              ->here value of address is same as t_addr not i of
                for loop.
*********************************************************************/
class first_write_then_read_2_by_2 extends ram_sequence;
  //----------------------------------------------------------------------------   
  `uvm_object_utils(first_write_then_read_2_by_2)      
  //----------------------------------------------------------------------------
  
  ram_sequence_item txn;
  bit [15:0] count=200;
  bit [15:0] i;
  bit [15:0] t_addr;
  bit [15:0] temp;
  
  //----------------------------------------------------------------------------
  function new(string name="first_write_then_read_2_by_2");
      super.new(name);
  endfunction
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  task body();
    repeat(count)
      begin
        txn=ram_sequence_item::type_id::create("txn");
            for(i=1;i<3;i++)
              begin
                t_addr++;
                temp=t_addr;
                start_item(txn);
                txn.randomize()with{txn.rdn_wr==1;txn.addr==t_addr;};
                txn.rst_p=0;
                finish_item(txn);
              end
            for(i=1;i<3;i++)
              begin
                temp--;
                if(i==1)
                  begin
                    start_item(txn);
                    txn.randomize()with{txn.rdn_wr==0;txn.addr==temp; };
                    txn.rst_p=0;
                    finish_item(txn);
                  end
                else  
                  begin
                    start_item(txn);
                    txn.randomize()with{txn.rdn_wr==0;txn.addr==t_addr; };
                    txn.rst_p=0;
                    finish_item(txn);
                  end
              end
      end
        
  endtask:body
  //----------------------------------------------------------------------------
  
endclass:first_write_then_read_2_by_2  