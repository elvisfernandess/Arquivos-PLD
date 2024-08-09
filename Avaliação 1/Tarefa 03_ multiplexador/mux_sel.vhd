-------------------------------------------------------
--! Tarefa 03: multiplicador de n-bits
--! Aluno: Elvis Fernandes
--! Data: 19/03/2024
--! Arquivo: mux4.vhd
-------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux4 is
    generic (
        constant DATA_WIDTH : integer := 4
    );
    port (
        mux_in_a   : in  unsigned(DATA_WIDTH - 1 downto 0);  -- Entrada A do multiplexador
        mux_in_b   : in  unsigned(DATA_WIDTH - 1 downto 0);  -- Entrada B do multiplexador
        mux_sel    : in std_logic;                            -- Sinal de seleção do multiplexador
        mux_out    : out  unsigned(DATA_WIDTH - 1 downto 0)   -- Saída do multiplexador
    );
end entity mux4;

architecture RTL of mux4 is
begin
    -- Lógica do multiplexador utilizando a cláusula with select
    with mux_sel select
        mux_out <= mux_in_a when '0',       -- Se mux_sel for '0', mux_in_a é selecionado
                   mux_in_b when others;       -- Se mux_sel for '1', mux_in_b é selecionado
                   
end architecture RTL;
