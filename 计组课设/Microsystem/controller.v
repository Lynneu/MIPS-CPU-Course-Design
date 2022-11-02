module controller(ins,clk,reset,if_jr,if_beq,if_j,MemWrite,MemtoReg,RegWrite,regdst,alusrc,alustr,extop,if_lb,if_sb,PcWrite,IrWrite,zero,
                  intreq,epcwr,exlset,exlclr,if_eret,cp0_we,cp0_sel,dev_wen,if_ws,npc4180);
  parameter s0=0,s1=1,s2=2,s3=3,s4=4,s5=5,s6=6,s7=7,s8=8,s9=9,s10=10,s11=11,s12=12,s13=13;
  wire addu,subu,ori,lw,sw,beq,lui,j,addiu,addi,slt,jal,jr,lb,sb;
  wire eret,mtc0,mfc0;               
  input if_ws;                         //判断此时的读写操作是外设还是cpu
  input intreq;                        //中断请求信号
  input clk,reset,zero;
  input[31:0]ins;                     //32-bit instruct
  reg[2:0] current,next;
  output reg npc4180;                 //1 标志npc的值应为中断子程序入口
  output [4:0] cp0_sel;               //选择cp0内部寄存器
  output if_lb,if_sb,if_jr,if_beq,if_j,alusrc,if_eret;
  output reg PcWrite,IrWrite,MemWrite,RegWrite,epcwr,exlset,exlclr,dev_wen,cp0_we;
  output[1:0] regdst,extop;
  output[1:0] alustr;
  output[2:0] MemtoReg;

  //根据opcode和funct字段确定指令类型
    assign addu = (ins[31:26]==6'd0 && ins[5:0]==6'b100001)?1:0;
    assign subu = (ins[31:26]==6'd0 && ins[5:0]==6'b100011)?1:0;
    assign slt  = (ins[31:26]==6'd0 && ins[5:0]==6'b101010)?1:0;
    assign jr   = (ins[31:26]==6'd0 && ins[5:0]==6'b001000)?1:0;
    assign j    = (ins[31:26]==6'b000010)?1:0;
    assign jal  = (ins[31:26]==6'b000011)?1:0;
    assign beq  = (ins[31:26]==6'b000100)?1:0;
    assign addi = (ins[31:26]==6'b001000)?1:0;
    assign addiu= (ins[31:26]==6'b001001)?1:0;
    assign ori  = (ins[31:26]==6'b001101)?1:0;
    assign lw   = (ins[31:26]==6'b100011)?1:0;
    assign sw   = (ins[31:26]==6'b101011)?1:0;
    assign lui  = (ins[31:26]==6'b001111)?1:0;
    assign lb   = (ins[31:26]==6'b100000)?1:0;  
    assign sb   = (ins[31:26]==6'b101000)?1:0;
  
    assign eret=(ins[31:26]==6'b010000 && ins[5:0]==6'b011000)?1:0;
    assign mtc0=(ins[31:26]==6'b010000 && ins[25:21]==5'b00100)?1:0;
    assign mfc0=(ins[31:26]==6'b010000 && ins[25:21]==5'b00000)?1:0;
  //  assign cp0_we=(mtc0)?1:0;                     //cp0写使能
    assign cp0_sel=(mtc0||mfc0)?ins[15:11]:5'd0;  //选择cp0内部寄存器

  always@(posedge clk or posedge reset)
  begin
    if(reset)
      begin
        current <= 0; 
        next <= 0;
      end
    else
      begin
        current <= next;
      end
  end
  
  always@(current,addu,subu,ori,lw,sw,beq,lui,j,addiu,addi,slt,jal,jr,lb,sb,eret,mtc0,mfc0)
  begin
    case(current)
      s0:
          if(intreq) next <= s5;
          else next <= s1;
      s1: 
          if(intreq && (j||jr)) next <= s5;
          else if(j||jr) next <= s0;
          else if(jal||mtc0||mfc0) next <= s4;
          else if(eret) next <= s0;
          else next <= s2;
      s2: 
          if(intreq && beq) next<=s5;
          else if(lw||sw||lb||sb) next<=s3; 
          else next<=s4;            //all else(not connected with dm)
      s3: 
          if(intreq && (sw||sb)) next <= s5;
          else if(lw||lb) next <= s4;
          else next <= s0;
      s4:        
          if(intreq && (addu||subu||ori||lui||addiu||addi||slt||jal||mtc0||mfc0)) next<=s5;
          else next <= s0;
      s5: 
          next<=s0;
      default: next <= s0;
    endcase
  end
  
  always@(current,addu,subu,ori,lw,sw,beq,lui,j,addiu,addi,slt, jal,jr,lb,sb,zero,eret)
  begin
    PcWrite  = (current==s5)||(current==s0)||((current==s4) && jal)||((current==s2) && beq && zero)||((current==s1) && j)||((current==s1) && jr);
    //1 PC写使能有效
    IrWrite  = (current==s0);
    //1 IR写使能有效
    RegWrite = ((current==s4) && (!mtc0));
    //1 寄存器堆写使能有效
    MemWrite = (!if_ws) && ((current==s3) && (sw||sb));   
    //1 数据存储器写使能有效；若是对外设操作，则DM写使能无效
    dev_wen  = (if_ws) && ((current==s3) && (sw||sb));
    //1 外设写使能有效
    cp0_we   = mtc0;                //cp0写使能
  //  cp0_sel  =(mtc0||mfc0)?ins[15:11]:5'd0;  //选择cp0内部寄存器
    epcwr    = (current==s5);   //epc写使能
    exlset   = (current==s5);   //置位SR的EXL位 关中断，防止再次进入
    exlclr   = eret;            //清除SR的EXL位，执行eret指令产生
    npc4180  = (current==s5);   //标志npc的值应为中断子程序入口
  end

  //设置控制信号
    assign if_eret= eret;
    assign if_jr  = jr && (current!=s0);                 //1 为jr指令
    assign if_beq = beq && (current!=s0);                //1 为beq指令
    assign if_j   = (j||jal) && (current!=s0);           //1 为j指令
    assign if_lb  = lb;                                  //1 为lb指令
    assign if_sb  = sb;                                  //1 为sb指令
    assign MemtoReg = {(mfc0||(lw && if_ws)),(slt||jal),(lw||lb||slt)};   //选择传入寄存器数据
    assign regdst   = {jal,(addu||subu||slt)};          //选择写入的寄存器
    assign alusrc   = ori||lw||sw||lui||addiu||addi||lb||sb;        //选择ALU第二个操作数 0 bushB;1 extout
    assign alustr   = {(ori||lui||addi),(subu||beq||addi||slt)};    //选择ALU计算类型 00 add; 01 sub; 10 or; 11 addi 
    assign extop    = {lui,(lw||sw||addiu||addi||lb||sb)};          //选择扩展方法 00 0扩展；01 符号扩展；10 lui扩展

endmodule
  
