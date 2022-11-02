module ifu(clk,reset,if_beq,zero,if_j);
    input clk,reset,if_beq,zero,if_j;
    wire[31:0] npc,cpc;
    wire[9:0] addr;
    wire[31:0] dout;
    pc(clk,reset,npc,cpc,addr);
    im_lk(addr,dout);
    calculate_pc(cpc,dout,if_beq,zero,if_j,npc);
endmodule
  