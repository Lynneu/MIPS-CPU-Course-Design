library verilog;
use verilog.vl_types.all;
entity controller is
    port(
        ins             : in     vl_logic_vector(31 downto 0);
        if_jr           : out    vl_logic;
        if_beq          : out    vl_logic;
        if_j            : out    vl_logic;
        MemWrite        : out    vl_logic;
        MemtoReg        : out    vl_logic_vector(1 downto 0);
        RegWrite        : out    vl_logic;
        regdst          : out    vl_logic_vector(1 downto 0);
        alusrc          : out    vl_logic;
        aluctr          : out    vl_logic_vector(1 downto 0);
        extop           : out    vl_logic_vector(1 downto 0)
    );
end controller;
