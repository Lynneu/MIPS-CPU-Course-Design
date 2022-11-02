library verilog;
use verilog.vl_types.all;
entity sb is
    port(
        bushB           : in     vl_logic_vector(31 downto 0);
        dout            : in     vl_logic_vector(31 downto 0);
        SB_out          : out    vl_logic_vector(31 downto 0)
    );
end sb;
