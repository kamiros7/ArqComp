  
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_2x7 is
    port( sel         : in std_logic;
          data_in1       : in unsigned(6 downto 0);
          data_in2       : in unsigned(6 downto 0);
          data_out       : out unsigned(6 downto 0)
    );
end entity mux_2x7;

architecture a_mux_2x7 of mux_2x7 is
begin
    data_out <= data_in1      when sel='0'    else
                data_in2      when sel='1'    else
               "0000000";
end architecture a_mux_2x7;