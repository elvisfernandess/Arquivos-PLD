-------------------------------------------------------------------
-- Name        : simple_fsm_transmissor.vhd
-- Author      : Elvis Fernandes
-- Version     : 0.1
-- Copyright   : Departamento de Eletrônica, Florianópolis, IFSC
-- Description : Tarefa 12: Transmissor Serial 
-- Date        : 07/08/2024
-------------------------------------------------------------------
-- Esta tarefa envolve a criação de um módulo em VHDL que recebe dados em paralelo de barramentos de 8 bits e os converte em formato serial para serem transmitidos por um pino de saída.
-- Pinos de entrada e saída:
-- clk - fclk = 100 kHz (usar uma PLL para redução).
-- start: sinal que sinaliza o início da transmissão. A transmissão é iniciada quando start é nível lógico alto.
-- reset: reinicializa circuitos síncronos.
-- data: dado de 8 bits para ser transmitido em formato serial.
-- addr: endereço de 8 bits que será transmitido em formato serial antes do dado.
-- sdata: canal de saída da transmissão serial.
-- Implementação e requisitos:
-- Um exemplo de formato de saída pode ser visualizado na figura abaixo.
-- Um bit em nível baixo deve ser enviado no início da transmissão (start bit).
-- A linha permanece em nível lógico alto quando não há nenhuma transmissão.
-- Use uma máquina de estados.
-- Use simulação para o desenvolvimento.
-- Comprovar o funcionamento da síntese com o osciloscópio.
-- Código deve conter documentação.
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Define a entidade com os pinos de entrada e saída
entity simple_fsm_transmissor is
    port (
        clk   : in  std_logic;                            -- Sinal de clock
        start : in  std_logic;                            -- Sinal para iniciar a transmissão
        reset : in  std_logic;                            -- Sinal para reinicializar os circuitos síncronos
        data  : in  std_logic_vector(7 downto 0);         -- Barramento de dados de 8 bits
        addr  : in  std_logic_vector(7 downto 0);         -- Barramento de endereço de 8 bits
        sdata : out std_logic                             -- Canal de saída para a transmissão serial
    );
end entity simple_fsm_transmissor;

architecture rtl of simple_fsm_transmissor is

    -- Define os estados da máquina de estados
    type state is (IDLE, START_BIT, TRANSMITTING);
    signal pr_state, nx_state : state;                   -- Estado presente e próximo da máquina de estados
	
    -- Registrador de deslocamento de 16 bits (8 bits para addr e 8 bits para data)
    signal shift_reg : std_logic_vector(15 downto 0);
    
    -- Contador de bits para controlar a transmissão
    signal bit_counter : integer range 0 to 15;

begin

    -- Processo de transição de estado
    process(reset, clk)
    begin
        if reset = '1' then
            pr_state <= IDLE;                            -- Reinicializa para o estado IDLE se reset for '1'
        elsif rising_edge(clk) then
            pr_state <= nx_state;                        -- Atualiza o estado presente para o próximo estado na borda de subida do clock
        end if;
    end process;

    -- Processo de saída e próximos estados lógicos
    process(start, addr, data, pr_state)
    begin
        case pr_state is 
            when IDLE =>
                shift_reg <= (others => '1');            -- Configura o registrador de deslocamento para '1'
                sdata <= '1';                            -- Configura a saída sdata para '1'
                bit_counter <= 0;                        -- Zera o contador de bits
                if start = '1' then                      -- Se start for '1', inicia a transmissão
                    nx_state <= START_BIT;               -- Próximo estado é START_BIT
                    shift_reg <= addr & data;            -- Carrega o registrador de deslocamento com addr concatenado com data
                else
                    nx_state <= IDLE;                    -- Caso contrário, permanece no estado IDLE
                end if;
            when START_BIT =>
                sdata <= '0';                            -- Envia o bit de start (nível baixo)
                nx_state <= TRANSMITTING;                -- Próximo estado é TRANSMITTING
            when TRANSMITTING =>
                sdata <= shift_reg(15);                  -- Envia o bit mais significativo do registrador de deslocamento
                shift_reg <= shift_reg(14 downto 0) & '0'; -- Desloca o registrador de deslocamento para a direita
                if bit_counter = 15 then
                    nx_state <= IDLE;                    -- Se 14 bits foram enviados, volta para o estado IDLE
                else
                    bit_counter <= bit_counter + 1;      -- Incrementa o contador de bits
                    nx_state <= TRANSMITTING;            -- Permanece no estado TRANSMITTING
                end if;
        end case;
    end process;

end architecture rtl;
