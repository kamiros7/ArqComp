library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

--NOME : LUIS CAMILO JUSSIANI MOREIRA
--RA: 2063166

entity reg1bit_tb is
end;

architecture a_reg1bit_tb of reg1bit_tb is
    component reg1bit
    port(  -- entradas e saídas 
    clk : in std_logic; --clk
    rst : in std_logic; --reset
    write_enable : in std_logic; --enable para escrita no registrador
    data_in : in std_logic; -- resultado provisório que entra novamente no registrador
    data_out :out std_logic --saída do registrador

    );
    end component;

    signal clk, rst, write_enable: std_logic;
    signal data_in, data_out: std_logic;

begin
    uut: reg1bit port map( clk => clk,
                            rst => rst,
                            write_enable => write_enable,
                            data_in => data_in,
                            data_out => data_out

    );
    process --sinal do clock
    begin   
        clk <= '0';
        wait for 25 ns;
        
        clk <= '1';
        wait for 25 ns;
        end process;

    process -- sinal de reset
    begin
        rst <= '1';
        wait for 25 ns;
        rst <= '0';
        wait for 1000 ns;
        end process;

end architecture ;  