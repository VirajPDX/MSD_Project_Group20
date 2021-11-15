module input_parser
#(
parameter IN_TRACE = 18
)
(input logic en ,
output logic [31:0] time_in [IN_TRACE-1:0],
output logic [31:0] op[IN_TRACE-1:0],
output logic [31:0]addr [IN_TRACE-1:0]

);

logic [31:0] time_in_s;
logic [31:0] op_s;
logic [31:0]addr_s;


integer file,c,count;


always_comb begin

count = 0 ;
file = $fopen("data_file.txt","r");

   while (!$feof(file)) begin
	 
          c = $fscanf(file,"%d %d %h",time_in_s,op_s,addr_s);
	
	time_in [count] <= time_in_s;
	op [count] <= op_s;
	addr [count] <= addr_s;
	count=count+1;
		

end

if (en == 1 )begin
$display("time:%4d   Enable IS ON ......///////////////////////////",$time);

for(int i = 0; i < IN_TRACE; i++)begin
$display("time : %4d   Operation Time:%4d  --  Operation:%2d  -- Address:%h",$time,time_in[i],op[i],addr[i]);
end

end 

else if (en == 0) begin 

$display("time:%4d   Enable is OFF ......///////////////////////////",$time);

end


end

endmodule
