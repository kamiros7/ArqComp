library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity sign_extend is 
    port ( 
            in_x : in unsigned(5 downto 0);
            data_out : out unsigned(15 downto 0)
    );
end entity;

architecture a_sign_extend of sign_extend is
    signal extensor : unsigned (15 downto 0);
    begin 
    extensor <= "0000000000000000" when in_x(5) = '0' else
                "1111111111000000";
    data_out <= extensor + in_x;
end architecture;