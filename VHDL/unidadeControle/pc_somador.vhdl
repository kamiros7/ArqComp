library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity pc_somador is 
    port( data_in : in unsigned (6 downto 0);
          data_out :out unsigned(6 downto 0)
    );
end entity;

architecture a_pc_somador of pc_somador is
    signal somador : unsigned(6 downto 0);
begin 
   somador <= data_in +1;
   data_out <= somador;
end architecture;