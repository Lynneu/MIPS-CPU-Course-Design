library verilog;
use verilog.vl_types.all;
entity gpr is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        RegWrite        : in     vl_logic;
        overflow        : in     vl_logic;
        ins             : in     vl_logic_vector(31 downto 0);
        write_reg       : in     vl_logic_vector(4 downto 0);
        write_data      : in     vl_logic_vector(31 downto 0);
        bushA           : out    vl_logic_vector(31 downto 0);
        bushB           : out    vl_logic_vector(31 downto 0)
    );
end gpr;
