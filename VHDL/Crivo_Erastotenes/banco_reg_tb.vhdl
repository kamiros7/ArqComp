library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

--NOME : LUIS CAMILO JUSSIANI MOREIRA
--RA: 2063166

entity banco_reg_tb is
end;

architecture a_banco_reg_tb of banco_reg_tb is
    component banco_reg
    port(  clk : in std_logic;
           rst : in std_logic;
           write_enable: in std_logic;
           read_data1, read_data2 : out unsigned(15 downto 0);
           write_data : in unsigned(15 downto 0);
           read_reg1, read_reg2, write_reg : in unsigned(2 downto 0)
    );
    end component;
    signal clk, rst, write_enable : std_logic;
    signal write_reg, read_reg1, read_reg2 : unsigned(2 downto 0);
    signal read_data1, read_data2, write_data : unsigned( 15 downto 0);


    begin 
        uut : banco_reg port map( write_reg => write_reg,
                                  read_reg1 => read_reg1,
                                  read_reg2 => read_reg2,
                                  read_data1 => read_data1,
                                  read_data2 => read_data2,
                                  write_data => write_data,
                                  clk => clk,
                                  rst => rst,
                                  write_enable => write_enable
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
        
    process -- sinais dos casos de teste
    begin
        read_reg1 <= "000"; --gravando dado no reg1, rd1 lendo o reg1 e rd2 lendo o reg2
        read_reg2 <= "001";
        write_reg <= "000";
        write_data <= "1111111110000001";
        write_enable <= '0';
        wait for 100 ns; 
        read_reg1 <= "000"; --gravando dado no reg1, rd1 lendo o reg1 e rd2 lendo o reg2
        read_reg2 <= "001";
        write_reg <= "000";
        write_data <= "1000110010000001";
        write_enable <= '1';
        wait for 100 ns;

        read_reg1 <= "000"; --gravando dado no reg2, rd1 lendo o reg1 e rd2 lendo o reg2
        read_reg2 <= "001";
        write_reg <= "001";
        write_data <= "1111000001111111";
        write_enable <= '1';
        wait for 100 ns;
        read_reg1 <= "000"; --gravando dado no reg2, rd1 lendo o reg1 e rd2 lendo o reg2
        read_reg2 <= "001";
        write_reg <= "001";
        write_data <= "1111000001000011";
        write_enable <= '1';
        wait for 100 ns;

        read_reg1 <= "010"; --gravando dado no reg3, rd1 lendo o reg2 e rd2 lendo o reg3
        read_reg2 <= "001";
        write_reg <= "010";
        write_data <= "1111111001111111";
        write_enable <= '0';
        wait for 100 ns;
        read_reg1 <= "010"; --gravando dado no reg3, rd1 lendo o reg2 e rd2 lendo o reg3
        read_reg2 <= "001";
        write_reg <= "010";
        write_data <= "0001111001111111";
        write_enable <= '0';
        wait for 100 ns;

        read_reg1 <= "000"; --gravando dado do reg4, red1 lendo reg0, rd2 lendo reg4
        read_reg2 <= "011";
        write_reg <= "011";
        write_data <= "1100000111111111";
        write_enable <= '0';
        wait for 100 ns;
        read_reg1 <= "000"; --gravando dado do reg4, red1 lendo reg0, rd2 lendo reg4
        read_reg2 <= "011";
        write_reg <= "011";
        write_data <= "1100000110000011";
        write_enable <= '1';
        wait for 100 ns;

        read_reg1 <= "000"; --gravando dado do reg5, red1 lendo reg0, rd2 lendo reg5
        read_reg2 <= "100";
        write_reg <= "100";
        write_data <= "0000000111111111";
        write_enable <= '1';
        wait for 100 ns;
        read_reg1 <= "000"; --gravando dado do reg5, red1 lendo reg0, rd2 lendo reg5
        read_reg2 <= "011";
        write_reg <= "011";
        write_data <= "0000000110110011";
        write_enable <= '1';
        wait for 100 ns;

        read_reg1 <= "101"; --gravando dado do reg6, red1 lendo reg6, rd2 lendo reg4
        read_reg2 <= "011";
        write_reg <= "101";
        write_data <= "1000000111111111";
        write_enable <= '1';
        wait for 100 ns;
        read_reg1 <= "101"; --gravando dado do reg6, red1 lendo reg6, rd2 lendo reg4
        read_reg2 <= "011";
        write_reg <= "101";
        write_data <= "1100000110000011";
        write_enable <= '1';
        wait for 100 ns;

        read_reg1 <= "110"; --gravando dado do reg7, red1 lendo reg7, rd2 lendo reg2
        read_reg2 <= "001";
        write_reg <= "110";
        write_data <= "1100000111100010";
        write_enable <= '0';
        wait for 100 ns;
        read_reg1 <= "110"; --gravando dado do reg7, red1 lendo reg7, rd2 lendo reg2
        read_reg2 <= "001";
        write_reg <= "110";
        write_data <= "0000000110000000";
        write_enable <= '0';
        wait for 100 ns;

        read_reg1 <= "000"; --gravando dado do reg8, red1 lendo reg0, rd2 lendo reg8
        read_reg2 <= "111";
        write_reg <= "111";
        write_data <= "0000000001111111";
        write_enable <= '1';
        wait for 100 ns;
        read_reg1 <= "000"; --gravando dado do reg8, red1 lendo reg0, rd2 lendo reg8
        read_reg2 <= "111";
        write_reg <= "111";
        write_data <= "1100000000000011";
        write_enable <= '0';
        wait for 100 ns;

        read_reg1 <= "011"; --gravando dado no reg1, rd1 lendo o reg4 e rd2 lendo o reg2 
        read_reg2 <= "001";
        write_reg <= "000";
        write_data <= "1111111111100111";
        write_enable <= '0';
        wait for 100 ns;
        read_reg1 <= "011"; --gravando dado no reg1, rd1 lendo o reg4 e rd2 lendo o reg2 
        read_reg2 <= "001";
        write_reg <= "000";
        write_data <= "0000111111100111";
        write_enable <= '1';
        wait for 100 ns;
        wait;
    end process;
    
end architecture ;  

    