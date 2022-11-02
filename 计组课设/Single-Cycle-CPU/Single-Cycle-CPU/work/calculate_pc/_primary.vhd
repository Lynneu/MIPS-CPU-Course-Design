library verilog;
use verilog.vl_types.all;
entity calculate_pc is
    port(
        cpc             : in     vl_logic_vector(31 downto 0);
        ins             : in     vl_logic_vector(31 downto 0);
        if_beq          : in     vl_logic;
        zero            : in     vl_logic;
        if_j            : in     vl_logic;
        npc             : out    vl_logic_vector(31 downto 0);
        if_jr           : in     vl_logic;
        jalPC           : out    vl_logic_vector(31 downto 0);
        bushA           : in     vl_logic_vector(31 downto 0)
    );
end calculate_pc;
