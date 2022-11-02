module mips(clk,rst);
      input clk,rst;
      wire [31:0] ins;
      wire [31:0] npc;
      wire [31:0] cpc;
      wire [31:0] memout;
      wire [31:0] write_data;
      wire [31:0] bushA,bushB;
      wire [31:0] extout;
      wire [31:0] alu_out;
      wire [31:0] sltout;
      wire [31:0] jalPC;
      wire [31:0] b;
      wire [1:0] MemtoReg;    //写入寄存器数据 00:ALU_out 01:DM 10:JALpc 11:SLTout
      wire [1:0] regdst;      //写寄存器选择 00:rt 01:rd 10:$31
      wire [1:0] extop;       //扩展方法 00:zero 01:sign 10:lui 
      wire [1:0] aluctr;      //ALU计算方法
      wire alusrc;            //B端输入数据 0：busB 1: imm16
      wire MemWrite;          //DM写使能
      wire RegWrite;          //GPR写使能

      wire if_jr;
      wire if_beq;
      wire if_j;
      wire overflow;
      wire zero;

      wire [4:0] m1out;      //write reg
      wire [9:0] im_addr;
      wire [9:0] dm_addr;
      integer i;
      
      controller my_controller(ins,if_jr,if_beq,if_j,MemWrite,MemtoReg, RegWrite,regdst,alusrc,aluctr,extop);
      pc my_pc(clk,rst,npc,cpc,im_addr);
      im_lk my_im_lk(im_addr,ins);
      calculate_pc my_calculate_pc(cpc,ins,if_beq,zero,if_j,npc,if_jr,jalPC,bushA);
      gpr my_gpr(clk,rst,RegWrite,overflow,ins,m1out,write_data,bushA,bushB);
      ext my_ext(extop,ins,extout);
      dm_1k my_dm_1k(dm_addr,bushB,MemWrite,clk,memout);
      ALU my_ALU(bushA,b,aluctr,alu_out,zero,overflow,sltout,dm_addr);
      mux1 my_mux1(regdst,ins,m1out);
      mux2 my_mux2(MemtoReg,write_data,alu_out,memout,jalPC,sltout);
      mux3 my_mux3(alusrc,bushB,extout,b);
endmodule
  
  
  
  
  