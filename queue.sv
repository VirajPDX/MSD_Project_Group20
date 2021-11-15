///////////////////////////////////////////////////////////////////////////////////////////
// queue.sv - Initializing queue and removing last element from the queue
// Author - Group 20 (tanvi@pdx.edu)
//////////////////////////////////////////////////////////////////////////////////////////


module queue

#(
parameter IN_TRACE = 16
)

// initialization of inputs
	
(
input wire [31:0] time_op_s [15:0],
input wire [31:0] opcode_s[15:0],
input wire [31:0] row_col_bank_s[15:0]
);

logic en_1, clk;
logic [3:0] clk_ct;


// module instantiation 

input parser p1 (
	
.en (en_1),
.time_in (time_op_s),
.op(opcode_s),
.addr(row_col_bank_s)
	
);


// created a structure 

typedef struct packed 

{
	
bit [31:0] time_op;
bit [31:0] opcode;
bit [31:0] row_col_bank;
	
} queue_mem_element;


//creation of queue

queue mem_element queue_mem [$:16];

initial begin 
	
@(posedge clk) begin 

	for (int i=0; i<16; i++) begin

		queue_mem[i].time_op = time_op_s[i];
		queue_mem[i].opcode = opcode_s[i];
		queue_mem[i].row_col_bank = row_bank_bank_s[i];

				 end
		end
end


// making enable 0 and 1 to test 
	
initial begin

en_1 = 0;
#1;
en_1 = 1;
#1;
en_1 = 0;
 
end


initial begin 

clk=0;
clk_ct = 0;
forever #5 clk= ~clk;

end


initial begin

#2;
print_queue;
#10;
print_queue;
#110;
print_queue;

end


always@(posedge clk) begin

clk_ct = ~clk_ct +1;

end


always @(posedge clk)begin

	if (clk_ct == 10) begin
		
		queue_mem.delete(0);

			 end

end


// created a task to print the queue


task print_queue;

integer i;

$write ("Queue contains:  \n");

	for (int i=0; i<16; i++) begin

		$write("queue %2d: %4d %4d %9h \n" , i, queue_mem[i].time_op, queue_mem[i].opcode, queue_mem[i].row_col_bank);

				end
		$write ("\n");

endtask


endmodule
