library verilog;
use verilog.vl_types.all;
entity mux2 is
    port(
        MemtoReg        : in     vl_logic_vector(1 downto 0);
        write_data      : out    vl_logic_vector(31 downto 0);
        alu_out         : in     vl_logic_vector(31 downto 0);
        dm_out          : in     vl_logic_vector(31 downto 0);
        jalPC           : in     vl_logic_vector(31 downto 0);
        sltout          : in     vl_logic_vector(31 downto 0)
    );
end mux2;
