library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

--NOME : LUIS CAMILO JUSSIANI MOREIRA
--RA: 2063166

entity maq_est_tb is
end;

architecture a_maq_est_tb of maq_est_tb is
    component maq_est
    port(  -- entradas e saídas 
    clk : in std_logic; --clk
    rst : in std_logic; --reset
    write_enable : in std_logic; --enable para escrita no registrador
    data_out :out unsigned(1 downto 0)  --saída do registrador
    );
    end component;

    signal clk, rst, write_enable: std_logic;
    signal data_out : unsigned(1 downto 0);

begin
    uut: maq_est port map( clk => clk,
                            rst => rst,
                            write_enable => write_enable,
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
    
    process 
    begin 

       
        write_enable <='0';
        wait for 125 ns;
        
       
        write_enable <='1';
        wait for 125 ns;
        
        write_enable <='1';
        wait for 125 ns;
        
        write_enable <='1';
        wait for 125 ns;
        
       
        write_enable <='1';
        wait for 125 ns;    
        wait;
    end process;
    
    

end architecture ;  