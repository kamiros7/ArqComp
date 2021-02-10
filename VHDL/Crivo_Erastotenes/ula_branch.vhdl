library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

--NOME : LUIS CAMILO JUSSIANI MOREIRA
--RA: 2063166
entity ula_branch is
    port( in_x : in unsigned(6 downto 0);
          in_y : in unsigned(6 downto 0);
          saida: out unsigned(6 downto 0)
        );
end entity;

architecture a_ula_branch of ula_branch is
    signal soma, subtracao, valor : unsigned (6 downto 0);
    signal sinal_do_valor : std_logic;
begin 

    sinal_do_valor <= in_y(6); --pego o MSB para saber se eh um num "negativo"
    valor <= '0' & in_y(5 downto 0); --crio um valor sem sinal, com o mesmo valor em modulo       
    soma <= in_x+valor; 
    subtracao <= in_x - valor;    
    
    saida <= soma when sinal_do_valor = '0' else --de acordo com o MSB do in_y, onde eh a entrada do branch, sei 
             subtracao when sinal_do_valor = '1' else --se devo somar ou subtrair apra obter o msm resultado
             "0000000";    

    
end architecture;       
