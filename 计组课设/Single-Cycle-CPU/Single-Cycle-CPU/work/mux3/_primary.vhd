library verilog;
use verilog.vl_types.all;
entity mux3 is
    port(
        alusrc          : in     vl_logic;
        bushB           : in     vl_logic_vector(31 downto 0);
        extout          : in     vl_logic_vector(31 downto 0);
        b               : out    vl_logic_vector(31 downto 0)
    );
end mux3;
