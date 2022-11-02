library verilog;
use verilog.vl_types.all;
entity lb is
    port(
        dout            : in     vl_logic_vector(31 downto 0);
        LB_out          : out    vl_logic_vector(31 downto 0)
    );
end lb;
