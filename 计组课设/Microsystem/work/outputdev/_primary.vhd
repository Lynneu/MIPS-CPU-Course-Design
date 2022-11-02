library verilog;
use verilog.vl_types.all;
entity outputdev is
    port(
        clk             : in     vl_logic;
        weOut           : in     vl_logic;
        din             : in     vl_logic_vector(31 downto 0);
        addr            : in     vl_logic_vector(1 downto 0);
        dout            : out    vl_logic_vector(31 downto 0)
    );
end outputdev;
