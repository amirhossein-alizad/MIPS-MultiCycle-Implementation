module dataPath(input clk, rst, PCwritecondbeq, PCwritecondbne, memwrite, memread,  alusrcA, regWrite, IorD, PCwritecnt, IRwrite,
                input[1:0] pcSrc, alusrcB, memtoreg, regDst, input[2:0] aluOp, output wire[5:0] cbit,alucbit, output zero);
  
  wire [31:0] pcIn, pcOut, aluOut, address, memOut, readdata, IRout, MDRout, writeData, regData1, regData2, Aout, Bout, signOut,
  shiftOut1, AluAout, AluBout, AluResult, pc2;
  wire [4:0] writeadd;
  Reg32_1 PC(clk, rst, pcwrite, pcIn, pcOut);
  twoBitMux IorDmux(IorD, pcOut, aluOut, address);
  Memory memory(address, Bout, memread, memwrite, clk, readdata);
  Reg32_1 IR(clk, rst, IRwrite, readdata, IRout);
  Reg32_2 MDR(clk, rst, readdata, MDRout);
  RegDstMux RegDST(regDst, IRout[20:16], IRout[15:11], writeadd);
  threeBitMux MemToRegMux(memtoreg, aluOut, MDRout,pcOut, writeData);
  regFile registerFile(clk, regWrite, IRout[25:21], IRout[20:16], writeadd, writeData, regData1, regData2);
  Reg32_2 A(clk, rst, regData1, Aout);
  Reg32_2 B(clk, rst, regData2, Bout);
  sgnExt16 signex(IRout[15:0], signOut);
  shl2_2 shiftLeft1(signOut, shiftOut1);
  twoBitMux AluSrcA(alusrcA, pcOut, Aout, AluAout);
  AluSrcBMux AluSrcB(alusrcB, Bout, signOut, shiftOut1, AluBout);
  alu ALU(AluAout, AluBout, aluOp, zero, AluResult);
  Reg32_2 AluOut(clk, rst, AluResult, aluOut);
  shl2_1 shiftLeft(IRout[25:0], pcOut, pc2);
  threeBitMux PCMux(pcSrc, AluResult, pc2, aluOut, pcIn);
  
  assign pcwrite = PCwritecnt | (PCwritecondbeq & zero) | (PCwritecondbne & (~zero));
  assign alucbit = IRout[5:0];
  assign cbit = IRout[31:26];
  
  
endmodule