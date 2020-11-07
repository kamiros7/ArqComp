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
        -- caso endereco -> conteudo
        0 => "0001000100010001",
        1 => "0001000100000000",
        2 => "1111000000000000",
        3 => "1111000000000001",
        4 => "1000000000001000",
        5 => "0000100000000010", --faz jump aqui e vai para o endereco 2 
        6 => "1111000010000011",
        7 => "0000000001000010", 
        8 => "0000000000101000",
        9 => "0001000000000000",
        10 =>"0000000100000000",
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