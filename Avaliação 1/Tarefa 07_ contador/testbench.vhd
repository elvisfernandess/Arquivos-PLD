-------------------------------------------------------
--! Tarefa 07: contador
--! Aluno: Elvis Fernandes
--! Data: 23/03/2022
--! Arquivo: testbench.vhd
-------------------------------------------------------

-- bibliotecas e cláusulas
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
    constant DATA_WIDTH : integer := 1;  -- Largura padrão de count_out
end entity testbench;

architecture stimulus of testbench is

    -- declaração de sinais
    signal clk       : std_logic                     := '0';
    signal aclr_n    : std_logic                     := '0';
    signal count_out : unsigned(DATA_WIDTH downto 0)  := "00";
    
begin                                   -- inicio do corpo da arquitetura

    dut : entity work.counter 
        port map (
            clk       => clk,
            aclr_n    => aclr_n,
            count_out => count_out
        );

    -- gera um clock
    stimulus_process_clk: process
    begin
        wait for 5 ns;  --! Reduzido o tempo de espera para metade
        clk <= not clk; --! Alternando o clock
    end process stimulus_process_clk;
    
    -- Processo para estímulos para o sinal aclr_n
    stimulus_process_aclr_n: process
    begin
        aclr_n <= '0';
        wait for 50 ns;  -- Aguarda um ciclo de clock antes de aplicar os estímulos
        aclr_n <= '1';
        wait for 50 ns;  -- Aguarda um ciclo de clock antes de aplicar os estímulos
       
    end process stimulus_process_aclr_n;
    
end architecture stimulus;
