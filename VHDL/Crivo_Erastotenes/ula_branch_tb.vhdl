library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity ula_branch_tb is
end;

architecture a_ula_branch_tb of ula_branch_tb is
    component ula_branch
    port( in_x : in unsigned(6 downto 0);
          in_y : in unsigned(6 downto 0);
          saida: out unsigned(6 downto 0)
          
    );
    end component;

    signal  in_x :  unsigned(6 downto 0);
    signal in_y :  unsigned(6 downto 0);
    signal saida :  unsigned(6 downto 0);
    
begin
    uut: ula_branch port map ( in_x => in_x,
                          in_y => in_y,
                          saida => saida
    );
    process
    begin
    in_x <= "0000101";
    in_y <= "1000111";
    wait for 25 ns;

    in_x <= "1000011";
    in_y <= "0001000";
    wait for 25 ns;
    
    in_x <= "1000001";
    in_y <= "1000010";
    wait for 25 ns;
    
    in_x <= "0000010";
    in_y <= "0000010";
    wait for 25 ns;
    wait;
    end process;
end architecture ; -- 