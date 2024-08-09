-------------------------------------------------------
--! Tarefa 03: multiplexador
--! Aluno: Elvis Fernandes
--! Data: 17/03/2024
--! Arquivo: testbench_mux4.vhd
-------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_mux4 is
    constant DATA_WIDTH : integer := 4;
end entity testbench_mux4;

architecture stimulus of testbench_mux4 is
    signal mux_in_a : unsigned(DATA_WIDTH - 1 downto 0) := "0000";
    signal mux_in_b : unsigned(DATA_WIDTH - 1 downto 0) := "0000";
    signal mux_sel : std_logic := '0'; -- Inicializado com '0' para o primeiro ciclo
    signal mux_out : unsigned(DATA_WIDTH - 1 downto 0) := (others => '0'); -- Inicializado com '0' para o primeiro ciclo
begin

    -- Processo para alterar mux_in_a
    mux_in_a_process: process
    begin
        -- Aguarda 60 ns antes de alterar mux_in_a
        wait for 60 ns;

        -- Altera mux_in_a para um valor específico
        mux_in_a <= "1010";

        -- Aguarda o final da simulação
        wait;
    end process mux_in_a_process;

    -- Processo para alterar mux_in_b
    mux_in_b_process: process
    begin
        -- Aguarda 60 ns antes de alterar mux_in_b
        wait for 120 ns; -- Espera 60 ns a mais em relação ao mux_in_a

        -- Altera mux_in_b para um valor específico
        mux_in_b <= "0101";

        -- Aguarda o final da simulação
        wait;
    end process mux_in_b_process;
    
    -- Processo para alternar mux_sel
    mux_sel_process: process
    begin
        -- Aguarda 30 ns antes de alterar mux_sel pela primeira vez
        wait for 30 ns;
        
        -- Alterna mux_sel entre '0' e '1' a cada 60 ns
        for i in 1 to 4 loop
            mux_sel <= not mux_sel;
            wait for 60 ns;
        end loop;
        
        -- Aguarda o final da simulação
        wait;
    end process mux_sel_process;

    -- Instanciação do componente mux4
    dut: entity work.mux4
        generic map(
            DATA_WIDTH => DATA_WIDTH
        )
        port map(
            mux_in_a => mux_in_a,
            mux_in_b => mux_in_b,
            mux_sel => mux_sel,
            mux_out => mux_out
        );

end architecture stimulus;
