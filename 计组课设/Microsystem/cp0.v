module cp0(pc,din,hwint,sel,cp0wr,exlset,exlclr,clk,reset,intreq,epc,epcwr,dout);
    input [31:0] pc;       //用于保存pc
    input [31:0] din;      //cp0寄存器的写入数据：GPR中rt寄存器读出数据
    input [5:0] hwint;     //6个设备中断，从bridg传递过来
    input [4:0] sel;       //选择cp0内部寄存器
    input epcwr;           //epc写使能
    input cp0wr;           //cp0写使能
    input exlset;          //置位SR的EXL位
    input exlclr;          //清除SR的EXL位，执行eret指令产生
    input clk,reset;
    output intreq;         //中断请求信号
    output [31:0] dout;    //cp0寄存器的输出数据

    output reg [31:0] epc;       //epc寄存器输出至npc
    reg [15:10] hwint_pend;      //cause中6位寄存器,锁存hwint
    reg [15:10] im;  //SR
    reg exl,ie;             //exl标记中断状态；ie 全局中断使能 1允许中断

     always@(posedge clk or posedge reset)
     begin
        if(reset) begin
            exl=0; ie=0; im=0; hwint_pend=0;
        end
        else begin
            if(epcwr) 
                epc <= pc;                                       //保存中断时的pc
            if(cp0wr && (sel==5'd12))                           //cp0写使能有效且为sr寄存器,给SR赋初值 
                {im,exl,ie} <= {din[15:10],din[1],din[0]};
            if(exlset)                                         //关中断，防止再次进入
                exl<=1'b1;
            if(exlclr) begin                                      //开中断
                exl<=1'b0;
                hwint_pend=0;
            end
            else hwint_pend<=hwint;
        end
     end

    assign intreq=|(hwint & im) & ie & !exl;        //产生中断请求

    //写入cpu寄存器的数据
    //12:SR 13:CAUSE 14:EPC 15:PrID
    assign dout=(sel==5'd12)? {16'b0,im,8'b0,exl,ie}:
                (sel==5'd13)? {16'b0,hwint_pend,10'b0}:           //cause 记录当前哪些硬件中断有效
                (sel==5'd14)? epc: 
                (sel==5'd15)? 32'h20074221:
                32'd0;
                
endmodule