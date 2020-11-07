library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--NOME : LUIS CAMILO JUSSIANI MOREIRA
--RA: 2063166

entity top_level_tb is
end;

architecture a_top_level_tb of top_level_tb is
    component top_level
    port( clk, rst : in std_logic;
          write_reg, read_reg1, read_reg2, sel_op : in unsigned( 2 downto 0); -- seletores resposaveis por selecionar qual registrador sera gravado, lido e operacao feita na ula
          read_data1, read_data2, alu_out : out unsigned (15 downto 0); --saida da ula
          cte : in unsigned( 15 downto 0); --constante para o calculo de um addi
          sel_mux_rd2 : in std_logic; --mux responsavel para mandar para ula uma constante ou o dado do read_data2
          sinal_x, sinal_y : out std_logic; -- resposável por dizer o sinal da entrada x/y da ula
          write_enable : in std_logic -- responsável por habilitar ou nao a gravacao
          );
    end component;

    signal clk, rst, sel_mux_rd2, sinal_x, sinal_y, write_enable : std_logic;
    signal  write_reg, read_reg1, read_reg2, sel_op : unsigned(2 downto 0);
    signal cte, alu_out, read_data1, read_data2 : unsigned (15 downto 0);

    begin
        uut : top_level port map( clk => clk,
                                  rst => rst,
                                  sel_mux_rd2 => sel_mux_rd2,
                                  sinal_x => sinal_x,
                                  sinal_y => sinal_y,
                                  read_reg1 => read_reg1,
                                  read_reg2 => read_reg2,
                                  sel_op => sel_op,
                                  write_enable => write_enable,
                                  write_reg => write_reg,
                                  cte => cte,
                                  read_data1 => read_data1,
                                  read_data2 => read_data2,
                                  alu_out => alu_out
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

    process -- selecionador de operação da ula (soma)
    begin 
        --sel_op <= "000";
        wait;
    end process; 
    

       
    process
    begin
        write_enable <= '1'; -- demonstrando soma de reg3 + constante e gravando no reg2
        write_reg <= "001";
        cte <= "0000100010000010";
        sel_mux_rd2 <= '1';  -- colocar o valor da constante ao inves do nome 
        read_reg1 <= "010";
        read_reg2 <= "001";
        wait for 50 ns;

        write_enable <= '1'; -- demonstrando soma de reg1 + constante e gravando no reg2 (soma com constante zero)
        write_reg <= "001";
        cte <= "0000100010000010";
        sel_mux_rd2 <= '1';
        read_reg1 <= "000";
        read_reg2 <= "001";
        wait for 50 ns;

        write_enable <= '0'; --demonstrando soma, mas não habilitando gravacao em reg3
        write_reg <= "010";
        cte <= "0000100010000010";
        sel_mux_rd2 <= '0';
        read_reg1 <= "010";
        read_reg2 <= "001";
        wait for 50 ns;

        write_enable <= '1'; --demonstrando soma de reg3 + constante e gravando em reg3 
        write_reg <= "010";
        cte <= "0000100010000010";
        sel_mux_rd2 <= '1';
        read_reg1 <= "010";
        read_reg2 <= "001";
        wait for 50 ns;

        write_enable <= '1'; --demonstrando soma de reg3 + constante e gravando em reg3 (acumulando valor em reg3) 
        write_reg <= "010";
        cte <= "0000100010000010";
        sel_mux_rd2 <= '1';
        read_reg1 <= "010";
        read_reg2 <= "001";
        wait for 50 ns;

        write_enable <= '1'; --demonstrando soma de reg2 + reg3 e gravando em reg2  
        write_reg <= "001";
        cte <= "0000100010000010";
        sel_mux_rd2 <= '0';
        read_reg1 <= "010";
        read_reg2 <= "001";
        wait for 50 ns;

        write_enable <= '1'; --demonstrando soma de reg2 + reg3 e gravando em reg2 (acumulando valor em reg2)
        write_reg <= "001";
        cte <= "0000100010000010";
        sel_mux_rd2 <= '0';
        read_reg1 <= "010";
        read_reg2 <= "001";
        wait for 50 ns;

        write_enable <= '1'; --demonstrando que mesmo "gravando" em reg0, o valor nao sera alterado, permanencendo como constante zero
        write_reg <= "000";
        cte <= "0000100010000010";
        sel_mux_rd2 <= '1';
        read_reg1 <= "000";
        read_reg2 <= "001";
        wait for 50 ns;

        write_enable <= '1'; 
        write_reg <= "010";
        cte <= "0000100010000010";
        sel_mux_rd2 <= '1';
        read_reg1 <= "010";
        read_reg2 <= "001";
        wait for 150 ns;
        wait;
        
    end process;

end  architecture; --