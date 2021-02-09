library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processador is
    port( clk, rst, write_enable : in std_logic; --este enable e para maquina de estados
          read_data1, read_data2, alu_out : out unsigned (15 downto 0); --saida dos registradores escolhdos e saida da ula
          instrucao : out unsigned (15 downto 0); --pino de saida que contem a instrucao
          endereco_PC : out unsigned (6 downto 0); --endereco atual do PC 
          estadoUP : out unsigned (1 downto 0) --pino saida estado atual do processador
    );
end entity;

architecture a_processador of processador is
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
        port( data_in : in unsigned (6 downto 0); -- PC
              data_out : out unsigned(6 downto 0) --PC + 1
    );
    end component;
    signal data_in_somador, data_out_somador : unsigned (6 downto 0); --saida e entrada do somador

    component rom is 
        port( clk : in std_logic;
            endereco : in unsigned(6 downto 0);
            dado: out unsigned(15 downto 0)
    );
    end component;
     signal data_out_rom : unsigned (15 downto 0); -- saida da rom
     signal opcode : unsigned (3 downto 0); -- sinal para conter o opcode vindo do dado da reg_rom

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
            data_out : out unsigned (1 downto 0) --estado da maquina  
    ); --agora neste caso, o estado é o pino seletor de mux, para o enable do PC/reg_rom/banco_reg
    end component;
    signal estadoRom, estadoPc, estadoBancoReg : std_logic; --contém os "estados" que habilitam o funcionamento de partes do circuito, sendo esse estado a saida da maq_est
    signal estado : unsigned (1 downto 0);

    component mux_2x7 is 
        port( sel         : in std_logic;
          data_in1       : in unsigned(6 downto 0); --entrada do pc
          data_in2       : in unsigned(6 downto 0); -- entrada do jump
          data_out       : out unsigned(6 downto 0) -- ssaida da mux
    );
    end component;
    signal saida_mux : unsigned (6 downto 0); -- endereco destino do jump e a saida da mux entre jump e PC
  
    component sign_extend is --na situacao das ligacoes, ligar a entrada com os bits corretos da rom e o dataout na mux(const) do banco_reg
        port ( 
                in_x : in unsigned(5 downto 0);
                data_out : out unsigned(15 downto 0)
        );
    end component;
    signal const: unsigned (15 downto 0); -- esse é o valor depois da extensao


    component top_level is
        port( clk, rst : in std_logic;
          write_reg, read_reg1, read_reg2, sel_op : in unsigned( 2 downto 0); -- seletores resposaveis por selecionar qual registrador sera gravado, lido e operacao feita na ula
          write_data : in unsigned(15 downto 0);
          read_data1, read_data2, alu_out : out unsigned (15 downto 0); --saida dos registradores escolhidos e saida da ula
          cte : in unsigned( 15 downto 0); --constante para o calculo de um addi
          sel_mux_rd2 : in std_logic; --mux responsavel para mandar para ula uma constante ou o dado do read_data2
          sinal_x, sinal_y : out std_logic; -- resposável por dizer o sinal da entrada x/y da ula
          zero, equal, carry : out std_logic; -- flags usadas pelos condition codes
          --lembrar que as saidas acima nao sao diretamente da ula, mas sim de flip flop que guardam ela 
          not_equal, not_zero : out std_logic;
          write_enable : in std_logic -- responsável por habilitar ou nao a gravacao
          );
    end component;
        signal read_dataA, read_dataB : unsigned ( 15 downto 0);
        signal out_mux_to_write_data, alu_out_data : unsigned (15 downto 0); 
        signal flag, zero, equal, carry : std_logic;
        signal not_zero, not_equal : std_logic;
        signal seletor_mux_flags : unsigned(2 downto 0); --seletor da mux das flags, o qual é de acordo com o 
                                                         --condition code, ou seja, os bits especificos da instrucao  
    component unidade_controle is 
        port( instrucao : in unsigned(15 downto 0);
                estado : in unsigned( 1 downto 0);
                sel_estadoRom, sel_estadoPc, sel_estadoBancoReg, sel_mux_rd2, sel_jump : out std_logic;
                sel_estadoRam : out std_logic;
                sel_mux_branch : out std_logic;
                seletor_mux_flags : out unsigned(2 downto 0);
                sel_mux_mem_or_ula : out std_logic;
                write_reg, read_reg1, read_reg2, sel_op : out unsigned(2 downto 0);
                const_rom : out unsigned (5 downto 0);
                jump_end : out unsigned (6 downto 0);
                is_branch : out std_logic;
                branch_end : out unsigned( 6 downto 0)
        );
    end component;

    signal sel_mux_mem_or_ula : std_logic; --usado para selecioanar ou o dado da ula ou da memoria para o write data do banco de registradores
    signal is_branch : std_logic;

    component ula_branch is
        port( in_x : in unsigned(6 downto 0); --entrada x sera o PC(branch relativo) ou 0(branch absuolto)
          in_y : in unsigned(6 downto 0); --entrada do branch
          saida: out unsigned(6 downto 0) 
        );

    end component;
        signal sel_mux_branch : std_logic;
        signal branch_end : unsigned(6 downto 0); --endereco destino do branch
        signal saida_mux_branch : unsigned(6 downto 0); --saida da mux que entrara na ula para calculo do branch
        signal alu_branch_out : unsigned(6 downto 0);
        --branch_end
        --saida_mux_branch -> 0 ou pc
        --alu_branch_out

    component ram is
        port(
        clk : in std_logic;
        endereco : in unsigned(6 downto 0);
        wr_en : in std_logic;
        dado_in : in unsigned(15 downto 0);
        dado_out : out unsigned(15 downto 0)
    );
    end component;
    signal write_enable_ram : std_logic;
    signal data_out_ram : unsigned (15 downto 0);

    ----------------------------------------------------------------------------------
    signal sel_estadoRom, sel_estadoPc, sel_estadoBancoReg, sel_mux_rd2, sel_jump : std_logic; --seletores dos enables, da mux entre constante e read_data2 e da mux PC/JUMP
    signal write_reg, read_reg1, read_reg2, sel_op : unsigned(2 downto 0);
    signal const_rom :  unsigned (5 downto 0);  -- esse valor é o valor de fato da constante vindo da rom 
    signal jump_end : unsigned (6 downto 0);

    signal saida_mux_branch_or_pc : unsigned (6 downto 0);
    signal sel_mux_branch_or_pc : std_logic; --ainda nao definido o valor 
    --seleciona 0 ou pc para a entrada da ula_branch fazer o calculo do branch absoluto ou relatvo na a ula_branch 


begin
    regPC : pc_reg port map ( clk => clk,
                       rst => rst,
                       write_enable => sel_estadoPc, -- habilita ou não o uso do reg, de acordo com o estado
                       data_in => saida_mux, --entrada com +1
                       data_out => data_in_somador --saida do pc antes de entrar no somador
    );    
    somador : pc_somador port map( data_in => data_in_somador, --entrada do somador
                                  data_out => data_out_somador --saida do somador

    );

    mem_rom : rom port map ( endereco => data_in_somador, --endereco para acessar o "array" na rom para pegar os dados 
                             clk => clk,
                             dado => data_out_rom --dado contido em cada enddereco

    );
    
    regROM : reg16bits port map( clk => clk,
                                 rst => rst,
                                 write_enable => sel_estadoRom,  -- habilita ou não o uso do reg, de acordo com o estado
                                 data_in => data_out_rom , -- entra o dado vindo da rom
                                 data_out => data_out_reg_rom --sai o dado 

    );

    maquina_estado : maq_est port map (clk => clk, 
                                       rst => rst,
                                       write_enable => write_enable, 
                                       data_out => estado --define as partes do circuito que estarao ativos de acordo com o estado
    );

    mux : mux_2x7 port map ( sel => sel_jump, --seletor da mux que selecionara o dado vindo do pc ou do jump
                                   data_in1 => saida_mux_branch_or_pc, --endereco vindo do pc ou do destino do branch
                                   data_in2 => jump_end, --endereco destino do jump
                                   data_out => saida_mux 

    );

    extensor : sign_extend port map ( in_x => const_rom,
                                      data_out => const --ai ligar const a cte   
    );
    
    top_banco : top_level port map ( clk => clk, 
                                    rst => rst, 
                                    write_reg => write_reg, 
                                    read_reg1 => read_reg1,
                                    read_reg2 => read_reg2, 
                                    sel_op => sel_op, --seletor de operacao da ula 
                                    alu_out => alu_out_data,
                                    write_data => out_mux_to_write_data,
                                    read_data1 => read_dataA,
                                    read_data2 => read_dataB,
                                    cte => const,
                                    sel_mux_rd2 => sel_mux_rd2 , 
                                    write_enable => sel_estadoBancoReg,
                                    zero => zero,
                                    equal => equal,
                                    carry => carry,
                                    not_equal => not_equal,
                                    not_zero => not_zero
                                    --ver pinos das flags, carry, zero, equal
    );

    uc : unidade_controle port map( instrucao => data_out_reg_rom,
                                    estado => estado,
                                    sel_estadoRom => sel_estadoRom,
                                    sel_estadoPc => sel_estadoPc,
                                    sel_estadoBancoReg => sel_estadoBancoReg,
                                    sel_estadoRam => write_enable_ram,
                                    sel_mux_rd2 => sel_mux_rd2,
                                    seletor_mux_flags => seletor_mux_flags,
                                    sel_jump => sel_jump,
                                    sel_mux_branch => sel_mux_branch,
                                    sel_mux_mem_or_ula => sel_mux_mem_or_ula,
                                    write_reg => write_reg,
                                    read_reg1 => read_reg1,
                                    read_reg2 => read_reg2,
                                    sel_op => sel_op,
                                    const_rom => const_rom,
                                    is_branch => is_branch,
                                    jump_end => jump_end,
                                    branch_end => branch_end

    );
    


    alu_branch : ula_branch port map( in_x => saida_mux_branch,--pensar nos sinais para os pinos
                                      in_y => branch_end,
                                      saida => alu_branch_out
    );

    mem_ram : ram port map ( clk => clk,
                             wr_en => write_enable_ram,
                             endereco => read_dataA(6 downto 0),
                             dado_in =>  read_dataB,
                             dado_out => data_out_ram
    );
    

    flag <= equal when seletor_mux_flags = "000" else --condition codes 
            zero  when seletor_mux_flags = "001" else
            not_equal when seletor_mux_flags = "010" else
            not_zero  when seletor_mux_flags = "011" else
            '0';

    sel_mux_branch_or_pc <= flag and is_branch; 

    saida_mux_branch <= data_out_somador when sel_mux_branch = '0' else    
                        "0000000" when sel_mux_branch = '1' else
                        "0000000";

    saida_mux_branch_or_pc <= alu_branch_out when sel_mux_branch_or_pc = '1' else --end destino do branch
                           data_out_somador when sel_mux_branch_or_pc = '0'  else --end do pc
                           "0000000";

    out_mux_to_write_data <= data_out_ram  when sel_mux_mem_or_ula = '1' else --entrada do dado no banco reg
                             alu_out_data  when sel_mux_mem_or_ula = '0'  else
                             "0000000000000000"    ;
          
    read_data1 <= read_dataA;
    read_data2 <= read_dataB;
    alu_out <= alu_out_data;
    estadoUP <= estado; --estado atual da maq de estados
    instrucao <= data_out_reg_rom; --instrucao que sai do IR 
    endereco_PC <= data_in_somador; -- endereço que entra na rom (sai do PC)
end architecture;    
