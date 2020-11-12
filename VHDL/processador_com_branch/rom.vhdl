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
        0 => B"0001_010_010_000000",   --ADD R3,0
        1 => B"0001_011_011_000000",  --ADD R4, 0
        2 => B"0000_011_011_010_000", --ADD R4, R3
        3 => B"0001_010_010_000001",  --ADD R3, R1
        4 => B"0001_000_010_011110",   --pega o valor do reg 1, compara com a constante para ver se eh diferente da const 30
        5 => B"1000_10_010_1000100",   --JMPR cc_eq,3 como pc esta na proxima instrucao, entao precisa voltar 4 end
        6 => B"0101_100_100_011_000",  --MOV r5, r4
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