library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--NOME : LUIS CAMILO JUSSIANI MOREIRA
--RA: 2063166

entity top_level is 
    port( clk, rst : in std_logic;
          write_reg, read_reg1, read_reg2, sel_op : in unsigned( 2 downto 0); -- seletores resposaveis por selecionar qual registrador sera gravado, lido e operacao feita na ula
          alu_out : out unsigned (15 downto 0); --saida da ula
          cte : in unsigned( 15 downto 0); --constante para o calculo de um addi
          sel_mux_rd2 : in std_logic; --mux responsavel para mandar para ula uma constante ou o dado do read_data2
          sinal_x, sinal_y : out std_logic; -- resposável por dizer o sinal da entrada x/y da ula
          write_enable : in std_logic -- responsável por habilitar ou nao a gravacao
          );
end entity;

architecture a_top_level of top_level is
    component banco_reg is
        port( 
           clk, rst : in std_logic;
           write_reg ,read_reg1, read_reg2 : in unsigned(2 downto 0);
           read_data1, read_data2 : out unsigned(15 downto 0);
           write_data : in unsigned(15 downto 0);
           write_enable : in std_logic
           );
    end component;

    component op_circuit is
        port( in_x, in_y : in unsigned(15 downto 0);
          sel_op : in unsigned(2 downto 0);
          --soma, subtracao, maior : buffer unsigned(15 downto 0);
          saida : out unsigned(15 downto 0);
          sinal_x, sinal_y : out std_logic
    );
    end component; 

    signal read_dataA, read_dataB, alu_write_data, saida_mux_rd2 : unsigned ( 15 downto 0); -- alu_write_data é o sinal que sai da ula e vai para o write_data 
                                                                                            --saida_mux_rd2 é a saida da mux que escolhe entre a constante e a saída do read_data2

    begin
        banco : banco_reg port map(  clk => clk,
                                     rst => rst, 
                                     write_reg => write_reg,
                                     read_reg1 => read_reg1,
                                     read_reg2 => read_reg2, 
                                     read_data1 => read_dataA,
                                     read_data2 => read_DataB,  
                                     write_data => alu_write_data,
                                     write_enable => write_enable
                                     );

        ula : op_circuit port map(  sinal_x => sinal_x, -- pensar no nome 
                                    sinal_y => sinal_y, 
                                    in_x => read_dataA ,
                                    in_y => saida_mux_rd2,
                                    saida => alu_write_data, 
                                    sel_op => sel_op
                                    );
        
        saida_mux_rd2 <= read_dataB when sel_mux_rd2 = '0' else --mux responsavel por selecionar ou a constante ou os dados do registrador B
                         cte when sel_mux_rd2 = '1' else
                         "0000000000000000";  
                                 
                                    
                                    

        alu_out <= alu_write_data;
end architecture;