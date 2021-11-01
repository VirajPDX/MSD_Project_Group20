module tb_input_parser();


logic en;

input_parser p1(

.en(en)

);


initial begin 

en = 1 ;

#20 

en = 0;

#40;


en = 1;
#20 

en = 0;

#40;


en = 1;

end 


endmodule