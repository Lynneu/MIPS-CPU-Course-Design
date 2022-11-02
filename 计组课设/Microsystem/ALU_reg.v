module ALU_reg(clk,alu_out,alu_out_reg,dm_addr,dm_addr_reg);   //存储ALU计算结果和dm地址
  input clk;
  input[31:0] alu_out;
  output reg[31:0] alu_out_reg;
  input[13:0] dm_addr;
  output reg[13:0] dm_addr_reg;
  always@(posedge clk)
  begin
    alu_out_reg<=alu_out;
    dm_addr_reg<=dm_addr;
  end
endmodule

