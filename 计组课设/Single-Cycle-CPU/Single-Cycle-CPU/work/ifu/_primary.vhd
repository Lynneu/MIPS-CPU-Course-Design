library verilog;
use verilog.vl_types.all;
entity ifu is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        if_beq          : in     vl_logic;
        zero            : in     vl_logic;
        if_j            : in     vl_logic
    );
end ifu;
