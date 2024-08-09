-------------------------------------------------------
--! Tarefa 06: Registrador de 16 bits
--! Aluno: Elvis Fernandes
--! Data: 23/03/2022
--! Arquivo: reg16.do
-------------------------------------------------------

--Escreva o código para um registrador de n-bits (GENERICS).

--    Todas as operações ocorrem na subida de clk, com exceção de sclr_n
--    sclr_n é baixo, limpe a saída (prioridade mais alta).
--    Na subida do clock, verifique se clk\_ena é alto.   
--    clk_ena é alto, as saídas são atribuídas às entradas
--    clk_ena é baixo, nada é feito.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg16 is
    generic(
        WIDTH : integer := 16           --! Largura padrão do registrador
    );
    port(
        clk     : in  std_logic;
        sclr_n  : in  std_logic;
        clk_ena : in  std_logic;
        datain  : in  unsigned(WIDTH - 1 downto 0); --! entrada de dados como unsigned
        reg_out : out unsigned(WIDTH - 1 downto 0) --! saída do registrador como unsigned
    );
end entity reg16;

architecture rtl of reg16 is

begin
    process(clk, sclr_n)
    begin
        if sclr_n = '0' then
            reg_out <= (others => '0');
        elsif rising_edge(clk) then
            if clk_ena = '1' then
                reg_out <= datain;
            end if;
        end if;
    end process;

end architecture rtl;
