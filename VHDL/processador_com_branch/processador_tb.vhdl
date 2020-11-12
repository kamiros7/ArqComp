library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity processador_tb is
end; 

architecture a_processador_tb of processador_tb is
    component processador
    port( clk, rst, write_enable : in std_logic;
          read_data1, read_data2, alu_out : out unsigned (15 downto 0); -- saida dos registradores escolhdos e saida da ula
          instrucao: out unsigned (15 downto 0);
          endereco_PC : out unsigned (6 downto 0);
          estadoUP : out unsigned (1 downto 0)
    );
    end component;

signal instrucao : unsigned (15 downto 0);
signal read_data1, read_data2, alu_out : unsigned (15 downto 0);
signal endereco_PC : unsigned (6 downto 0);
signal estadoUP : unsigned (1 downto 0);
signal clk, rst, write_enable : std_logic;
begin
    uut : processador port map (
                          clk => clk, 
                          rst => rst,
                          write_enable => write_enable,
                          alu_out => alu_out,
                          read_data1 => read_data1,
                          read_data2 => read_data2, 
                          instrucao => instrucao,
                          endereco_PC => endereco_PC,
                          estadoUP => estadoUP

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
        wait for 100 ns;
        rst <= '0';
        wait for 10000000 ns;
        end process;

    process
    begin
        write_enable <= '1';
        --data_in <= "1000000000000000";
        wait for 25 ns;
    wait;
    end process;
end architecture; -- 