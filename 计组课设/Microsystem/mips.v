module mips(clk,rst,praddr,prdin,prdout,dev_wen,hwint);
      input clk,rst;
      input [31:0] prdin;        //从bridge读入的数据
      input [5:0] hwint;         //中断请求
      output [31:0] praddr;      //传出的32位地址
      output [31:0] prdout;      //输出至bridge的数据
      output dev_wen;             //外设写使能

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
      wire [2:0] MemtoReg;    //写入寄存器数据 
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

      wire if_ws;            //判断是否是外设
      wire[31:0] cp0out,epc;
      wire[4:0] cp0_sel;   //选择cp0寄存器
      wire cp0_we,exlset,exlclr,intreq,epcwr,if_eret;
      wire npc4180;

      wire [4:0] m1out;      //write reg
      wire [12:0] im_addr;
      wire [13:0] dm_addr;
      wire [13:0] dm_addr_reg;
      integer i;

      assign praddr = alu_out_reg;
      assign prdout = bushB_reg;
      assign if_ws = (praddr[15:0]>'h7eff)? 1:0;
      
      cp0 my_cp0(cpc,bushB_reg,hwint,cp0_sel,cp0_we,exlset,exlclr,clk,rst,intreq,
            epc,epcwr,cp0out);
      controller my_controller(ins_reg,clk,rst,if_jr,if_beq,if_j,MemWrite,MemtoReg,RegWrite,regdst,alusrc,aluctr,extop,if_lb,if_sb,PcWrite,IrWrite,zero,
      intreq,epcwr,exlset,exlclr,if_eret,cp0_we,cp0_sel,dev_wen,if_ws,npc4180);
      pc my_pc(clk,rst,npc,cpc,im_addr,PcWrite);
      im_lk my_im_lk(im_addr,ins);
      NextPC my_NextPC(cpc,rst,ins_reg,if_beq,zero,if_j,npc,if_jr,jalPC,bushA_reg,npc4180,if_eret,epc);
      gpr my_gpr(clk,rst,RegWrite,overflow,ins_reg,m1out,write_data,bushA,bushB);
      ext my_ext(extop,ins_reg,extout);
      assign din = (if_sb)? SB_out : bushB_reg;
      assign memout = (if_lb)? LB_out : dout;
      sb my_sb(bushB_reg,dout,SB_out);
      lb my_lb(dout,LB_out);
      ALU my_ALU(bushA_reg,b,aluctr,alu_out,zero,overflow,sltout,dm_addr);
      mux1 my_mux1(regdst,ins_reg,m1out);
      mux2 my_mux2(MemtoReg,write_data,alu_out_reg,memout_reg,cpc,sltout,cp0out,prdin);
      mux3 my_mux3(alusrc,bushB_reg,extout,b);
      im_reg my_im_reg(clk,ins,ins_reg,IrWrite);
      A_reg my_A_reg(clk,bushA,bushA_reg);
      B_reg my_B_reg(clk,bushB,bushB_reg);
      ALU_reg my_ALU_reg(clk,alu_out,alu_out_reg,dm_addr,dm_addr_reg);
      dm_1k my_dm_1k(alu_out_reg[13:0],din,MemWrite,clk,dout);
      dm_reg my_dm_reg(clk,memout,memout_reg);
endmodule
  