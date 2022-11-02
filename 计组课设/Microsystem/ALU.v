module ALU(a,b,alu_ctr,alu_out,zero,overflow,sltout,dm_addr);
   input [31:0] a,b;        //32-bit input data
   input [1:0] alu_ctr;     //00 add; 01 sub; 10 or; 11 addi 
   output zero;
   output overflow;
   output reg [31:0] alu_out;
   output reg [31:0] sltout;
   output [13:0] dm_addr;
   assign dm_addr=alu_out[13:0];
   reg signed [31:0] signed_a,signed_b;

   always@(*)
   begin
      case(alu_ctr)
         2'b00:
            begin
               alu_out <= a+b;
               sltout <= 32'd0;
            end
         2'b01:
            begin
               alu_out <= a-b;
               signed_a <= a;
               signed_b <= b;
               if(signed_a<signed_b) sltout <= 32'd1;
               else sltout <= 32'd0;
            end
         2'b10:
            begin
               alu_out <= a|b;
               sltout <= 32'd0;
            end
         2'b11:
            begin
               alu_out <= a+b;
               sltout <= 32'd0;
            end
      endcase
      end

   assign overflow=((alu_out[31] && (!a[31]) && (!b[31]))||((~alu_out[31]) && a[31] && b[31])) ? 1 : 0;
   assign zero = (alu_out == 0);

endmodule
      
        
