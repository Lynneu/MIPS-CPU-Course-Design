module mach(clk,rst,in);
    input clk,rst;
    input [31:0] in;
    wire [31:0] praddr,prrd,prwd;
    wire [31:0] dev0_rd,dev1_rd,dev2_rd;
    wire [5:0] hwint;
    wire [1:0] dev_addr;
    wire dev_wen;

    mips mips(clk,rst,praddr,prrd,prwd,dev_wen,hwint);
    bridge bridge(praddr,prrd,prwd,dev_addr,dev0_rd,dev1_rd,dev2_rd,dev_wd,dev_wen,weTimer,weOut,IRQ,hwint);
    timer timer(clk,rst,weTimer,dev_addr,prwd,dev0_rd,IRQ);
    outputdev outputdev(clk,weOut,prwd,dev_addr,dev1_rd);
    inputdev inputdev(in,dev2_rd);

endmodule
