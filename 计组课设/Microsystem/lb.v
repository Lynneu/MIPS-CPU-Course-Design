module lb(dout,LB_out);
    input [31:0] dout;
    output [31:0] LB_out;

    assign LB_out = {{24{dout[7]}},dout[7:0]}; //取一个字节，按符号位扩展

endmodule