library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is   
    port( clk : in std_logic;
          endereco : in unsigned(6 downto 0);
          dado: out unsigned(15 downto 0)

    );
end entity;

architecture a_rom of rom is
    type mem is array ( 0 to 127) of unsigned(15 downto 0);
    constant conteudo_rom : mem := (
        0 => B"0001_010_010_000101",  --ADD R3,5
        1 => B"0001_011_011_001000",  --ADD R4, 8
        2 => B"0000_010_010_011_000", --ADD R3, R4
        3 => B"0000_100_100_010_010", --ADD R5, R3
        4 => B"0010_010_010_011_001", --SUB R3, R4
        5 => B"0011_100_100_000001",  --SUB R5, 1
        6 => B"0100_00000_0010100",   --JMPS 20 0010100 0001000
        7 => B"0100_00000_0010100",   --blobo com instrucoes quaisquer que nao serao utilizadas
        8 => B"0001_110_110_011_000",
        9 => B"0001_000000000000",
    	10 =>B"0000_00010_0000000",
        11 =>B"0000_0001_00000000",
        12 =>B"0000_000100000000",
        13 =>B"0000_00010_0000000",
        14 =>B"0000_00010_0000000",
        15 =>B"0000_000_100000000",
        16 =>B"0000_000_100000000",
        17 =>B"0000_000_100000000",
        18 =>B"0000_000_100000000",
        19 =>B"0000_000_100000000",
        20 =>B"0101_010_010_100_000", --MOV R3, R5
        21 =>B"0100_00010_0000010",   --JPMS 2  ( terceira instrucao )
        22 =>B"0000_000_100000000",   --blobo com instrucoes quaisquer que nao serao utilizadas
        23 =>B"0000_000_100000000",
        24 =>B"0000_000_100000000",
        25 =>B"0000_000_100000000",
        26 =>B"0000_000_100000000",
        27 =>B"0001_110_110_000101",
        28 =>B"0001_010_010_000101",
        -- abaixo : casos omissos => zero em todos os bits
        others =>(others =>'0')
    );

begin 
    process(clk)
    begin
        if(rising_edge(clk)) then
            dado <= conteudo_rom(to_integer(endereco));
        end if;
    end process;
end architecture;