-------------------------------------------------------
--! Tarefa 06: Registrador de 16 bits
--! Aluno: Elvis Fernandes
--! Data: 23/03/2022
--! Arquivo: testbench_reg16.do
-------------------------------------------------------

-- bibliotecas e cláusulas
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_reg16 is
    constant DATA_WIDTH : integer := 16; -- Largura padrão para os vetores UNSIGNED
end entity testbench_reg16;

architecture stimulus of testbench_reg16 is

    -- declaração de sinais
    signal clk     : std_logic;
    signal sclr_n  : std_logic;
    signal clk_ena : std_logic;
    signal datain  : unsigned(DATA_WIDTH - 1 downto 0) := x"045a";
    signal reg_out : unsigned(DATA_WIDTH - 1 downto 0);

begin                                   -- inicio do corpo da arquitetura

    dut : entity work.reg16
        port map(
            clk     => clk,
            sclr_n  => sclr_n,
            clk_ena => clk_ena,
            datain  => datain,
            reg_out => reg_out
        );

    -- gera um clock
    stimulus_process_clk : process
    begin
        clk <= '0';
        wait for 5 ns;                  --! Reduzido o tempo de espera para metade
        clk <= '1';                     --! Alternando o clock
        wait for 5 ns;
    end process stimulus_process_clk;

    --gera enable clk_ena
    stimulus_process_clk_ena : process
    begin
        clk_ena <= '0';                 --! Habilitando o clock
        wait for 60 ns;
        clk_ena <= '1';                 --! Habilitando o clock
        wait;
    end process stimulus_process_clk_ena;

    -- Processo para controlar sclr_n
    stimulus_process_sclr_n : process
    begin
        sclr_n <= '0';                  --! Ativando a limpeza da saída
        wait for 70 ns;                 --! Atraso para ativar sclr_n
        sclr_n <= '1';                  --! Ativando a limpeza da saída
        wait for 100 ns;                --! Tempo de duração da limpeza
        sclr_n <= '0';                  --! Desativando a limpeza da saída
        wait;
    end process stimulus_process_sclr_n;

end architecture stimulus;
