-------------------------------------------------------
--! Tarefa 03: multiplicador de n-bits
--! Aluno: Elvis Fernandes
--! Data: 19/03/2024
--! Arquivo: mux_when.vhd
-------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_when is
    generic (
        constant DATA_WIDTH : integer := 4
    );
    port (
        mux_in_a   : in  unsigned(DATA_WIDTH - 1 downto 0);  -- Entrada A do multiplexador
        mux_in_b   : in  unsigned(DATA_WIDTH - 1 downto 0);  -- Entrada B do multiplexador
        mux_sel    : in std_logic;                            -- Sinal de seleção do multiplexador
        mux_out    : out  unsigned(DATA_WIDTH - 1 downto 0)   -- Saída do multiplexador
    );
end entity mux_when;

architecture RTL of mux_when is
begin
	mux_out <= mux_in_a when mux_sel = '0' else
			   mux_in_b;
  
end architecture RTL;
