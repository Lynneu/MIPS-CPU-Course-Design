module test_mips;
  reg clk,rst;
  wire[31:0] ins,ins_reg,npc,cpc,memout,memout_reg,din,dout,SB_out,LB_out,write_data,bushA,bushA_reg,bushB,bushB_reg,extout,
             alu_out,alu_out_reg,sltout,jalPC,b;
  wire if_jr,if_beq,if_j,MemWrite,RegWrite,alusrc,overflow,zero,if_lb,
       if_sb,IrWrite,PcWrite;
  wire[1:0] MemtoReg,regdst,aluctr,extop;
  wire[4:0] m1out;
  wire[9:0] im_addr,dm_addr,dm_addr_reg;
  controller my_controller(ins_reg,clk,rst,if_jr,if_beq,if_j,MemWrite,MemtoReg,
                  RegWrite,regdst,alusrc,aluctr,extop,if_lb,if_sb,PcWrite,IrWrite,zero);                
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
  ALU my_ALU(bushA_reg,b,aluctr,alu_out,zero,overflow,sltout,dm_addr);
  mux1 my_mux1(regdst,ins_reg,m1out);
  mux2 my_mux2(MemtoReg,write_data,alu_out_reg,memout_reg,cpc,sltout);
  mux3 my_mux3(alusrc,bushB_reg,extout,b);
  im_reg my_im_reg(clk,ins,ins_reg,IrWrite);
  A_reg my_A_reg(clk,bushA,bushA_reg);
  B_reg my_B_reg(clk,bushB,bushB_reg);
  ALU_reg my_ALU_reg(clk,alu_out,alu_out_reg,dm_addr,dm_addr_reg);
  dm_reg my_dm_reg(clk,memout,memout_reg);
  
  initial
  begin
    clk=1;rst=0;
    #5 rst=1;
    #5 rst=0;
    $readmemh("p2-test.txt",my_im_lk.im);
  end
  always
  begin
    #30 clk=~clk;
    #30 $display("%h",my_controller.current);
  end
endmodule
