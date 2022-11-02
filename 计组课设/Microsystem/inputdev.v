module inputdev(din,dout);
    input [31:0] din;
    output [31:0] dout;

    reg [31:0] temp;
    always@(*) temp=din;
    assign dout=temp;

endmodule