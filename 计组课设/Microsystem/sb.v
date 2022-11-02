module sb(bushB,dout,SB_out);
    input [31:0] bushB;
    input [31:0] dout;
    output [31:0] SB_out;

    assign SB_out = {dout[31:8],bushB[7:0]};
    
endmodule