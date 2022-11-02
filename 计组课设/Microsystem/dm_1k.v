module dm_1k(addr, din, we, clk, dout);
  input [13:0] addr ;    //address bus
  input [31:0] din ;    // 32-bit input data
  input we ;            // memory write enable
  input clk ;           // clock
  output [31:0] dout ;  // 32-bit memory output
  reg [7:0] dm[12287:0];
  wire [7:0] temp;
  wire [31:0] tempout;
  assign temp=dm[addr];

  integer i;
  initial
  begin
    for (i = 0;i < 12288;i = i+1)
       dm[i]<=8'b0;
  end

  always@(posedge clk)
  begin
    if(we) 
      begin
        {dm[addr+3],dm[addr+2],dm[addr+1],dm[addr]} <= din;   //将数据写入对应地址
      end
  end

  assign tempout = {dm[addr+3],dm[addr+2],dm[addr+1],dm[addr]};
  assign dout = we? din:tempout;   //从对应地址读出的数据
  //小端序 高字节数据保存在高地址存储单元
endmodule
