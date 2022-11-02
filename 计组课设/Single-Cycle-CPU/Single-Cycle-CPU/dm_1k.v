module dm_1k(addr, din, we, clk, dout);
    input [9:0] addr ;  
    input [31:0] din ;   // 32-bit input data
    input we ;          // dm write enable
    input clk ;         // clock
    output [31:0] dout ;  // 32-bit dm output
    reg[7:0] dm[1023:0] ;

    always@(posedge clk)
    begin
        if(we) {dm[addr+3],dm[addr+2],dm[addr+1],dm[addr]}<=din; //将数据写入对应地址
    end
    assign dout={dm[addr+3],dm[addr+2],dm[addr+1],dm[addr]};   //从对应地址读出的数据
      //小端序 高字节数据保存在高地址存储单元
endmodule
