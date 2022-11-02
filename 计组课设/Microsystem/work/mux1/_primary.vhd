library verilog;
use verilog.vl_types.all;
entity mux1 is
    port(
        regdst          : in     vl_logic_vector(1 downto 0);
        ins             : in     vl_logic_vector(31 downto 0);
        m1out           : out    vl_logic_vector(4 downto 0)
    );
end mux1;
