-------------------------------------------------------
--! Tarefa 1 - ADDER - Somador
--! Aluno: Elvis Fernandes
--! Data: 13 /03/2024
--! Arquivo: adder.vhd
-------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity adder is
    generic (
        constant DATA_WIDTH : integer := 16  -- Largura padrão para os vetores UNSIGNED
    );
    port (
       
        dataa : in unsigned(DATA_WIDTH - 1 downto 0);
        datab : in unsigned(DATA_WIDTH - 1 downto 0);
        sum   : out unsigned(DATA_WIDTH - 1 downto 0)
    );
end entity adder;

architecture RTL of adder is
begin

    sum <= dataa + datab;

end architecture RTL;