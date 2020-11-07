library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity unidade_controle is
    port( instrucao : in unsigned(15 downto 0);
          estado : in unsigned( 1 downto 0);
          sel_estadoRom, sel_estadoPc, sel_estadoBancoReg, sel_mux_rd2, sel_jump : out std_logic;
          write_reg, read_reg1, read_reg2, sel_op : out unsigned(2 downto 0);
          --opcode : out unsigned(3 downto 0);
          const_rom : out unsigned (5 downto 0);
          jump_end : out unsigned (6 downto 0)
    );
end entity;

architecture a_unidade_controle of unidade_controle is

signal opcode : unsigned (3 downto 0);
begin 


    --MUX para os enables dos componentes a seguir, no qual estao entre 1 e 0, a selecao é definida pelo estado(data_out) da maq_estados    
    sel_estadoRom <= '1' when estado = "00" else --ROM habilitada no estado 01
                 '0';

                    
    sel_estadoPc <= '1' when estado = "01" else --PC  habilitado no estado 00
                '0';
    
    sel_estadoBancoReg <= '1' when estado = "10" else --BancoReg habilitado no estado 10
                      '0'; --isso está modificado, além do estado, tem que ter opcode diferente
                 

    const_rom <= instrucao(5 downto 0);  -- valor da constante inserida na instrucao --passa por um sign extend antes de entrar na ula
    read_reg1 <= instrucao(8 downto 6);
    read_reg2 <= instrucao(5 downto 3);
    write_reg <= instrucao(11 downto 9);
    --coloquei os 4 bits MSB para o opcode
    --meu jump: opcode 0100
    --o endereco destino utiliza o 7 LSB 

    
    -- mudar questao dos opcodes
    opcode <= instrucao(15 downto 12); --ou data do reg_rom 
    jump_end <= instrucao(6 downto 0);
    
    sel_jump <= '1'  when opcode = "0100" else
                '0';

    
    sel_mux_rd2 <= '1' when opcode = "0001" or opcode = "0011" else -- seletor ira selecionar constante para add e sub com constante, indicados por esses opcodes
                   '0';

    sel_op <= "000" when opcode = "0000" or opcode = "0001" else --soma
              "001" when opcode ="0010" or opcode = "0011" else --subtracao
              "011" when opcode = "0101" else --movimentar dados entre regs
              "000";


end architecture;