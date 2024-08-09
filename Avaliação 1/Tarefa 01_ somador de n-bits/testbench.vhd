-------------------------------------------------------
--! Tarefa 1 - ADDER - Somador
--! Aluno: Elvis Fernandes
--! Data: 13/03/2024
--! Arquivo: testbench_adder.vhd
-------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_adder is
    constant DATA_WIDTH : integer := 16;  -- Largura padrão para os vetores UNSIGNED
end entity testbench_adder;

architecture stimulus of testbench_adder is
    signal dataa : unsigned(DATA_WIDTH - 1 downto 0) := x"0000";
    signal datab : unsigned(DATA_WIDTH - 1 downto 0) := x"0000";
    signal sum : unsigned(DATA_WIDTH - 1 downto 0):= x"0000";

begin

    -- Processo para estímulos para o sinal dataa
    stimulus_process_dataa: process
    begin
        dataa <= x"01A3";
        wait for 20 ns;  -- Aguarda um ciclo de clock antes de aplicar os estímulos
        dataa <= x"01B3";
        wait for 50 ns;  -- Aguarda tempo suficiente para os estímulos serem aplicados
        wait;  -- Aguarda o final da simulação
    end process stimulus_process_dataa;

    -- Processo para estímulos para o sinal datab
    stimulus_process_datab: process
    begin
        datab <= x"02A3";
        wait for 50 ns;  -- Aguarda um ciclo de clock antes de aplicar os estímulos
        datab <= x"02B3";
        wait for 50 ns;  -- Aguarda tempo suficiente para os estímulos serem aplicados
        wait;  -- Aguarda o final da simulação
    end process stimulus_process_datab;

    adder_inst : entity work.adder
        generic map(
            DATA_WIDTH => DATA_WIDTH
        )
        port map(
            dataa => dataa,
            datab => datab,
            sum   => sum
        );

end architecture stimulus;
