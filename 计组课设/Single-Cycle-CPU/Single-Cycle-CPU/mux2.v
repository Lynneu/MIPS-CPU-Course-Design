module mux2(MemtoReg,write_data,alu_out,dm_out,jalPC,sltout);
//choose write data in register 
    input [1:0] MemtoReg;
    input [31:0] alu_out;
    input [31:0] dm_out;
    input [31:0] jalPC;
    input [31:0] sltout;
    output reg[31:0] write_data;

    always@(MemtoReg or alu_out or dm_out or jalPC or sltout)
    begin
      case(MemtoReg)
          2'd0: write_data = alu_out;
          2'd1: write_data = dm_out;
          2'd2: write_data = jalPC;
          2'd3: write_data = sltout;
          default: write_data = 32'd0;
      endcase
    end
endmodule
