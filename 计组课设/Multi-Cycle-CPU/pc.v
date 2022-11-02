module pc(clk,reset,npc,cpc,im_addr,PcWrite);
  input clk,reset,PcWrite;
  input[31:0] npc;
  output reg[31:0] cpc;
  output[9:0] im_addr;
  assign im_addr=cpc[9:0];
  always@(posedge clk or posedge reset)
  begin
    if(reset)
    begin
      cpc<=32'h0000_3000;
    end
    else if(PcWrite)
      cpc<=npc;
  end
endmodule