library verilog;
use verilog.vl_types.all;
entity controller is
    generic(
        s0              : integer := 0;
        s1              : integer := 1;
        s2              : integer := 2;
        s3              : integer := 3;
        s4              : integer := 4;
        s5              : integer := 5;
        s6              : integer := 6;
        s7              : integer := 7;
        s8              : integer := 8;
        s9              : integer := 9;
        s10             : integer := 10;
        s11             : integer := 11;
        s12             : integer := 12;
        s13             : integer := 13
    );
    port(
        ins             : in     vl_logic_vector(31 downto 0);
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        if_jr           : out    vl_logic;
        if_beq          : out    vl_logic;
        if_j            : out    vl_logic;
        MemWrite        : out    vl_logic;
        MemtoReg        : out    vl_logic_vector(1 downto 0);
        RegWrite        : out    vl_logic;
        regdst          : out    vl_logic_vector(1 downto 0);
        alusrc          : out    vl_logic;
        alustr          : out    vl_logic_vector(1 downto 0);
        extop           : out    vl_logic_vector(1 downto 0);
        if_lb           : out    vl_logic;
        if_sb           : out    vl_logic;
        PcWrite         : out    vl_logic;
        IrWrite         : out    vl_logic;
        zero            : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of s0 : constant is 1;
    attribute mti_svvh_generic_type of s1 : constant is 1;
    attribute mti_svvh_generic_type of s2 : constant is 1;
    attribute mti_svvh_generic_type of s3 : constant is 1;
    attribute mti_svvh_generic_type of s4 : constant is 1;
    attribute mti_svvh_generic_type of s5 : constant is 1;
    attribute mti_svvh_generic_type of s6 : constant is 1;
    attribute mti_svvh_generic_type of s7 : constant is 1;
    attribute mti_svvh_generic_type of s8 : constant is 1;
    attribute mti_svvh_generic_type of s9 : constant is 1;
    attribute mti_svvh_generic_type of s10 : constant is 1;
    attribute mti_svvh_generic_type of s11 : constant is 1;
    attribute mti_svvh_generic_type of s12 : constant is 1;
    attribute mti_svvh_generic_type of s13 : constant is 1;
end controller;
