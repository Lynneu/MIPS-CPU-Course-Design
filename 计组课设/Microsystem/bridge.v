module bridge(praddr,prrd,prwd,dev_addr,dev0_rd,dev1_rd,dev2_rd,dev_wd,weCPU,weTimer,weOut,IRQ,hwint);
    input [31:0] praddr;      //CPU传入的访存地址
    input [31:0] prwd;        //CPU写入外设的数据
    input [31:0] dev0_rd;     //定时器读出的数据
    input [31:0] dev1_rd;     //输出设备读出的数据
    input [31:0] dev2_rd;     //输入设备读出的数据
    input weCPU;              //CPU传入的外设写使能
    input IRQ;                //定时器传入的中断信号
    output [31:0] prrd;       //外设写入CPU的数据
    output [31:0] dev_wd;     //写入外设的数据
    output [1:0] dev_addr;    //选择外设
    output [5:0] hwint;      //6个外设的中断请求信号
    output weTimer,weOut;   //定时器和输出设备的写使能

    wire hitdev_timer,hitdev_out,hitdev_in;    //设备译码信号

    assign hwint = {5'd0,IRQ};                 //定时器的中断信号存到第0位
    assign dev_wd = prwd;                     //写入外设的数据
    assign dev_addr = praddr[3:2];
    assign hitdev_timer = (praddr[31:4] == 28'h0000_7f0);
    assign hitdev_out   = (praddr[31:4] == 28'h0000_7f1);
    assign hitdev_in    = (praddr[31:4] == 28'h0000_7f2);

    assign weTimer = weCPU && hitdev_timer;
    assign weOut   = weCPU && hitdev_out;

    assign prrd = (hitdev_timer) ? dev0_rd:
                  (hitdev_out)   ? dev1_rd:
                  (hitdev_in)    ? dev2_rd:
                  32'h20074221;

endmodule