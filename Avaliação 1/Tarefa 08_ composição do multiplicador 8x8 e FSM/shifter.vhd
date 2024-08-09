-------------------------------------------------------
--! Tarefa 4 - SHIFTER - Deslocador
--! Aluno: Elvis Fernandes
--! Data: 23 /03/2024
--! Arquivo: shifter.vhd
-------------------------------------------------------

-- Construa um deslocador (left shifter) de 8-bit para 16-bit utilizando as instruções IF-THEN:

-- Descreva o seguinte comportamento:
-- Se shift_cntrl é zero, shift_out[7:0] igual a input[7:0]
-- Se shift_cntrl é 1, shift_out[11:4] igual input[7:0] -- shift de 4-bits.
-- Se shift_cntrl é 2, shift_out[15:8] igual input[7:0] -- shift de 8-bits
-- Se shift_cntrl is 3, shift_out[7:0] igual input[7:0]).

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shifter is

    port(
        input       : in  unsigned(7 downto 0);
        shift_cntrl : in  std_logic_vector(1 downto 0);
        shift_out   : out unsigned(15 downto 0) -- Corrigindo o tamanho de shift_out
    );
end entity shifter;

architecture behavioral of shifter is

begin
    process(input, shift_cntrl)
    begin
        -- Inicializa a saída com zeros
        shift_out <= (others => '0');

        -- Verifica o valor de shift_cntrl_int
        if shift_cntrl = "00" then
            shift_out(7 downto 0) <= input; -- Mantém os bits originais
        elsif shift_cntrl = "01" then
            shift_out(11 downto 4) <= input; -- Desloca 4 bits para a esquerda
        elsif shift_cntrl = "10" then
            shift_out(15 downto 8) <= input; -- Desloca 8 bits para a esquerda
        elsif shift_cntrl = "11" then
            shift_out(7 downto 0) <= input; -- Mantém os bits originais
        end if;
    end process;
end architecture behavioral;
