library verilog;
use verilog.vl_types.all;
entity ALU_reg is
    port(
        clk             : in     vl_logic;
        alu_out         : in     vl_logic_vector(31 downto 0);
        alu_out_reg     : out    vl_logic_vector(31 downto 0);
        dm_addr         : in     vl_logic_vector(9 downto 0);
        dm_addr_reg     : out    vl_logic_vector(9 downto 0)
    );
end ALU_reg;
