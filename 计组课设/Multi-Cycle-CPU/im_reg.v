module im_reg(clk,ins,ins_reg,IrWrite);
  input clk,IrWrite;
  input[31:0] ins;
  output reg[31:0] ins_reg;
  always@(posedge clk)
    if(IrWrite)
      ins_reg<=ins;
endmodule
