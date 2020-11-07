library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity p_uc is
    port( clk, rst, write_enable : in std_logic;
          --data_in: in unsigned (15 downto 0);
          data_out_mem_rom: out unsigned (15 downto 0);
          data_out_pc : out unsigned (6 downto 0)
    );
end entity;

architecture a_p_uc of p_uc is
    component pc_reg is
        port(  -- entradas e saídas 
            clk : in std_logic; --clk
            rst : in std_logic; --reset
            write_enable : in std_logic; --enable para escrita no registrador
            data_in : in unsigned(6 downto 0); -- resultado provisório que entra novamente no registrador
            data_out :out unsigned(6 downto 0) --saída do registrador

    );
    end component;

    component pc_somador is 
        port( data_in : in unsigned (6 downto 0);
              data_out : out unsigned(6 downto 0)
    );
    end component;
    signal data_in_uc, data_out_uc : unsigned (6 downto 0); --saida e entrada do somador

    component rom is 
        port( clk : in std_logic;
            endereco : in unsigned(6 downto 0);
            dado: out unsigned(15 downto 0)
    );
    end component;
     signal data_out_rom : unsigned (15 downto 0); -- saida da rom

    component reg16bits is
        port(  -- entradas e saídas 
            clk : in std_logic; --clk
            rst : in std_logic; --reset
            write_enable : in std_logic; --enable para escrita no registrador
            data_in : in unsigned(15 downto 0); -- resultado provisório que entra novamente no registrador
            data_out :out unsigned(15 downto 0) --saída do registrador
        );

    end component;
     signal data_out_reg_rom : unsigned (15 downto 0); -- saida da reg que recebe os dados da rom

    component maq_est is
        port(  -- entradas e saídas 
            clk : in std_logic; --clk
            rst : in std_logic; --reset
            write_enable : in std_logic; --enable para escrita no registrador
            data_out : out std_logic
    );
    end component;

    component mux_2x7 is 
        port( sel         : in std_logic;
          data_in1       : in unsigned(6 downto 0); --entrada do pc
          data_in2       : in unsigned(6 downto 0); -- entrada do jump
          data_out       : out unsigned(6 downto 0) -- ssaida da mux
    );
    end component;
    signal jump_end,saida_mux : unsigned (6 downto 0); -- endereco destino do jump e a saida da mux entre jump e PC
    signal jump_sel : std_logic; --seletor do mux PC/JUMP
   
   
   
    signal estadoRom, estadoPc, estado : std_logic; --contém os "estados" que habilitam o funcionamento de partes do circuito, sendo esse estado a saida da maq_est
    
    signal opcode : unsigned ( 5 downto 0); -- sinal para conter o opcode vindo do dado da reg_rom

begin
    regPC : pc_reg port map ( clk => clk,
                       rst => rst,
                       write_enable => estadoPc, -- habilita ou não o uso do reg, de acordo com o estado
                       data_in => saida_mux, --entrada com +1
                       data_out => data_in_uc --saida do pc antes de entrar no somador
    );    
    somador : pc_somador port map( data_in => data_in_uc, --entrada do somador
                                  data_out => data_out_uc --saida do somador

    );

    mem_rom : rom port map ( endereco => data_in_uc, --endereco para acessar o "array" na rom para pegar os dados 
                             clk => clk,
                             dado => data_out_rom --dado contigo em cada enddereco

    );
    regROM : reg16bits port map( clk => clk,
                                 rst => rst,
                                 write_enable => estadoRom,  -- habilita ou não o uso do reg, de acordo com o estado
                                 data_in => data_out_rom , -- entra o dado vindo da rom
                                 data_out => data_out_reg_rom --sai o dado 

    );

    maquina_estado : maq_est port map (clk => clk, 
                                       rst => rst,
                                       write_enable => write_enable, 
                                       data_out => estado --define as partes do circuito que estarao ativos de acordo com o estado
    );

    mux : mux_2x7 port map ( sel => jump_sel, --seletor da mux que selecionara o dado vindo do pc ou do jump
                                   data_in1 => data_out_uc, --endereco vindo do pc
                                   data_in2 => jump_end, --endereco destino do jump
                                   data_out => saida_mux 

    );
    
    estadoRom <= estado;
    estadoPc <= not(estado);

    --escreve na rom em zero e atualiza o PC em 1

    --coloquei os 6 bits MSB para o opcode
    --meu jump: opcode 000010
    --o endereco destino utiliza o 7 LSB 

    --opcode <= data_out_reg_rom(15 downto 10);
    --jump_end <= data_out_reg_rom(6 downto 0);

    opcode <= data_out_rom(15 downto 10);
    jump_end <= data_out_rom(6 downto 0);
    
    jump_sel <= '1'  when opcode = "000010" else
                '0';

    
    data_out_mem_rom <= data_out_reg_rom; -- teste para o dado que sai da rom
    data_out_pc <= data_in_uc; --teste para saber o endereço que entra na rom
end architecture;    
