module dm_reg(clk,memout,memout_reg);  //存储dm输出数据
  input clk;
  input [31:0] memout;
  output reg [31:0] memout_reg;

  always@(posedge clk)
    memout_reg<=memout;
endmodule