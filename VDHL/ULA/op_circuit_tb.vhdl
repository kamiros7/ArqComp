library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

--NOME : LUIS CAMILO JUSSIANI MOREIRA
--RA: 2063166

entity op_circuit_tb is
end;

architecture a_op_circuit_tb of op_circuit_tb is
    component op_circuit
    port ( in_x : in unsigned(15 downto 0);
           in_y: in unsigned(15 downto 0);
           sel_op : in unsigned(2 downto 0);
           soma, subtracao, maior  : buffer unsigned(15 downto 0);
           saida : out unsigned(15 downto 0);
           sinal_x : out std_logic; --saida de 1 bit que demonstra o sinal de x, também está como operação para saíde de 16 bits
           sinal_y : out std_logic --saida de 1 bit que demonstra o sinal de y, , também está como operação para saíde de 16 bits
    );
    end component;
    signal in_x, in_y, soma, subtracao, saida, maior : unsigned(15 downto 0);
    signal sel_op : unsigned(2 downto 0);
    signal sinal_x, sinal_y : std_logic;
    begin 
        uut: op_circuit port map( in_x => in_x,
                                  in_y => in_y,
                                  soma => soma,
                                  subtracao => subtracao,
                                  sel_op => sel_op,
                                  maior => maior,
                                  saida => saida,
                                  sinal_x => sinal_x,
                                  sinal_y => sinal_y
                                  );
    process 
    begin 
    in_x <= "0001000010000010"; --soma padrão
    in_y <= "1000010000001000";
    sel_op <= "000";
    wait for 25 ns;
    
    in_x <= "1000000010000010"; --soma que resultará em carry
    in_y <= "1000010000000010";
    sel_op <= "000";
    wait for 25 ns;

    in_x <= "0001001001000001"; --subtração padrao
    in_y <= "0001000000001010"; 
    sel_op <= "001";
    wait for 25 ns;

    in_x <= "0000000010010010"; --subtração sendo x < y
    in_y <= "1010100000011010";
    sel_op <= "001";
    wait for 25 ns;


    in_x <= "0100000010010010"; --comparação que retorna maior sendo x < y
    in_y <= "1010100000011010";
    sel_op <= "010";
    wait for 25 ns;

    in_x <= "1000000010010010"; --comparação que retorna maior sendo x > y
    in_y <= "0010100000011010";
    sel_op <= "010";
    wait for 25 ns;     

     in_x <= "1000000010010010"; --comparação que retorna maior sendo x = y
        in_y <= "1000000010010010";
        sel_op <= "010";
        wait for 25 ns;

    in_x <= "0000000010010010"; --sinal positivo de x 
    in_y <= "1010100000011010";
    sel_op <= "011";
    wait for 25 ns;

    in_x <= "1011000010010010"; --sinal negativo de x
    in_y <= "1001100010010010";
    sel_op <= "011";
    wait for 25 ns;

    in_x <= "1000000010010010"; --sinal positivo de y
    in_y <= "0001100010010010";
    sel_op <= "100";
    wait for 25 ns;

    in_x <= "0000001010010010"; --sinal negativo de y
    in_y <= "1000000010010010";
    sel_op <= "100";
    wait for 25 ns;
    wait;
    end process;
end architecture;