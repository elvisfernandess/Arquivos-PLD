-------------------------------------------------------
--! Tarefa 02: multiplicador de n-bits
--! Aluno: Elvis Fernandes
--! Data: 13/03/2024
--! Arquivo: mult4x4.do
-------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mult4x4 is
    generic(
        constant DATA_WIDTH : integer := 4
    );
    port(
        dataa   : in  unsigned(DATA_WIDTH - 1 downto 0);
        datab   : in  unsigned(DATA_WIDTH - 1 downto 0);
        product : out unsigned((DATA_WIDTH * 2) - 1 downto 0)
    );
end entity mult4x4;

architecture RTL of mult4x4 is

begin

    product <= dataa * datab;

end architecture RTL;
