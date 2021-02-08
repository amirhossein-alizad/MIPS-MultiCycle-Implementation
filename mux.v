module twoBitMux(input sel, input [31:0]A, [31:0]B, output wire [31:0]out);
  assign out = sel?B:A;
endmodule

module threeBitMux(input[1:0] sel, input [31:0]A, [31:0]B,[31:0]C, output wire [31:0]out);
  assign out = sel[1]?C:(sel[0]?B:A);
endmodule

module RegDstMux(input [1:0]RegDst, input [4:0]A,[4:0]B, output wire [4:0]out);
  assign out = RegDst[1]?(5'b11111):(RegDst[0]?B:A);
endmodule

module AluSrcBMux(input [1:0]alusrcB, [31:0]A , [31:0]B, [31:0]C, output wire [31:0]out);
  assign out = alusrcB[1]?(alusrcB[0]?C:B):(alusrcB[0]?(32'b00000000_00000000_00000000_00000100):A);
endmodule