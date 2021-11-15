module queue
(
input logic en ,
input logic clk
);


logic [31:0]clk_ct; 

/////////////////////////////////////////////////////////////////////////
/////////////////////INPUT PARSER USING DMA ////////////////////////////
///////////////////////////////////////////////////////////////////////

logic [99:0] time_in [];
logic [31:0] op[];
logic [31:0]addr [];

logic [99:0] time_in_s;
logic [31:0] op_s;
logic [31:0]addr_s;


integer file,c,count,in,wait_1,k;

always_comb begin

count = 0 ;
file = $fopen("data_file.txt","r");

   while (!$feof(file)) begin
	  time_in = new[count+1](time_in);
	  op = new[count+1](op);	  
	  addr = new[count+1](addr);
          c = $fscanf(file,"%d %d %h",time_in_s,op_s,addr_s);
	
	time_in [count] = time_in_s;
	op [count] = op_s;
	addr [count] = addr_s;
	count=count+1;
		

end

if (en == 1 )begin
$display("time:%4d   Enable IS ON ......///////////////////////////",$time);

for(int i = 0; i < (count - 1); i++)begin
$display("time : %4d   Operation Time:%4d  --  Operation:%2d  -- Address:%h",$time,time_in[i],op[i],addr[i]);
end

end 

else if (en == 0) begin 

$display("time:%4d   Enable is OFF ......///////////////////////////",$time);

end


end
/////////////////////////////////////////////////////////////////////////
////////////////////////  STRUCTURE DEFINE  QUEUE //////////////////////
///////////////////////////////////////////////////////////////////////

typedef struct packed
{
bit [99:0] time_op ;
bit [31:0] opcode;
bit [31:0] row_col_bank;

}queue_mem_element ;

queue_mem_element  queue_mem [$:15] ; // creating a structured queue
queue_mem_element  queue_mem_reg[] ;
 
initial begin
in = 0;
k = 16;
wait_1 = 0;
clk_ct = 0;
#1 queue_mem_reg = new[count];

end
//////////////////////////////////////////////////////////////////////////
///////////////////////////// Memory Queue Register /////////////////////
////////////////////////////////////////////////////////////////////////

always@(posedge clk) begin 

for (int i = 0 ; i < (count -1); i++ ) begin 

queue_mem_reg[i].time_op = time_in[i];
queue_mem_reg[i].opcode = op[i];
queue_mem_reg[i].row_col_bank = addr[i];

end 



end 


//////////////////////////////////////////////////////////////////////////
///////////////////////////// Memory Queue INSERTION ////////////////////
////////////////////////////////////////////////////////////////////////

always@(posedge clk) begin 

if (in<16)	begin 

queue_mem[in].time_op = time_in[in];
queue_mem[in].opcode = op[in];
queue_mem[in].row_col_bank = addr[in];
$display(" Clock ticks %4d memory queue%4d th element inserted ",clk_ct+1,in+1);
in ++;
end
end 

//if (clk_ct >= time_in[in])	begin 

//queue_mem[in].time_op = time_in[in];
//queue_mem[in].opcode = op[in];
//queue_mem[in].row_col_bank = addr[in];
//in ++;
//end

///////////////////////////////////////////////////////////////////////////////
////////////////////////////PRINTING QUEUE/////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

//always@(posedge clk)begin 
//print_queue;
//end 

////////////////////////////////////////////////////////////////////////////
//////////////////clock ticks counter //////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

always@(posedge clk)begin 
clk_ct=clk_ct+1;
end

/////////////////////////////////////////////////////////////////////////////
///////////////////  QUEUE  ////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

always@(posedge clk) begin 

if (queue_mem[0] != 0)begin 
	
		
		
		wait(clk_ct >= 101 );
		queue_mem.pop_front();
		//# 10 wait_1 = 1;
		if (k<count-1)begin 	
		queue_mem.push_back(queue_mem_reg[k]);
		$display(" Clock ticks %4d  memory queue first element removed and %4d th element inserted ",clk_ct,k+1);
		k++;
	end
	end
	end

	//if (wait_1 == 1) begin 
	//#((queue_mem[0].time_op)*10) ;
	//queue_mem.pop_front();
	//end 
	
//end 
//end 


///////////////////////////////////////////////////////////////
////////////////////////printing queue task ///////////////////
///////////////////////////////////////////////////////////////

task print_queue;
  integer i;
  $write(" Time :  %4d clock ticks \n Queue contains : \n",clk_ct);
  for (int i = 0 ; i < 15 ; i++ ) begin 
  $write (" queue %2d:  %15d %4d %9h \n",i,queue_mem[i].time_op,queue_mem[i].opcode,queue_mem[i].row_col_bank );
  end
  $write("\n");
endtask

/////////////////////////////////////////////////////////////////
endmodule 