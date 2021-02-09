library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity pc_somador_tb is
end;

architecture a_pc_somador_tb of pc_somador_tb is
    component pc_somador
    port( data_in : in unsigned (6 downto 0);
          data_out : out unsigned(6 downto 0)
    );
    end component;

    signal data_in, data_out : unsigned(6 downto 0);

begin
    uut: pc_somador port map( data_in => data_in,
                              data_out => data_out

    );

    process 
    begin 
        data_in <= "1000101";
        wait for 50 ns;
        wait;
    end process;

end architecture ; -- 