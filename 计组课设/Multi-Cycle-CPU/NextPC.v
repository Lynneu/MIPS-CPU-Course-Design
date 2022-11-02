module NextPC(cpc,reset,ins,if_beq,zero,if_j,npc,if_jr,jalPC,bushA);
  input [31:0] ins;        //32-bit instruct
  input [31:0] cpc;        //now PC
  input [31:0] bushA;     //target address in GPR rs 
  input if_beq,if_j,zero,if_jr,reset;
  output reg [31:0] npc;
  output [31:0] jalPC;
  reg beq_jump;
  reg [2:0] choose;
  assign jalPC = cpc+4;

  always@(posedge reset)
  begin
    if(reset) npc<=32'h0000_3004;
  end

  always@(choose,ins,if_j,beq_jump,if_beq,zero,if_jr,bushA)
  begin
  //  npc = (if_beq)? cpc+({{16{ins[15]}},ins[15:0]}<<2) : cpc+32'h4;
    beq_jump = if_beq && zero;
    choose={if_j,beq_jump,if_jr};
    case(choose)
      3'b000: npc = cpc+32'h4;                 //pc=pc+4
      3'b010: npc = cpc+({{16{ins[15]}},ins[15:0]}<<2);    //beq
      3'b100: npc = {cpc[31:28],ins[25:0],2'b0};          //j jal
      3'b001: npc = bushA;                                //jr
      default:npc = 32'h00003004;
    endcase
  end
endmodule
