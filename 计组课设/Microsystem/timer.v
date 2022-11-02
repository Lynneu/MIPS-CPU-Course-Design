module timer(CLK_I,RST_I,WE_I,ADD_I,DAT_I,DAT_O,IRQ);
    input CLK_I;
	input RST_I;
    input WE_I;            //写使能
    input [3:2] ADD_I;     //选择寄存器
    input [31:0] DAT_I;   //输入数据
    output [31:0] DAT_O;  //输出数据
    output reg IRQ;       //中断请求

    reg [31:0] ctrl;      // 控制计数起停
    reg [31:0] preset;    // 保存初值 
    reg [31:0] count;     // 计数
 
    assign DAT_O = (ADD_I==2'b00)? ctrl:               //选择通过bridg写入cpu的数据
                   (ADD_I==2'b01)? preset:
                   (ADD_I==2'b10)? count: DAT_O;

    always@(posedge CLK_I or posedge RST_I)
    begin
        if(RST_I)
        begin
            ctrl <= 32'd0;
            preset <= 32'd0;
            count <= 32'd0;
            IRQ <= 1'b0;
        end
        else
        begin
            if(WE_I)                   //写使能有效，从cp0输入的数据存入寄存器
            begin
                ctrl <= (ADD_I==2'b00)? DAT_I : ctrl;
                preset <= (ADD_I==2'b01)? DAT_I : preset;
                count <= (ADD_I==2'b01)? DAT_I : count;   //初值寄存器重写后重新倒计时
            end

            if(IRQ==1) IRQ<=0;   //清除中断信号

            if(ctrl[0])  //计数器使能为1 允许计数
            begin    
                if(ctrl[2:1]==2'b00)  //模式0
                begin      
                    if(count == 2'b0) 
                    begin
                        ctrl[0] <= 0;            //倒计数为 0 后，计数器停止计数，使能为0
                        if(ctrl[3]==1) begin IRQ <= 1'b1; ctrl[3] <=0; end   //如果中断允许，产生中断请求
                    end
                    else count <= count - 1;        //倒计数不为0则继续计数
                end
                else if(ctrl[2:1]==2'b01)  //模式1
                begin    
                    if(count == 2'b0)
						begin
							count <= preset;   //倒计数为 0 后，计数器自动加载初值，继续计数
							//if(ctrl[3]==1) IRQ <= 1'b1;           //如果中断允许，产生中断请求
						end
					else count <= count - 1;
                end
            end
        end
    end

endmodule