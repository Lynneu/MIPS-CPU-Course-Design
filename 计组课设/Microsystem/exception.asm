lw $t0,($s2)                  //读取input数据
lw $t1,($s1)                  //读取上一秒输入的input
beq $t0,$t1,equal             //比较是否相等
sw $t0,($s1)                  //若不相等，输出等于输入
sw $t0,4($s1)
beq $0,$0,exit            //跳转至exit
equal:lw $t2,4($s1)           //若相等，output+1
addiu $t2,$t2,1
sw $t2,4($s1)
exit:ori $t3,$0,10
sw $t3,4($s0)              //重置 preset
ori $t4,$0,9
sw $t4,($s0)               //重置 ctrl
eret                      //返回主程序
