///////////////////////////////////////////////////////////////////////////////////////////
// Queue1.sv - Implementing a queue that has enteries from input parser file
//
// Author:	       GROUP  (dkamath@pdx.edu)
// Version:        	 1.0
//
//
///////////////////////////////////////////////////////////////////////////////////////////
module queue

#(
parameter IN_TRACE = 16
) 
//parameter declaration
(

     input wire [31:0] time_op_s [15:0],
     input wire [31:0] opcode_s[15:0],
     input wire [31:0] row_col_bank_s[15:0]

);

   logic en_1,clk ; 

    input_parser p1(

    .en(en_1), 
    .time_in(time_op_s),
    .op(opcode_s),
    .addr(row_col_bank_s)

);

     typedef struct packed
 {
	bit [31:0] time_op ;
	bit [31:0] opcode;
	bit [31:0] row_col_bank;

 }   queue_mem_element ;

     queue_mem_element  queue_mem ;


     logic [98:0] queue [$:15];



   always@(posedge clk) 
    begin 	


    for (int i = 0 ; i < 16 ; i++ ) 
          begin 

         queue_mem.time_op = time_op_s[i];
         queue_mem.opcode = opcode_s[i];
         queue_mem.row_col_bank = row_col_bank_s[i];




         end 
     end
	
        queue[i] = {queue_mem.time_op,queue_mem.opcode,queue_mem.row_col_bank};
        $display ("queue : %p",queue_mem) ;
        //$display (" queue %2d: %b",i,queue [i]);
        $display (" queue %2d:  %4d %4d %9h",i,queue_mem.time_op,queue_mem.opcode,queue_mem.row_col_bank );
   

    initial begin 

    en_1 = 1;
    #10;
    en_1=0;
    clk = 0;
    forever #5 clk = ~clk;

           end 
 
    endmodule
    /*always@(posedge clk) 
	begin 

    for (int i = 0 ; i < count; i++ )
     	begin 

         queue_mem_reg[i].time_op = time_in[i];
         queue_mem_reg[i].opcode = op[i];
         queue_mem_reg[i].row_col_bank = addr[i];

        end 
    end
*/
