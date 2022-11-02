library verilog;
use verilog.vl_types.all;
entity im_reg is
    port(
        clk             : in     vl_logic;
        ins             : in     vl_logic_vector(31 downto 0);
        ins_reg         : out    vl_logic_vector(31 downto 0);
        IrWrite         : in     vl_logic
    );
end im_reg;
