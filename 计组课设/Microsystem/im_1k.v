module im_lk(addr,dout);
  input[12:0] addr;
  output[31:0] dout;
  reg[7:0] im[8191:0];

  initial
  begin
    $readmemh("main.txt",im,'h1000);
    $readmemh("exception.txt",im,'h0180);
  end

  assign dout={im[addr],im[addr+1],im[addr+2],im[addr+3]};
endmodule
