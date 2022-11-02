module mips(clk,rst);
      input clk,rst;
      wire [31:0] ins;
      wire [31:0] ins_reg;
      wire [31:0] npc;
      wire [31:0] cpc;
      wire [31:0] memout;
      wire [31:0] memout_reg;
      wire [31:0] din;
      wire [31:0] dout;
      wire [31:0] SB_out;
      wire [31:0] LB_out;
      wire [31:0] write_data;
      wire [31:0] bushA,bushB;
      wire [31:0] bushA_reg,bushB_reg;
      wire [31:0] extout;
      wire [31:0] alu_out;
      wire [31:0] alu_out_reg;
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
      wire IrWrite;
      wire PcWrite;

      wire if_jr;
      wire if_beq;
      wire if_j;
      wire if_lb;
      wire if_sb;
      wire overflow;
      wire zero;

      wire [4:0] m1out;      //write reg
      wire [9:0] im_addr;
      wire [9:0] dm_addr;
      wire [9:0] dm_addr_reg;
      integer i;
      
      controller my_controller(ins_reg,clk,rst,if_jr,if_beq,if_j,MemWrite,MemtoReg,RegWrite,regdst,alusrc,aluctr,extop,if_lb,if_sb,PcWrite,IrWrite,zero);
      pc my_pc(clk,rst,npc,cpc,im_addr,PcWrite);
      im_lk my_im_lk(im_addr,ins);
      NextPC my_NextPC(cpc,rst,ins_reg,if_beq,zero,if_j,npc,if_jr,jalPC,bushA_reg);
      gpr my_gpr(clk,rst,RegWrite,overflow,ins_reg,m1out,write_data,bushA,bushB);
      ext my_ext(extop,ins_reg,extout);
      assign din = (if_sb)? SB_out : bushB_reg;
      assign memout = (if_lb)? LB_out : dout;
      sb my_sb(bushB_reg,dout,SB_out);
      lb my_lb(dout,LB_out);
      dm_1k my_dm_1k(dm_addr,din,MemWrite,clk,dout);
      ALU my_ALU(bushA_reg,b,aluctr,alu_out,zero,overflow,sltout,dm_addr_reg);
      mux1 my_mux1(regdst,ins_reg,m1out);
      mux2 my_mux2(MemtoReg,write_data,alu_out_reg,memout_reg,jalPC,sltout);
      mux3 my_mux3(alusrc,bushB_reg,extout,b);
      im_reg my_im_reg(clk,ins,ins_reg,IrWrite);
      A_reg my_A_reg(clk,bushA,bushA_reg);
      B_reg my_B_reg(clk,bushB,bushB_reg);
      ALU_reg my_ALU_reg(clk,alu_out,alu_out_reg,dm_addr,dm_addr_reg);
      dm_reg my_dm_reg(clk,memout,memout_reg);
endmodule
  