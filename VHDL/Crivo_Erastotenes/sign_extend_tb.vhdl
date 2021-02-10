library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity sign_extend_tb is
end;

architecture a_sign_extend_tb of sign_extend_tb is
    component sign_extend
    port ( 
            in_x : in unsigned(5 downto 0);
            data_out : out unsigned(15 downto 0)
    );
    end component;


    signal data_out : unsigned (15 downto 0);
    signal in_x : unsigned(5 downto 0);

    begin
        uut: sign_extend port map ( 
                              in_x => in_x,
                              data_out => data_out

        );

    process
    begin 
    in_x <= "001100";
    wait for 25 ns;

    in_x <= "011100";
    wait for 25 ns;

    in_x <= "100100";
    wait for 25 ns;
    wait;
    end process;
    end architecture;