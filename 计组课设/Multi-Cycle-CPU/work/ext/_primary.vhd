library verilog;
use verilog.vl_types.all;
entity ext is
    port(
        extop           : in     vl_logic_vector(1 downto 0);
        ins             : in     vl_logic_vector(31 downto 0);
        extout          : out    vl_logic_vector(31 downto 0)
    );
end ext;
