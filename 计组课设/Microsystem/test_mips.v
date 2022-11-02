module test_mips;
  reg clk,rst;
  reg [31:0] in;
  mach mach(clk,rst,in);

  initial
  begin
    in=32'h5;
    clk=1;rst=0;
    #1 rst=1;
    #1 rst=0;
    #20000 in=32'h66;
  end
  always
    #10 clk=~clk;
endmodule
