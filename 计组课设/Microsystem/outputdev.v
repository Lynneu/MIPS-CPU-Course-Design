module outputdev(clk,weOut,din,addr,dout);
    input clk;
    input weOut;
    input [31:0] din;        //CPU传进来的数
    input [1:0] addr;       //选择输出设备的内部寄存器
    output [31:0] dout;     //通过bridge写入CPU的数

    reg [31:0] temp1,temp2;    //temp1存放上一秒输入的数；temp1存放当前输出

    assign dout=(addr==2'b00)? temp1:
                (addr==2'b01)? temp2: dout;   //输出数据
    //assign dout=temp2;

    always@(posedge clk) begin                //写入数据
        if(weOut) begin
            if(addr==2'b00) temp1=din;
            if(addr==2'b01) temp2=din;
        end
    end
endmodule