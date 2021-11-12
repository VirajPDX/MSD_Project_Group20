///////////////////////////////////////////////////////////////////////////////////////////
// input_parser.sv - Parsing the input file from a text document 
//
// Author:	       GROUP  (viraj@pdx.edu)
// Version:        	 1.0
// Last Modified:	1-NOV-2021
//
// Description:
// ------------
// Debugging code (that be enabled/disabled at either runtime or compile time)
// to display the parsed values for each line
//
///////////////////////////////////////////////////////////////////////////////////////////

module input_parser(

#(
parameter IN_TRACE = 16
)
(input logic en ,
output logic [32:0] time_in [IN_TRACE-1:0],
output logic [32:0] op[IN_TRACE-1:0],
output logic [32:0]addr [IN_TRACE-1:0]

);

logic [32:0] time_in_s;
logic [32:0] op_s;
logic [32:0]addr_s;


integer file,c,count;


always_comb begin

if (en == 1 )begin
count = 0 ;
$display("time:%4d   Enable IS ON ......///////////////////////////",$time);
file = $fopen("data_file.txt","r");

   while (!$feof(file)) begin
	 
          c = $fscanf(file,"%d %d %h",time_in_s,op_s,addr_s);
	  $display("Operation Time:%4d  --  Operation:%2d  -- Address:%h",time_in_s,op_s,addr_s);
	
	time_in [count] <= time_in_s;
	op [count] <= op_s;
	addr [count] <= addr_s;
	count=count+1;
		
      end

end

else begin 

$display("time:%4d   Enable is OFF ......///////////////////////////",$time);

end 



end






endmodule 
