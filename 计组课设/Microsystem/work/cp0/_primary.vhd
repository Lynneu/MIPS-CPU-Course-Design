library verilog;
use verilog.vl_types.all;
entity cp0 is
    port(
        pc              : in     vl_logic_vector(31 downto 0);
        din             : in     vl_logic_vector(31 downto 0);
        hwint           : in     vl_logic_vector(5 downto 0);
        sel             : in     vl_logic_vector(4 downto 0);
        cp0wr           : in     vl_logic;
        exlset          : in     vl_logic;
        exlclr          : in     vl_logic;
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        intreq          : out    vl_logic;
        epc             : out    vl_logic_vector(31 downto 0);
        epcwr           : in     vl_logic;
        dout            : out    vl_logic_vector(31 downto 0)
    );
end cp0;
