library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--NOME : LUIS CAMILO JUSSIANI MOREIRA
--RA: 2063166

entity pc_reg is  
    port(  -- entradas e saídas 
            clk : in std_logic; --clk
            rst : in std_logic; --reset
            write_enable : in std_logic; --enable para escrita no registrador
            data_in : in unsigned(6 downto 0); -- resultado provisório que entra novamente no registrador
            data_out :out unsigned(6 downto 0) --saída do registrador

    );
end entity;

architecture a_pc_reg of pc_reg is  
    signal registro : unsigned(6 downto 0);
begin
    process(clk,rst,write_enable) --acionado se houver mudança nos parametros contidos no process
    begin
        if rst ='1' then     -- if é um comando para inferir flip-flops, e não o if comum de programação
           registro <= "0000000"; -- o if deve ser usado apenas para clock, rst e enable
        elsif write_enable ='1' then
            if rising_edge(clk) then
                registro <= data_in;
            end if;
        end if;
    end process;

    data_out <= registro;
    
end architecture;