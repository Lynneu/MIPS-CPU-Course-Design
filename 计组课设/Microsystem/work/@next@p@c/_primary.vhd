library verilog;
use verilog.vl_types.all;
entity NextPC is
    port(
        cpc             : in     vl_logic_vector(31 downto 0);
        reset           : in     vl_logic;
        ins             : in     vl_logic_vector(31 downto 0);
        if_beq          : in     vl_logic;
        zero            : in     vl_logic;
        if_j            : in     vl_logic;
        npc             : out    vl_logic_vector(31 downto 0);
        if_jr           : in     vl_logic;
        jalPC           : out    vl_logic_vector(31 downto 0);
        bushA           : in     vl_logic_vector(31 downto 0);
        npc4180         : in     vl_logic;
        if_eret         : in     vl_logic;
        epc             : in     vl_logic_vector(31 downto 0)
    );
end NextPC;
