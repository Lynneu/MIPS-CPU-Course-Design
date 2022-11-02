library verilog;
use verilog.vl_types.all;
entity dm_reg is
    port(
        clk             : in     vl_logic;
        memout          : in     vl_logic_vector(31 downto 0);
        memout_reg      : out    vl_logic_vector(31 downto 0)
    );
end dm_reg;
