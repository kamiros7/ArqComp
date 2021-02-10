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
          sinal_x, sinal_y : out std_logic;
          zero, carry, equal : out std_logic;
          not_equal, not_zero : out std_logic
    );
end entity;

architecture a_op_circuit of op_circuit is
    signal soma, subtracao, maior, movimentar : unsigned (15 downto 0);
    signal in_x_17, in_y_17, soma_17 : unsigned (16 downto 0);
    signal carry_soma, carry_sub : std_logic;
begin 
    
    --operaçoes do processador 
    soma <= in_x+in_y;
    subtracao <= in_x - in_y;    
    
    maior <= in_x when in_x > in_y else -- essa funcao nao eh usada, pois nao tem no up, 
             in_y when in_x <= in_y else
             "0000000000000000";
    
    movimentar <= in_y; -- movimentacao de dados MOV in_x, in_y
    saida <= soma when sel_op = "000" else
             subtracao when sel_op = "001" else
             maior when sel_op = "010" else --NADA DESSAS OPERACOES DE SINAL VAO SER USADAS, QUE DESPERDICIOS TINHA FEITO KKKKKK
             movimentar when sel_op = "011" else
             "0000000000000000";

    sinal_x <= in_x(15);
    sinal_y <= in_y(15);

    --tratamento de carry--
    in_x_17 <= '0' & in_x;
    in_y_17 <= '0' & in_y;
    soma_17 <= in_x_17 + in_y_17;
    carry_soma <= soma_17(16);
    carry_sub <= '0' when in_y <= in_x else
                 '1';

    --flags/condition code--
    carry <= carry_soma when sel_op = "000" else
             carry_sub when sel_op = "001" else
             '0';
    zero <= '1' when soma = "0000000000000000" or subtracao = "0000000000000000"  else --and (sel_op = "000" or sel_op ="001")
            '0';
    equal<= '1' when in_x = in_y else --talvez colocar and sel_op especificos
            '0';
    
    not_zero <= '0' when soma = "0000000000000000" or subtracao = "0000000000000000"  else --and (sel_op = "000" or sel_op ="001")
                '1';
    not_equal<= '0' when in_x = in_y else --talvez colocar and sel_op especificos
                '1';
    
  
end architecture;       
