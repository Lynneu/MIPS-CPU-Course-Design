module pc(clk,reset,npc,cpc,addr);
    input clk,reset;
    input[31:0] npc;
    output reg [31:0] cpc;
    output [9:0] addr;
    assign addr = cpc[9:0];  //IM address

    always@(posedge clk or posedge reset)
    begin
      if(reset)
          cpc<=32'h0000_3000;
      else
         cpc<=npc;
    end
endmodule