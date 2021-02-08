module mips(input clk, rst);
  wire[5:0] OpCode, Func;
  wire[2:0] AluOp;
  wire[1:0] AluSrcB, PCsrc, RegDst, Memtoreg;
  wire IorD, Memread, Memwrite, IRwrite, AluSrcA, PCwrite, Regwrite, zero;
  controller newCnt(OpCode, Func, clk, rst, zero, AluOp, IorD, Memread, Memwrite, PCwritecondbeq, PCwritecondbne, IRwrite, AluSrcA, PCwrite, Regwrite, AluSrcB, PCsrc, RegDst, Memtoreg);
  dataPath newDP(clk, rst, PCwritecondbeq, PCwritecondbne, Memwrite, Memread, AluSrcA, Regwrite, IorD, PCwrite, IRwrite, PCsrc, AluSrcB, Memtoreg, RegDst, AluOp, OpCode, Func, zero);
endmodule
