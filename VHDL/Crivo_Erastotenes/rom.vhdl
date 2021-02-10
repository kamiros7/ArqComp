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
        0 => B"0001_100_100_010010",   --ADD R5, 18
        1 => B"0001_001_001_000010",  --ADD R2, 2
    	2 => B"0101_111_111_100_000", --MOV R8, R5
        3 => B"1010_000_000_100_000", --sw  R5, R0 
        4 => B"1010_000_100_001_000", --SW R2, R5
	    5 => B"0001_111_111_010100", --ADD R8, 20	
        6 => B"1001_011_100_000_000",  --LW R4, R5
        7 => B"1010_000_111_000_000", --SW R1, R8
        8 => B"0001_001_001_011111", --ADD R2, 31		
        9 => B"1010_000_001_111_000", --SW R8, R2 
        10 => B"1001_110_000_000_000", --LW R7, R1   
        11 => B"1001_101_001_000_000",  --LW R6, R2
        others =>(others =>'0')

        --**obs, eh utilizado o opcode 0001 (ou 0011) pois sao funcs que usam a constante, porem como o registrador de escrita
        --eh o registrador zero, logo nao tera mudanca no valor do mesmo
    );

begin 
    process(clk)
    begin
        if(rising_edge(clk)) then
            dado <= conteudo_rom(to_integer(endereco));
        end if;
    end process;
end architecture;