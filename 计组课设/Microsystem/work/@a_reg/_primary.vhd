library verilog;
use verilog.vl_types.all;
entity A_reg is
    port(
        clk             : in     vl_logic;
        a               : in     vl_logic_vector(31 downto 0);
        a_reg           : out    vl_logic_vector(31 downto 0)
    );
end A_reg;
