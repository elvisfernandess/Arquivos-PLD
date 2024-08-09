-------------------------------------------------------------------
-- Name        : simple_fsm_transmissor_tb.vhd
-- Author      : Elvis Fernandes
-- Version     : 0.1
-- Copyright   : Departamento de Eletrônica, Florianópolis, IFSC
-- Description : Tarefa 12: Transmissor Serial 
-- Date        : 07/08/2024
-------------------------------------------------------------------
--Esta tarefa envolve a criação de um módulo em VHDL que recebe dados em paralelo de barramentos de 8 bits e os converte em formato serial para serem transmitidos por um pino de saída.
--Pinos de entrada e saída:
--clk - fclk = 100 kHz (usar uma PLL para redução).
--start: sinal que sinaliza o início da transmissão. A transmissão é iniciada quando start é nível lógico alto.
--reset: reinicializa circuitos síncronos.
--data: dado de 8 bits para ser transmitido em formato serial.
--addr: endereço de 8 bits que será transmitido em formato serial antes do dado.
--sdata: canal de saída da transmissão serial.
--Implementação e requisitos:
--Um exemplo de formato de saída pode ser visualizado na figura abaixo.
--Um bit em nível baixo deve ser enviado no início da transmissão (start bit).
--A linha permanece em nível lógico alto quando não há nenhuma transmissão.
--Use uma máquina de estados.
--Use simulação para o desenvolvimento.
--Comprovar o funcionamento da síntese com o osciloscópio.
--Código deve conter documentação.
-------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity simple_fsm_transmissor_tb is
end entity simple_fsm_transmissor_tb;

architecture tb of simple_fsm_transmissor_tb is

    -- Sinais
    signal clk    : std_logic := '0';  -- Clock
    signal start  : std_logic := '0';  -- Sinal de início de transmissão
    signal reset  : std_logic := '0';  -- Sinal de reset
    signal data   : std_logic_vector(7 downto 0) := (others => '0'); -- Dado de entrada
    signal addr   : std_logic_vector(7 downto 0) := (others => '0'); -- Endereço de entrada
    signal sdata  : std_logic; -- Sinal de saída

begin

    -- Instanciação do fsm_transmissor
    dut: entity work.simple_fsm_transmissor
        port map (
            clk   => clk,
            start => start,
            reset => reset,
            data  => data,
            addr  => addr,
            sdata => sdata
        );

    -- Gera um CLOCK
    stimulus_process_clk : process
    begin
        clk <= '0';
        wait for 5 ns; 
        clk <= '1';    
        wait for 5 ns;
    end process stimulus_process_clk;

    -- Processo dO START
    start_process: process
    begin
        
        wait for 10 ns;
        start <= '1';
        wait for 10 ns;
        start <= '0';
        --wait;
    end process start_process;
	
    -- Processo de RESET
    reset_process: process
    begin
        reset <= '1';
        wait for 10 ns;
        reset <= '0';
        wait;
    end process reset_process;
	
	-- Processo de DATA
    data_process: process
    begin
		data <= "10101010";
        wait;
    end process data_process;
	
	-- Processo de ADDR
    addr_process: process
    begin
		addr <= "01010101";
        wait;
    end process addr_process;
	
end architecture tb;