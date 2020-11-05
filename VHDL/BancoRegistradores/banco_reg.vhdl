library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--NOME : LUIS CAMILO JUSSIANI MOREIRA
--RA: 2063166

entity banco_reg is
    port( 
           clk : in std_logic;
           rst : in std_logic;
           write_enable : in std_logic;
           read_data1, read_data2 : out unsigned(15 downto 0); --dados lidos do registradores
           write_data : in unsigned(15 downto 0); --dado que sera escrito no registrador
           read_reg1, read_reg2, write_reg : in unsigned(2 downto 0) --seletores dos registradores para escrita e leitura
    );
end entity;

architecture a_banco_reg of banco_reg is
    component reg16bits is
        port(  -- entradas e saídas 
        clk : in std_logic; --clk
        rst : in std_logic; --reset
        write_enable : in std_logic; --enable para escrita no registrador
        data_in : in unsigned(15 downto 0); -- resultado provisório que entra novamente no registrador
        data_out :out unsigned(15 downto 0) --saída do registrador
    );
    end component;
    
signal data_out1, data_out2, data_out3 ,data_out4, data_out5, data_out6, data_out7, data_out8 : unsigned (15 downto 0);
signal registro1, registro2, registro3, registro4, registro5, registro6, registro7,registro8 : unsigned(15 downto 0);
signal write_enable1, write_enable2, write_enable3, write_enable4, write_enable5, write_enable6, write_enable7, write_enable8 : std_logic;
begin 
        reg1 : reg16bits port map (clk => clk, rst => rst, write_enable => write_enable1, data_out => data_out1,data_in => "0000000000000000");
        reg2 : reg16bits port map (clk => clk, rst => rst, write_enable => write_enable2, data_out => data_out2,data_in => write_data);
        reg3 : reg16bits port map (clk => clk, rst => rst, write_enable => write_enable3, data_out => data_out3,data_in => write_data);
        reg4 : reg16bits port map (clk => clk, rst => rst, write_enable => write_enable4, data_out => data_out4,data_in => write_data);
        reg5 : reg16bits port map (clk => clk, rst => rst, write_enable => write_enable5, data_out => data_out5,data_in => write_data);
        reg6 : reg16bits port map (clk => clk, rst => rst, write_enable => write_enable6, data_out => data_out6,data_in => write_data);
        reg7 : reg16bits port map (clk => clk, rst => rst, write_enable => write_enable7, data_out => data_out7,data_in => write_data);
        reg8 : reg16bits port map (clk => clk, rst => rst, write_enable => write_enable8, data_out => data_out8,data_in => write_data);


        --SETANDO AS SAIDAS DOS DADOS DOS REGISTRADORES DE ACORDO COM OS SELETORES --
        read_data1 <= data_out1 when read_reg1 = "000" else
                      data_out2 when read_reg1 = "001" else
                      data_out3 when read_reg1 = "010" else
                      data_out4 when read_reg1 = "011" else
                      data_out5 when read_reg1 = "100" else
                      data_out6 when read_reg1 = "101" else
                      data_out7 when read_reg1 = "110" else
                      data_out8 when read_reg1 = "111" else
                      "0000000000000000";

        
        read_data2 <= data_out1 when read_reg2 = "000" else
                      data_out2 when read_reg2 = "001" else
                      data_out3 when read_reg2 = "010" else
                      data_out4 when read_reg2 = "011" else
                      data_out5 when read_reg2 = "100" else
                      data_out6 when read_reg2 = "101" else
                      data_out7 when read_reg2 = "110" else
                      data_out8 when read_reg2 = "111" else
                      "0000000000000000";


        --  SETS DE ESCRITA --
        write_enable1 <= write_enable when write_reg = "000" else --será que devo implementar o enable1, já que nunca será modificado ?
                         '0';
        write_enable2 <= write_enable when write_reg = "001" else
                         '0';
        write_enable3 <= write_enable when write_reg = "010" else
                         '0';
        write_enable4 <= write_enable when write_reg = "011" else
                         '0';
        write_enable5 <= write_enable when write_reg = "100" else
                         '0';
        write_enable6 <= write_enable when write_reg = "101" else
                         '0';
        write_enable7 <= write_enable when write_reg = "110" else
                         '0';
        write_enable8 <= write_enable when write_reg = "111" else
                         '0';
                         
        
end architecture;

