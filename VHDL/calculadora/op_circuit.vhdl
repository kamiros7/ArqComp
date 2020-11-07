library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

--NOME : LUIS CAMILO JUSSIANI MOREIRA
--RA: 2063166
entity op_circuit is
    port( in_x : in unsigned(15 downto 0);
          in_y : in unsigned(15 downto 0);
          sel_op : in unsigned(2 downto 0);
          --soma, subtracao, maior : buffer unsigned(15 downto 0);
          saida : out unsigned(15 downto 0);
          sinal_x, sinal_y : out std_logic
    );
end entity;

architecture a_op_circuit of op_circuit is
    signal soma, subtracao, maior, movimentar : unsigned (15 downto 0);
begin 
    soma <= in_x+in_y;
    subtracao <= in_x - in_y;    
    
    maior <= in_x when in_x > in_y else -- essa funcao nao eh usada, pois nao tem no up, 
             in_y when in_x <= in_y else
             "0000000000000000";
    
    sinal_x <= in_x(15);
    sinal_y <= in_y(15);
    movimentar <= in_y; -- movimentacao de dados MOV in_x, in_y
    saida <= soma when sel_op = "000" else
             subtracao when sel_op = "001" else
             maior when sel_op = "010" else --NADA DESSAS OPERACOES DE SINAL VAO SER USADAS, QUE DESPERDICIOS TINHA FEITO KKKKKK
             movimentar when sel_op = "011" else
             "0000000000000000";

end architecture;       
