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
    signal soma, subtracao, maior : unsigned (15 downto 0);
begin 
    soma <= in_x+in_y;
    subtracao <= in_x - in_y;    
    
    maior <= in_x when in_x > in_y else
             in_y when in_x <= in_y else
             "0000000000000000";
    
    sinal_x <= in_x(15);
    sinal_y <= in_y(15);

    saida <= soma when sel_op = "000" else
             subtracao when sel_op = "001" else
             maior when sel_op = "010" else --NADA DESSAS OPERAÇÕES DE SINAL VÃO SER USADAS, QUE DESPERDICIOS DE BITS KKKKKK
             "0000000000000000" when sel_op = "011" and in_x(15) = '0' else --sinal positivo de x (além de verificar o sinal, isso poderia ser usado como extensor de sinal )
             "1111111111111111" when sel_op = "011" and in_x(15) = '1' else --sinal negativo de x
             "0000000000000000" when sel_op = "100" and in_y(15) = '0' else --sinal positivo de y
             "1111111111111111" when sel_op = "100" and in_y(15) = '1' else --sinal negativo de y
             "0000000000000000";

end architecture;       
