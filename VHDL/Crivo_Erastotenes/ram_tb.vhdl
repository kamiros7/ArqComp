library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram_tb is
end;

architecture a_ram_tb of ram_tb is
    component ram
    port(
    clk : in std_logic;
    endereco : in unsigned(6 downto 0);
    wr_en : in std_logic;
    dado_in : in unsigned(15 downto 0);
    dado_out : out unsigned(15 downto 0)
    );
    end component;

signal clk, wr_en : std_logic;
signal endereco : unsigned(6 downto 0);
signal dado_in, dado_out : unsigned(15 downto 0);

begin 

uut : ram port map ( clk => clk,
                     wr_en => wr_en,
                     endereco => endereco,
                     dado_in => dado_in,
                     dado_out => dado_out
);

process
begin 
    clk <= '0';
    wait for 25 ns;

    clk <= '1';
    wait for 25 ns;
    end process;

    process
    begin
    wait;
    end process;
end architecture;