-------------------------------------------------------
--! Tarefa 05: decodificador de 7-segmentos utilizando a instrução case.
--! Aluno: Elvis Fernandes
--! Data: 26/03/2022
--! Arquivo: seven_segment_cntrl.vhd
-------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity seven_segment_cntrl is
    port(
        input : in  std_logic_vector(3 downto 0); -- Entrada de dados como vetor de lógica
        segs  : out unsigned(7 downto 0) -- Saída do decodificador como unsigned
    );
end entity seven_segment_cntrl;

architecture Behavioral of seven_segment_cntrl is
begin
    process(input)
    begin
        --input_integer := to_integer(unsigned(input));
        case input is
            when x"0" =>
                segs <= "11000000";     -- 0
            when x"1" =>
                segs <= "11111001";     -- 1
            when x"2" =>
                segs <= "10100100";     -- 2
            when x"3" =>
                segs <= "10110000";     -- 3
            when x"4" =>
                segs <= "10011001";     -- 4
            when x"5" =>
                segs <= "10010010";     -- 5
            when x"6" =>
                segs <= "10000010";     -- 6
            when x"7" =>
                segs <= "11111000";     -- 7
            when x"8" =>
                segs <= "10000000";     -- 8
            when x"9" =>
                segs <= "10010000";     -- 9
            when x"a" =>
                segs <= "10000010";     -- A
            when x"b" =>
                segs <= "10000011";     -- B
            when x"c" =>
                segs <= "11000110";     -- C
            when x"d" =>
                segs <= "10100001";     -- D
            when x"e" =>
                segs <= "10000110";     -- E
            when x"f" =>
                segs <= "10001110";     -- F

            when others =>
                segs <= (others => '1'); -- Blank (todos os segmentos apagados)
        end case;
    end process;
end architecture Behavioral;
