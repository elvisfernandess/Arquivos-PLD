-------------------------------------------------------
--! Tarefa 02: multiplicador de n-bits
--! Aluno: Elvis Fernandes
--! Data: 13/03/2024
--! Arquivo: testbench_mult4x4.do
-------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_mult4x4 is
    constant DATA_WIDTH : integer := 4;
end entity testbench_mult4x4;

architecture stimulus of testbench_mult4x4 is
    signal dataa : unsigned(DATA_WIDTH - 1 downto 0) := (others => '0');
    signal datab : unsigned(DATA_WIDTH - 1 downto 0) := (others => '0');
    signal product : unsigned((DATA_WIDTH * 2) - 1 downto 0) := (others => '0');

begin

    -- Processo para estímulos para o sinal dataa
    stimulus_process_dataa: process
    begin
        dataa <= to_unsigned(5, DATA_WIDTH); -- Por exemplo, 5
        wait for 20 ns;  -- Aguarda um ciclo de clock antes de aplicar os estímulos
        dataa <= to_unsigned(7, DATA_WIDTH); -- Por exemplo, 5
        wait for 50 ns;  -- Aguarda tempo suficiente para os estímulos serem aplicados
        wait;  -- Aguarda o final da simulação
    end process stimulus_process_dataa;

    -- Processo para estímulos para o sinal datab
    stimulus_process_datab: process
    begin
        datab <= to_unsigned(8, DATA_WIDTH); -- Por exemplo, 5
        wait for 50 ns;  -- Aguarda um ciclo de clock antes de aplicar os estímulos
        datab <= to_unsigned(9, DATA_WIDTH); -- Por exemplo, 5
        wait for 50 ns;  -- Aguarda tempo suficiente para os estímulos serem aplicados
        wait;  -- Aguarda o final da simulação
    end process stimulus_process_datab;

    -- Instanciação do componente mult4x4
    mult4x4_inst: entity work.mult4x4
        generic map(
            DATA_WIDTH => DATA_WIDTH
        )
        port map(
            dataa => dataa,
            datab => datab,
            product => product
        );

end architecture stimulus;
