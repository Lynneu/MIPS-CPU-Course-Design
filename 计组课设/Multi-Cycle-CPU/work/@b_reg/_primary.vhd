library verilog;
use verilog.vl_types.all;
entity B_reg is
    port(
        clk             : in     vl_logic;
        b               : in     vl_logic_vector(31 downto 0);
        b_reg           : out    vl_logic_vector(31 downto 0)
    );
end B_reg;
