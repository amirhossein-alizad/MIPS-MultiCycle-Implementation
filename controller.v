module controller(input[5:0] OpCode, Func, input clk, rst, zero, output reg[2:0] AluOp, output reg IorD, Memread, Memwrite, PCwritecondbeq, PCwritecondbne, IRwrite, AluSrcA, PCwrite, Regwrite,
                  output reg[1:0] AluSrcB, PCsrc, RegDst, Memtoreg);
  
  reg[3:0] ps, ns;
  always@(ps)begin
    ns = 4'b0;
    {AluOp, IorD, Memread, Memwrite, IRwrite, AluSrcA, PCwrite, Regwrite, AluSrcB, PCsrc, RegDst, Memtoreg, PCwritecondbeq, PCwritecondbne} = 20'b0;
    case(ps)
      /*IF*/
      4'b0000: begin
        ns = 4'b0001;
        {IorD, Memread, IRwrite, AluSrcA, AluSrcB, PCwrite, PCsrc, AluOp} = 12'b011001100000;
      end
      /*ID*/
      4'b0001: begin
        if(OpCode==6'b000011) ns = 4'b0010;
        if(OpCode==6'b000010) ns = 4'b0011;
        if(OpCode==6'b000100) ns = 4'b0100;
        if(OpCode==6'b000101) ns = 4'b0101;
        if(OpCode==6'b000000) ns = 4'b0110;
        if((OpCode==6'b001000) || (OpCode==6'b001100)) ns = 4'b1000;
        if((OpCode==6'b101011) || (OpCode==6'b100011)) ns = 4'b1010;
        if(OpCode==6'b000001) ns = 4'b1110;
        {AluSrcA, AluSrcB, AluOp} = 6'b011000;
      end 
      /*JAL*/
      4'b0010: begin
        {Regwrite, RegDst, Memtoreg} = 5'b11010;
        ns = 4'b0011;
      end
      /*J*/
      4'b0011: begin
        {PCwrite, PCsrc} = 3'b101;
        ns = 4'b0000;
      end
      /*BEQ*/
      4'b0100: begin
        {AluSrcA, AluSrcB, AluOp, PCsrc} = 8'b10000110;
        PCwritecondbeq = 1;
        ns = 4'b0000;
      end
      /*BNE*/
      4'b0101:begin
        {AluSrcA, AluSrcB, AluOp, PCsrc} = 8'b10000101;
        PCwritecondbne = 1;
        ns = 4'b0000;
      end
      /*R-Type Instructions*/
      4'b0110: begin
        {AluSrcA, AluSrcB} = 3'b100;
        if(Func==6'b100000) AluOp = 3'b000;
        if(Func==6'b100010) AluOp = 3'b001;
        if(Func==6'b100100) AluOp = 3'b010;
        if(Func==6'b100101) AluOp = 3'b011;
        if(Func==6'b101010) AluOp = 3'b100;
        ns = 4'b0111;
      end
      /*R-Type Pt.2*/
      4'b0111: begin
        {Memtoreg, Regwrite, RegDst} = 5'b00101;
        ns = 4'b0000;
      end
      /*Addi and Andi*/
      4'b1000: begin
        {AluSrcA, AluSrcB} = 3'b110;
        AluOp = (OpCode==6'b001000)?3'b000:3'b010;
        ns = 4'b1001;
      end
      /*Addi and Andi Pt.2*/
      4'b1001: begin
        {RegDst, Memtoreg, Regwrite} = 5'b00001;
        ns = 4'b0000;
      end
      /*LW/SW*/
      4'b1010: begin
        {AluSrcA, AluSrcB, AluOp} = 6'b110000;
        if (OpCode==6'b101011) ns = 4'b1011;
        if (OpCode==6'b100011) ns = 4'b1100;
      end
      /*SW*/
      4'b1011: begin
        {Memwrite, IorD} = 2'b11;
        ns = 4'b0000;
      end
      /*LW*/
      4'b1100: begin
        {Memread, IorD} = 2'b11;
        ns = 4'b1101;
      end
      /*LW Pt.2*/
      4'b1101: begin
        {Memtoreg, RegDst, Regwrite} = 5'b01001;
        ns = 4'b0000;
      end
      /*JR*/
      4'b1110: begin
        {AluSrcA, AluSrcB, PCsrc, PCwrite} = 6'b100001;
        ns = 4'b0000;
      end
    endcase
  end
  
  always@(posedge clk, posedge rst) begin
    if(rst) ps <= 4'b0000;
    else ps <= ns;
  end
  
endmodule
