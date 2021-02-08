module shl2_1(input[25:0] A,[31:0]PC, output[31:0] B);
  assign B = {PC[31:28],A[25:0], 2'b00};
endmodule 

module shl2_2(input[31:0] A, output[31:0] B);
  assign B = {A[29:0], 2'b00};
endmodule 
