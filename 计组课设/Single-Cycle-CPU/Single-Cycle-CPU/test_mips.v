module test_mips;
  reg clk,rst;
  wire[31:0] ins,npc,cpc,memout,write_data,
             sltout,jalPC;
  wire signed [31:0] bushB,extout;
  wire signed [31:0] bushA,b,alu_out;
  wire if_jr,if_beq,if_j,MemWrite,RegWrite,alusrc,overflow,zero;
  wire[1:0] MemtoReg,regdst,extop;
  wire[1:0] aluctr;
  wire[4:0] m1out;
  wire[9:0] addr,dm_addr;
  integer i;
  controller my_controller(ins,if_jr,if_beq,if_j,MemWrite,MemtoReg,
                  RegWrite,regdst,alusrc,aluctr,extop);
  pc my_pc(clk,rst,npc,cpc,addr);
  im_lk my_im_lk(addr,ins);
  calculate_pc my_calculate_pc(cpc,ins,if_beq,zero,if_j,npc,if_jr,jalPC,bushA);
  gpr my_gpr(clk,rst,RegWrite,overflow,ins,m1out,write_data,bushA,bushB);
  ext my_ext(extop,ins,extout);
  dm_1k my_dm_1k(dm_addr,bushB,MemWrite,clk,memout);
  ALU my_ALU(bushA,b,aluctr,alu_out,zero,overflow,sltout,dm_addr);
  mux1 my_mux1(regdst,ins,m1out);
  mux2 my_mux2(MemtoReg,write_data,alu_out,memout,jalPC,sltout);
  mux3 my_mux3(alusrc,bushB,extout,b);
  initial
  begin
    clk=1;rst=0;
    #5 rst=1;
    #5 rst=0;
    $readmemh("p1-test.txt",my_im_lk.im);
  end
  always
  begin
      //for(i=0;i<32;i=i+1) $display("%h",my_gpr.register[i]);
      $display("%h",my_dm_1k.dout);
      $display("0000");
      $display("%h",my_mux2.dm_out);
      $display("1111");
      $display("%h",my_dm_1k.addr);
      $display("2222");
      $display("%h",my_mux2.write_data);
      #30 clk=~clk;
  end
endmodule
  
  
  
  
  

