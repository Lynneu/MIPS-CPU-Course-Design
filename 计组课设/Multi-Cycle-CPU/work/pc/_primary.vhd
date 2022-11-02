library verilog;
use verilog.vl_types.all;
entity pc is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        npc             : in     vl_logic_vector(31 downto 0);
        cpc             : out    vl_logic_vector(31 downto 0);
        im_addr         : out    vl_logic_vector(9 downto 0);
        PcWrite         : in     vl_logic
    );
end pc;
