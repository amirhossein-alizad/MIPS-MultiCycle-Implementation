`timescale 1ns/1ns
module Memory(input[31:0] address,writedata, input memRead,memWrite,clk, output[31:0] readdata);
  reg[31:0] memData[0:2047];
  wire[31:0] secadd;
  assign secadd = {2'b0,address[31:2]};
  always@(posedge clk)begin
    if(memWrite) memData[secadd] <= writedata;
  end
  assign readdata = (memRead)? memData[secadd]:32'b0;
  initial begin
    $readmemb("sample3.txt", memData);
  end
endmodule
