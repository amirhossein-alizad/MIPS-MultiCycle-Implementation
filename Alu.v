`timescale 1ns/1ns
module alu(input [31:0]A, input [31:0]B, input [2:0] ALUOp, output reg Zero, output reg [31:0] ALUResult);

  always @(A, B, ALUOp) begin
    Zero = 1'b0;
    ALUResult = 32'b0;
    
    if (ALUOp == 3'b000) begin
      ALUResult = A + B;
    end
    
    if (ALUOp == 3'b001) begin
      ALUResult = A - B;
      if (ALUResult == 32'b0) begin
        Zero = 1'b1;
      end
    end
    
    if (ALUOp == 3'b010) begin
      ALUResult = A & B;
    end
    
    if (ALUOp == 3'b011) begin
      ALUResult = A | B;
    end
    
    if (ALUOp == 3'b100) begin
      if (A < B) begin
        ALUResult = 32'b00000000_00000000_00000000_00000001;
      end
    end
  
  end 
  
endmodule