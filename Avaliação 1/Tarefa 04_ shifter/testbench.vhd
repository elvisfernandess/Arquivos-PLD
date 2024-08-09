-------------------------------------------------------
--! Tarefa 4 - SHIFTER - Deslocador
--! Aluno: Elvis Fernandes
--! Data: 23 /03/2024
--! Arquivo: testbench_left_shifter.vhd
-------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_left_shifter is
end entity testbench_left_shifter;

architecture behavioral of testbench_left_shifter is

    signal input       : unsigned(7 downto 0) := (others => '0');
    signal shift_cntrl : std_logic_vector(1 downto 0); -- Controle de deslocamento como inteiro
    --signal shift_cntrl_vec : unsigned(SHIFT_WIDTH - 1 downto 0); -- Vetor de unsigned para shift_cntrl
    signal shift_out   : unsigned(15 downto 0);

begin
    -- Conversão de inteiro para unsigned
    --shift_cntrl_vec <= to_unsigned(shift_cntrl, SHIFT_WIDTH);

    dut : entity work.shifter

        port map(
            input       => input,
            shift_cntrl => shift_cntrl, -- Usando o vetor de unsigned
            shift_out   => shift_out
        );

    stimulus : process
    begin
        -- Teste 1: shift_cntrl = "0" (Mantém os bits originais)
        input       <= "00001111";      -- Dados de entrada
        shift_cntrl <= "00";               -- Controle de deslocamento (valor inteiro)
        wait for 10 ns;

        -- Teste 2: shift_cntrl = "1" (Desloca 4 bits para a esquerda)
        --input       <= "00001111";      -- Dados de entrada
        shift_cntrl <= "01";               -- Controle de deslocamento (valor inteiro)
        wait for 10 ns;

        -- Teste 3: shift_cntrl = "3" (Desloca 8 bits para a esquerda)
        --input       <= "00001111";      -- Dados de entrada
        shift_cntrl <= "10";               -- Controle de deslocamento (valor inteiro)
        wait for 10 ns;

        -- Teste 3: shift_cntrl = "4" (Mantém os bits originais)
        --input       <= "00001111";      -- Dados de entrada
        shift_cntrl <= "11";               -- Controle de deslocamento (valor inteiro)
        wait for 10 ns;

        wait;
    end process stimulus;

end architecture behavioral;
