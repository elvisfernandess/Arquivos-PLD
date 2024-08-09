-------------------------------------------------------
--! Tarefa 08: FSM
--! Aluno: Elvis Fernandes
--! Data: 07/04/2024
--! Arquivo: testbench_mult_control.vhd
-------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_mult_control is
end entity testbench_mult_control;

architecture tb_arch of testbench_mult_control is

    -- Declaração dos sinais de entrada
    signal clk     : std_logic := '0'; -- Sinal de clock
    signal reset_a : std_logic := '0'; -- Sinal de reset assíncrono
    signal start   : std_logic := '0'; -- Sinal de início da operação
    signal count   : unsigned(1 downto 0) := "00"; -- Contador de operações
    signal clk_ena : std_logic := '0'; -- Sinal de habilitação do clock
    signal sclr_n  : std_logic := '1'; -- Sinal de reset assíncrono

    -- Declaração dos sinais de saída
    signal input_sel : unsigned(1 downto 0) := "00"; -- Seleção de entrada
    signal shift_sel : unsigned(1 downto 0) := "00"; -- Seleção de deslocamento
    signal state_out : unsigned(2 downto 0) := "000"; -- Estado atual da máquina de estados
    signal done      : std_logic := '0';             -- Sinal de conclusão

begin

    -- Instanciação do componente mult_control
    dut : entity work.mult_control
        port map (
            clk         => clk,
            reset_a     => reset_a,
            start       => start,
            count       => count,
            input_sel   => input_sel,
            shift_sel   => shift_sel,
            state_out   => state_out,
            done        => done,
            clk_ena     => clk_ena,
            sclr_n      => sclr_n
        );

    -- Processo para gerar um clock
    stimulus_process_clk: process
    begin
        wait for 2.5 ns;  --! Reduzido o tempo de espera para metade
        clk <= not clk; --! Alternando o clock
    end process stimulus_process_clk;

    -- Processo para realizar o reset assíncrono
    reset_process: process
    begin
        wait for 25 ns;  -- Reduzido o tempo de espera
        reset_a <= '1';
        wait for 10 ns;  -- Reduzido o tempo de espera
        reset_a <= '0';
        wait for 10 ns;  -- Reduzido o tempo de espera
        --reset_a <= '1';
        wait;
    end process reset_process;
    
    -- Processo para realizar o start
    start_process: process
    begin
        wait for 40 ns; -- Aguarda um pouco antes de iniciar
        start <= '1';    -- Inicia a operação
        wait for 25 ns;  -- Reduzido o tempo de espera
        start <= '0';    -- Encerra a operação
        wait;
    end process start_process;

   -- Processo para modificar o contador de operações
    count_process: process
    begin
        wait for 100 ns;    -- Aguarda um pouco antes de começar a modificar o contador
        count <= "00";      -- Configura o contador para 00
        wait for 50 ns;     -- Reduzido o tempo de espera
        count <= "01";      -- Configura o contador para 01
        wait for 50 ns;     -- Reduzido o tempo de espera
        count <= "10";      -- Configura o contador para 10
        wait for 50 ns;     -- Reduzido o tempo de espera
        count <= "11";      -- Configura o contador para 11
        wait;
    end process count_process;

    -- Processo para controlar o sinal de habilitação do clock
    clk_ena_process: process
    begin
        wait for 150 ns;   -- Aguarda um pouco antes de habilitar o clock
        clk_ena <= '1';    -- Habilita o clock
        wait for 75 ns;    -- Reduzido o tempo de espera
        clk_ena <= '0';    -- Desabilita o clock
        wait;
    end process clk_ena_process;

    -- Processo para controlar o sinal de reset assíncrono
    sclr_n_process: process
    begin
        wait for 200 ns;   -- Aguarda um pouco antes de acionar o reset assíncrono
        sclr_n <= '0';     -- Aciona o reset assíncrono
        wait for 50 ns;    -- Reduzido o tempo de espera
        sclr_n <= '1';     -- Desativa o reset assíncrono
        wait;
    end process sclr_n_process;
	
	-- Processo para controlar o sinal de conclusão
    done_process: process
    begin
        wait for 300 ns;   -- Aguarda um pouco antes de definir o sinal de conclusão
        done <= '1';       -- Define o sinal de conclusão como '1'
        wait for 100 ns;   -- Reduzido o tempo de espera
        done <= '0';       -- Reseta o sinal de conclusão para '0'
        wait;
    end process done_process;

    -- Processo para controlar o sinal de seleção de entrada
    input_sel_process: process
    begin
		input_sel <= "00"; -- Define o sinal de seleção de entrada como "01"
        wait for 400 ns;   -- Aguarda um pouco antes de definir o sinal de seleção de entrada
        input_sel <= "01"; -- Define o sinal de seleção de entrada como "01"
        wait for 50 ns;    -- Reduzido o tempo de espera
        input_sel <= "10"; -- Define o sinal de seleção de entrada como "10"
        wait for 50 ns;    -- Adicionado um novo tempo de espera
        input_sel <= "11"; -- Define o sinal de seleção de entrada como "10" novamente
        wait;
    end process input_sel_process;

    -- Processo para controlar o sinal de seleção de deslocamento
    shift_sel_process: process
    begin
        wait for 500 ns;   -- Aguarda um pouco antes de definir o sinal de seleção de deslocamento
        shift_sel <= "00"; -- Define o sinal de seleção de deslocamento como "00"
        wait for 50 ns;    -- Reduzido o tempo de espera
        shift_sel <= "01"; -- Define o sinal de seleção de deslocamento como "01" novamente
        wait for 50 ns;    -- Adicionado um novo tempo de espera
        shift_sel <= "10"; -- Define o sinal de seleção de deslocamento como "10"
        wait for 50 ns;    -- Adicionado um novo tempo de espera
        shift_sel <= "11"; -- Define o sinal de seleção de deslocamento como "11"
        wait;
    end process shift_sel_process;

end architecture tb_arch;
