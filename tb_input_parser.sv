module tb_input_parser();


logic en;

logic clk ;

queue q1(
.en(en) ,
.clk(clk)
);

initial begin 

en = 0;
#1;
en = 1 ;
#1;
en = 0;

end


initial begin
clk = 1;

forever #5 clk = ~clk;
end 

endmodule
