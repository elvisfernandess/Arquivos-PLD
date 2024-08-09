-------------------------------------------------------
--! Tarefa 08: composição do multiplicador 8x8 e FSM
--! Aluno: Elvis Fernandes
--! Data: 10/04/2024
--! Arquivo: multiplicador8x8_tb.vhd
-------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity multiplicador8x8_tb is
end multiplicador8x8_tb;

architecture tb_arch of multiplicador8x8_tb is
    -- Sinais
    signal dataa          : unsigned(7 downto 0) := (others => '0');
    signal datab          : unsigned(7 downto 0) := (others => '0');
    signal start          : std_logic            := '0';
    signal reset_a        : std_logic            := '0';
    signal clk            : std_logic            := '0';
    signal done_flag      : std_logic;
    signal product8x8_out : unsigned(15 downto 0);
    signal segs           : unsigned(7 downto 0);

    -- Constantes
    constant DATA_WIDTH : integer := 16; -- Largura padrão para os vetores UNSIGNED

    -- Instanciando o DUT (Device Under Test)
begin

    -- Instanciando o DUT
    dut : entity work.multiplicador8x8
        generic map(
            DATA_WIDTH => 16
        )
        port map(
            dataa          => dataa,
            datab          => datab,
            start          => start,
            reset_a        => reset_a,
            clk            => clk,
            done_flag      => done_flag,
            product8x8_out => product8x8_out,
            segs           => segs
        );

    dataa <= x"20";
    datab <= x"10";

    -- Processo para realizar o start
    start_process : process
    begin
        wait for 20 ns;
        start <= '1';
        wait for 10 ns;
        start <= '0';
        wait;
    end process start_process;

    -- Processo para realizar o reset_a
    reset_aprocess : process
    begin
        wait for 2 ns;
        reset_a <= '1';
        wait for 2 ns;
        reset_a <= '0';
        wait;
    end process reset_aprocess;

    -- Processo para gerar um clock
    stimulus_process_clk : process
    begin
        wait for 5 ns;                  -- Reduzido o tempo de espera para metade
        clk <= not clk;                 -- Alternando o clock
    end process stimulus_process_clk;

end architecture tb_arch;
