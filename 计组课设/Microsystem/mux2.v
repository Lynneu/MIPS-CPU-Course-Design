module mux2(MemtoReg,write_data,alu_out,dm_out,jalPC,sltout,cp0out,rd);
//choose write data in register 
    input [2:0] MemtoReg;
    input [31:0] alu_out;
    input [31:0] dm_out;
    input [31:0] jalPC;
    input [31:0] sltout;
    input [31:0] cp0out;
    input [31:0] rd;
    output reg[31:0] write_data;

    always@(MemtoReg or alu_out or dm_out or jalPC or sltout)
    begin
      case(MemtoReg)
          3'd0: write_data = alu_out;
          3'd1: write_data = dm_out;
          3'd2: write_data = jalPC;
          3'd3: write_data = sltout;
          3'd4: write_data = cp0out;   //cp0输出
          3'd5: write_data = rd;       //bridge传入的外设的输入数据
          default: write_data = 32'd0;
      endcase
    end
endmodule
