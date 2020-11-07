library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity unidade_controle_tb is
end;

architecture a_unidade_controle_tb of unidade_controle_tb is
    component unidade_controle
    port( instrucao : in unsigned(15 downto 0);
          estado : in unsigned( 1 downto 0);
          sel_estadoRom, sel_estadoPc, sel_estadoBancoReg, sel_mux_rd2, sel_jump : out std_logic;
          write_reg, read_reg1, read_reg2, sel_op : out unsigned(2 downto 0);
          --opcode : out unsigned(3 downto 0);
          const_rom : out unsigned (5 downto 0);
          jump_end : out unsigned (6 downto 0)
    );
    end component;
     
    signal instrucao :  unsigned(15 downto 0);
    signal estado :  unsigned( 1 downto 0);
    signal sel_estadoRom, sel_estadoPc, sel_estadoBancoReg, sel_mux_rd2, sel_jump :  std_logic;
    signal write_reg, read_reg1, read_reg2, sel_op :  unsigned(2 downto 0);
    --opcode :  unsigned(3 downto 0);
    signal const_rom :  unsigned (5 downto 0);
    signal jump_end :  unsigned (6 downto 0);
    begin

    uut: unidade_controle port map ( instrucao => instrucao,
                                     estado => estado,
                                     sel_estadoRom => sel_estadoRom,
                                     sel_estadoPc => sel_estadoPc,
                                     sel_estadoBancoReg => sel_estadoBancoReg,
                                     sel_mux_rd2 => sel_mux_rd2, 
                                     sel_jump => sel_jump,
                                     write_reg => write_reg,
                                     read_reg1 => read_reg1,
                                     read_reg2 => read_reg2,
                                     sel_op => sel_op,
                                     const_rom => const_rom,
                                     jump_end => jump_end

    );
    process 
    begin
    wait;
    end process;

end architecture; --