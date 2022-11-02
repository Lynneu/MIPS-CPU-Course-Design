module gpr(clk,reset,RegWrite,overflow,ins,write_reg,write_data,bushA,bushB);
    input clk;
    input reset;
    input RegWrite;
    input overflow;

    input[4:0] write_reg;       //write address
    input [31:0] write_data;
    input [31:0] ins;          //32-bit instruct
    
    output [31:0] bushA,bushB;  //read data
   // output if_ws;               //判断是否是外设

    reg [31:0] register[31:0];  //32 32-bit register
    reg [31:0] data1,data2;
    integer i;

    assign if_ws = (register[ins[25:21]]+ins[15:0]>=16'h7f00)? 1:0;

   /* always @(*) begin
      data1 = register[ins[25:21]];
      data2 = register[ins[25:21]];
    end*/
    assign bushA = register[ins[25:21]];
    assign bushB = register[ins[20:16]];

    always@(posedge clk or posedge reset or overflow)
    begin
      if(reset)
        begin
            for(i=0;i<32;i=i+1) 
            begin
              register[i]<=32'd0;
            end
        end
      else 
        begin
          if(register[30]) register[30] <= 0;
          if(RegWrite)
            begin
                if(overflow)                                          //if overflow, the destination register is not modified
                    register[30]<=(register[30]|32'h0000_0001);
                else if(write_reg!=5'd0)                              //if $0, the destination register is not modified
                    register[write_reg]<=write_data;          
            end
        end  
    end
endmodule
  
  
