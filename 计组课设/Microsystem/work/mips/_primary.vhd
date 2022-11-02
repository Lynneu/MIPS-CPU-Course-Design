library verilog;
use verilog.vl_types.all;
entity mips is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        praddr          : out    vl_logic_vector(31 downto 0);
        prdin           : in     vl_logic_vector(31 downto 0);
        prdout          : out    vl_logic_vector(31 downto 0);
        dev_wen         : out    vl_logic;
        hwint           : in     vl_logic_vector(5 downto 0)
    );
end mips;
