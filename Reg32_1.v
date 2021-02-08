module Reg32_1(input clk, rst,write, input[31:0] inreg, output reg[31:0] outreg);
  always@(posedge clk, posedge rst)begin
    if(rst) outreg <= 32'b0;
    else begin
      if (write) outreg <= inreg;
    end
  end
endmodule