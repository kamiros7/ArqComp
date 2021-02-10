library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity unidade_controle is
    port( instrucao : in unsigned(15 downto 0);
          estado : in unsigned( 1 downto 0);
          sel_estadoRom, sel_estadoPc, sel_estadoBancoReg, sel_mux_rd2, sel_jump : out std_logic;
          sel_mux_branch : out std_logic;
          sel_estadoRam : out std_logic; --write_enable da ram
          seletor_mux_flags : out unsigned(2 downto 0);
          sel_mux_mem_or_ula : out std_logic; --usado para selecioanar ou o dado da ula ou da memoria para o write data do banco de registradores
          write_reg, read_reg1, read_reg2, sel_op : out unsigned(2 downto 0);
          --opcode : out unsigned(3 downto 0);
          const_rom : out unsigned (5 downto 0);
          is_branch : out std_logic; -- se receber o opcode de branch, relativo ou absoluto, retorna verdadeiro
          branch_end, jump_end : out unsigned (6 downto 0)
    );
end entity;

architecture a_unidade_controle of unidade_controle is

signal opcode : unsigned (3 downto 0);
signal condition_code : unsigned(2 downto 0);
begin 
    
    
    opcode <= instrucao(15 downto 12); 
    condition_code <= instrucao(9 downto 7);
    
    is_branch <= '1' when opcode = "0111" or opcode = "1000" else --JPMR e JPMA
                 '0';

    seletor_mux_flags <= "000" when condition_code = "000" else --equal
                         "001" when condition_code = "001" else --zero
                         "010" when condition_code = "010" else --not_equal
                         "011" when condition_code = "011" else  --not_zero
                         --talvez por not equal e not zero, ou mais tipos
                         "000";

    sel_mux_branch <= '1' when  opcode = "0111" else --ira selecionar 0 para que sela pulo absoluto 
                      '0';  --ira selecionar o pc para que seja relativo
  
    --MUX para os enables dos componentes a seguir, no qual estao entre 1 e 0, a selecao é definida pelo estado(data_out) da maq_estados    
    sel_estadoRom <= '1' when estado = "00" else --ROM habilitada no estado 01
                 '0';

                    
    sel_estadoPc <= '1' when estado = "01" else --PC  habilitado no estado 00
                '0';
    
    sel_estadoBancoReg <= '1' when estado = "10" and ( opcode /= "0110" and opcode /= "0100" and opcode /= "0111" and opcode /= "0100" and opcode /= "1010")  else --BancoReg habilitado no estado 10
                      '0';
            
    sel_estadoRam <= '1' when estado = "11" and opcode = "1010" else --so permite a gravacao na ram caso seja o estado 11 e seja opcode de sw 
                     '0'; --talvez a gravacao pode ser apenas pelo opcode, e voltar a maq de estados a ter apenas 3 estados
                 

    const_rom <= instrucao(5 downto 0);  -- valor da constante inserida na instrucao 
    read_reg1 <= instrucao(8 downto 6);
    read_reg2 <= instrucao(5 downto 3);
    write_reg <= instrucao(11 downto 9);
    --coloquei os 6 bits MSB para o opcode
    --meu jump: opcode 000010
    --o endereco destino utiliza o 7 LSB 

    
    -- mudar questao dos opcodes
    opcode <= instrucao(15 downto 12); --ou data do reg_rom 
    jump_end <= instrucao(6 downto 0); --sera que deveria fazer tratamento when/else para o opcode de jump e branch 
    branch_end <= instrucao(6 downto 0);

    sel_mux_mem_or_ula <= '1' when opcode = "1001" else --instrucao de carregar um dado da memoria num registrador (lw)
                          '0';
    
    sel_jump <= '1'  when opcode = "0100" else
                '0';

    
    sel_mux_rd2 <= '1' when opcode = "0001" or opcode = "0011" else -- seletor ira selecionar constante para add e sub com constante, indicados por esses opcodes
                   '0';

    sel_op <= "000" when opcode = "0000" or opcode = "0001" else --soma
              "001" when opcode ="0010" or opcode = "0011" else --subtracao
              "011" when opcode = "0101" else --movimentar dados entre regs
              "000";


end architecture;