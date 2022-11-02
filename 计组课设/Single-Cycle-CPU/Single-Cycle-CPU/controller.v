module controller(ins,if_jr,if_beq,if_j,MemWrite,MemtoReg, RegWrite,regdst,alusrc,aluctr,extop);
    
    input  [31:0] ins;      //32-bit instruct
    output [1:0] MemtoReg;  //写入寄存器数据 00:ALU_out 01:DM 10:JALpc 11:SLTout
    output [1:0] regdst;    //写寄存器选择 00:rt 01:rd 10:$31
    output [1:0] extop;     //扩展方法 00:zero 01:sign 10:lui 
    output [1:0] aluctr;   //ALU计算方法
    output alusrc;          //B端输入数据 0：busB 1: imm16
    output MemWrite;        //DM写使能
    output RegWrite;        //GPR写使能
    output if_jr,if_beq,if_j;
    wire addu,subu,ori,lw,sw,beq,lui,j,addiu,addi,slt,jal,jr;

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
  
  //设置控制信号
    assign if_jr   = jr;                                         //1 为jr指令
    assign if_beq  = beq;                                        //1 为beq指令
    assign if_j    = j||jal;                                     //q 为j指令
    assign MemWrite= sw;                                         //1 数据存储器写使能有效
    assign MemtoReg= {(slt||jal),(lw||slt)};                     //选择传入寄存器数据
    assign RegWrite= addu||subu||ori||lw||lui||addiu||addi||slt||jal; //1 寄存器堆存储器写使能有效
    assign regdst  = {jal,(addu||subu||slt)};                         //选择写入的寄存器
    assign alusrc  = ori||lw||sw||lui||addiu||addi;                   //选择ALU第二个操作数 0 bushB;1 extout
    assign aluctr  = {(ori||lui||addi),(subu||beq||addi||slt)};       //选择ALU计算类型 00 add; 01 sub; 10 or; 11 addi 
    assign extop   = {lui,(lw||sw||addiu||addi)};                     //选择扩展方法 00 0扩展；01 符号扩展；10 lui扩展
  
endmodule