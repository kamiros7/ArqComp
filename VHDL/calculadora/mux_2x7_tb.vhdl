library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_2x7_tb is
end entity ;

architecture a_mux_2x7_tb of mux_2x7_tb is
	component mux_2x7 is
		port (
			  sel         : in std_logic;
	          data_in1	  : in unsigned(6 downto 0);
	          data_in2 	  : in unsigned(6 downto 0);
	          data_out    : out unsigned(6 downto 0)
		);
	end component mux_2x7;
	signal sel : std_logic;
	signal data_in1, data_in2, data_out : unsigned(6 downto 0);
begin
	uut : mux_2x7 port map (sel => sel, data_in1 => data_in1, data_in2 => data_in2, data_out => data_out);

	process
	begin
		sel <= '0';
		data_in1<= "1111111";
		data_in2  <= "1010101";
		wait for 50 ns;
		sel <= '1';
		wait for 50 ns;
		data_in1 <= "0110001";
		data_in2 <= "1110000";
		wait for 50 ns;
		wait;
	end process;
end architecture ;
