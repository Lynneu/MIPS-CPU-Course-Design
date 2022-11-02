module controller(ins,clk,reset,if_jr,if_beq,if_j,MemWrite,MemtoReg,RegWrite,regdst,alusrc,alustr,extop,if_lb,if_sb,PcWrite,IrWrite,zero);
  parameter s0=0,s1=1,s2=2,s3=3,s4=4,s5=5,s6=6,s7=7,s8=8,s9=9,s10=10,s11=11,s12=12,s13=13;
  wire addu,subu,ori,lw,sw,beq,lui,j,addiu,addi,slt,jal,jr,lb,sb;
  input clk,reset,zero;
  input[31:0]ins;                     //32-bit instruct
  reg[2:0] current,next;
  output if_lb,if_sb,if_jr,if_beq,if_j,alusrc;
  output reg PcWrite,IrWrite,MemWrite,RegWrite;
  output[1:0] MemtoReg,regdst,alustr,extop;

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
  
    //设置控制信号
    assign if_jr  = jr && (current!=s0);                 //1 为jr指令
    assign if_beq = beq && (current!=s0);                //1 为beq指令
    assign if_j   = (j||jal) && (current!=s0);           //1 为j指令
    assign if_lb  = lb;                                  //1 为lb指令
    assign if_sb  = sb;                                  //1 为sb指令
    assign MemtoReg = {(slt||jal),(lw||lb||slt)};       //选择传入寄存器数据
    assign regdst   = {jal,(addu||subu||slt)};          //选择写入的寄存器
    assign alusrc   = ori||lw||sw||lui||addiu||addi||lb||sb;        //选择ALU第二个操作数 0 bushB;1 extout
    assign alustr   = {(ori||lui||addi),(subu||beq||addi||slt)};    //选择ALU计算类型 00 add; 01 sub; 10 or; 11 addi 
    assign extop    = {lui,(lw||sw||addiu||addi||lb||sb)};          //选择扩展方法 00 0扩展；01 符号扩展；10 lui扩展
  
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
  
  always@(current,addu,subu,ori,lw,sw,beq,lui,j,addiu,addi,slt,jal,jr,lb,sb)
  begin
    case(current)
      s0:
          next<=s1;
      s1: 
          next<=s2;
      s2: 
          if(beq||j||jr||jal) next <= s0;
          else if(lw||sw||lb||sb) next <= s3; 
          else next <= s4;
      s3: 
          if(lw||lb) next <= s4;
          else next<=s0;
      s4: 
          next<=s0;
      default: next<=s0;
    endcase
  end
  
  always@(current,addu,subu,ori,lw,sw,beq,lui,j,addiu,addi,slt, jal,jr,lb,sb,zero)
  begin
    PcWrite  = (current==s0)||((current==s2) && jal)||((current==s2) && beq && zero)||((current==s2) && j)||((current==s2) && jr);
    //1 PC写使能有效
    IrWrite  = (current==s0);
    //1 IR写使能有效
    RegWrite = (current==s4)||((current==s2) && jal);
    //1 寄存器堆写使能有效
    MemWrite = ((current==s3) && (sw||sb));
    //1 数据存储器写使能有效
  end
endmodule
  
