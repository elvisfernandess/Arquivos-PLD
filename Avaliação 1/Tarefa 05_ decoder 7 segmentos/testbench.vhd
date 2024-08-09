-------------------------------------------------------
--! Tarefa 05: decodificador de 7-segmentos utilizando a instrução case.
--! Aluno: Elvis Fernandes
--! Data: 26/03/2022
--! Arquivo: testbench_seven.vhd
-------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_seven is
end entity testbench_seven;

architecture testbench_seven of testbench_seven is
    signal input : std_logic_vector(3 downto 0); -- Sinal de entrada
    signal segs  : unsigned(7 downto 0); -- Sinal de saída
begin
    -- Estímulo de entrada
    stimulus_process : process
    begin
        input <= "0000";                -- Teste para o número 0
        wait for 20 ns;

        input <= "0001";                -- Teste para o número 1
        wait for 20 ns;

        input <= "0010";                -- Teste para o número 2
        wait for 20 ns;

        input <= "0011";                -- Teste para o número 3
        wait for 20 ns;

        input <= "0100";                -- Teste para o número 4
        wait for 20 ns;

        input <= "0101";                -- Teste para o número 5
        wait for 20 ns;

        input <= "0110";                -- Teste para o número 6
        wait for 20 ns;

        input <= "0111";                -- Teste para o número 7
        wait for 20 ns;

        input <= "1000";                -- Teste para o número 8
        wait for 20 ns;

        input <= "1001";                -- Teste para o número 9
        wait for 20 ns;

        input <= "1010";                -- Teste para um valor inválido
        wait for 20 ns;

        input <= "1010";                -- Teste para o número A (10 em hexadecimal)
        wait for 20 ns;

        input <= "1011";                -- Teste para o número B (11 em hexadecimal)
        wait for 20 ns;

        input <= "1100";                -- Teste para o número C (12 em hexadecimal)
        wait for 20 ns;

        input <= "1101";                -- Teste para o número D (13 em hexadecimal)
        wait for 20 ns;

        input <= "1110";                -- Teste para o número E (14 em hexadecimal)
        wait for 20 ns;

        input <= "1111";                -- Teste para o número F (15 em hexadecimal)
        wait for 20 ns;

        wait;
    end process stimulus_process;

    -- Conexão entre o DUT (Device Under Test) e o testbench
    dut : entity work.seven_segment_cntrl
        port map(
            input => input,
            segs  => segs
        );

end architecture testbench_seven;
