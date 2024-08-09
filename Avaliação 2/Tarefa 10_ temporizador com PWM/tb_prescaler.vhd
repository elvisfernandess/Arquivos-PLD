-------------------------------------------------------------------
-- Name        : tb_prescaler.vhd
-- Author      : Elvis Fernandes
-- Version     : 0.1
-- Copyright   : Departamento de Eletrônica, Florianópolis, IFSC
-- Description : Tarefa 10: Temporizador com PWM 
-- Date        : 12/07/2024
-------------------------------------------------------------------
-- Implemente um temporizador de 8-bits com as seguintes características:
-- 2 canais de comparação, cada canal com seu complementar. Total de 4 pinos.
-- Modo de contagem progressiva.
-- 8 níveis configurações de velocidade (prescaler).
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_prescaler is
end entity tb_prescaler;

architecture stimulus of tb_prescaler is
    signal clk         : std_logic;
    signal rst         : std_logic;
    signal sel_pr      : std_logic_vector(2 downto 0); -- Ajustado para 3 bits
    signal input_comp1 : unsigned(7 downto 0) := "00001000";
    signal input_comp2 : unsigned(7 downto 0) := "00001100";
    signal out_clk     : std_logic;
    signal comp_out1   : std_logic;
    signal comp_out2   : std_logic;
    signal comp_out3   : std_logic;
    signal comp_out4   : std_logic;
    signal counter     : unsigned(7 downto 0);

begin

    dut : entity work.prescaler
        port map(
            clk         => clk,
            rst         => rst,
            sel_pr      => sel_pr,
            input_comp1 => input_comp1,
            input_comp2 => input_comp2,
            out_clk     => out_clk,
            comp_out1   => comp_out1,
            comp_out2   => comp_out2,
            comp_out3   => comp_out3,
            comp_out4   => comp_out4,
            counter     => counter
        );

    -- Gera um clock
    stimulus_process_clk : process
    begin
        clk <= '0';
        wait for 5 ns;                  -- Tempo de espera reduzido para permitir uma verificação mais frequente do match
        clk <= '1';                     -- Alternando o clock
        wait for 5 ns;
    end process stimulus_process_clk;

    -- Processo para estímulos para o sinal reset
    stimulus_process_reset : process
    begin
        rst <= '1';
        wait for 2 ns;                  -- Aguarda um ciclo de clock antes de aplicar os estímulos
        rst <= '0';
        wait for 2 ns;                  -- Aguarda um ciclo de clock antes de aplicar os estímulos
        wait;
    end process stimulus_process_reset;

    -- Processo para estímulos para o sinal sel_pr
    stimulus_process_sel_pr : process
    begin
        --wait for 5 ns; -- Aguarda um tempo antes de mudar o valor de sel_pr
        sel_pr <= "000";
        --wait for 100 ns; -- Aguarda um tempo antes de mudar o valor de sel_pr
        --sel_pr <= "001";
        --wait for 200 ns; -- Aguarda um tempo antes de mudar o valor de sel_pr
        --sel_pr <= "010";
        --wait for 400 ns; -- Aguarda um tempo antes de mudar o valor de sel_pr
        --sel_pr <= "011";
        --wait for 800 ns; -- Aguarda um tempo antes de mudar o valor de sel_pr
        --sel_pr <= "100";
        --wait for 1600 ns; -- Aguarda um tempo antes de mudar o valor de sel_pr
        --sel_pr <= "101";
        --wait for 3200 ns; -- Aguarda um tempo antes de mudar o valor de sel_pr
        --sel_pr <= "110";
        --wait for 6400 ns; -- Aguarda um tempo antes de mudar o valor de sel_pr
        --sel_pr <= "111";
        wait;
    end process stimulus_process_sel_pr;

end architecture stimulus;
