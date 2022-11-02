library verilog;
use verilog.vl_types.all;
entity ALU is
    port(
        a               : in     vl_logic_vector(31 downto 0);
        b               : in     vl_logic_vector(31 downto 0);
        alu_ctr         : in     vl_logic_vector(1 downto 0);
        alu_out         : out    vl_logic_vector(31 downto 0);
        zero            : out    vl_logic;
        overflow        : out    vl_logic;
        sltout          : out    vl_logic_vector(31 downto 0);
        dm_addr         : out    vl_logic_vector(13 downto 0)
    );
end ALU;
