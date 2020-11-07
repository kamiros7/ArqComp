library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity p_uc_tb is
end; 

architecture a_p_uc_tb of p_uc_tb is
    component p_uc
    port( clk, rst, write_enable : in std_logic;
         -- data_in: in unsigned (15 downto 0);
          data_out_mem_rom: out unsigned (15 downto 0);
          data_out_pc: out unsigned (6 downto 0)
         
    );
    end component;

signal  data_out_mem_rom : unsigned (15 downto 0);
signal data_out_pc : unsigned (6 downto 0);
signal clk, rst, write_enable : std_logic;
begin
    uut : p_uc port map (
                          clk => clk, 
                          rst => rst,
                          write_enable => write_enable,
                          --data_in => data_in, 
                          data_out_mem_rom => data_out_mem_rom,
                          data_out_pc => data_out_pc

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

    process
    begin
        write_enable <= '1';
        --data_in <= "1000000000000000";
        wait for 25 ns;
    wait;
    end process;
end architecture; -- 