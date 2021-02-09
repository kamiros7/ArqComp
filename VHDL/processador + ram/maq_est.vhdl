library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--NOME : LUIS CAMILO JUSSIANI MOREIRA
--RA: 2063166

entity maq_est is  
    port(  -- entradas e saídas 
            clk : in std_logic; --clk
            rst : in std_logic; --reset
            write_enable : in std_logic; --enable para escrita no registrador
            data_out : out unsigned (1 downto 0) --estado da maquina  
    );
end entity;

architecture a_maq_est of maq_est is  
    signal estado : unsigned(1 downto 0);
begin
    
    process(clk,rst,write_enable) --acionado se houver mudança nos parametros contidos no process
    begin
        if rst ='1' then     -- if é um comando para inferir flip-flops, e não o if comum de programação
           estado <= "00"; -- o if deve ser usado apenas para clock, rst e enable 
        elsif write_enable ='1' then
            if rising_edge(clk) then
                if estado = "11" then --agora tem quartro estados, antes eram 3 estados ou seja estado = "10"
                    estado <= "00";
                else 
                estado <= estado + 1;
                end if;
            end if;
        end if;

    end process;
    data_out <= estado;
end architecture;
