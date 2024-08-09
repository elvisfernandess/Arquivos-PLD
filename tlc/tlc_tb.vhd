LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY tlc_tb IS
END ENTITY tlc_tb;

ARCHITECTURE tb OF tlc_tb IS

    -- Constantes
    CONSTANT clk_period : time := 10 ns;
    CONSTANT timeMAX    : INTEGER := 27;
    CONSTANT timeRG     : INTEGER := 18;
    CONSTANT timeRY     : INTEGER := 3;
    CONSTANT timeGR     : INTEGER := 27;
    CONSTANT timeYR     : INTEGER := 3;
    CONSTANT timeTEST   : INTEGER := 27;

    -- Sinais
    SIGNAL clk   : std_logic := '0';
    SIGNAL stby  : std_logic;
    SIGNAL test  : std_logic;
    SIGNAL r1    : std_logic;
    SIGNAL y1    : std_logic;
    SIGNAL g1    : std_logic;
    SIGNAL r2    : std_logic;
    SIGNAL y2    : std_logic;
    SIGNAL g2    : std_logic;
    SIGNAL count : INTEGER := 0; -- Sinal contador para o testbench

BEGIN

    -- Instanciar a Unidade Sob Teste (UUT)
    dut: ENTITY work.tlc
        PORT MAP (
            clk    => clk,
            stby   => stby,
            test   => test,
            r1     => r1,
            r2     => r2,
            y1     => y1,
            y2     => y2,
            g1     => g1,
            g2     => g2,
            timeRG => timeRG,
            timeRY => timeRY,
            timeGR => timeGR,
            timeYR => timeYR,
            timeTEST => timeTEST
        );

    -- Processo de geração de clock
    clk_process : PROCESS
    BEGIN
        WHILE TRUE LOOP
            clk <= '0';
            WAIT FOR clk_period / 2;
            clk <= '1';
            WAIT FOR clk_period / 2;
        END LOOP;
    END PROCESS clk_process;

    -- Processo para gerenciar o estado de standby
    stby_process : PROCESS
    BEGIN
        stby <= '1';
        WAIT FOR 2 * clk_period; -- Aguardar dois ciclos de clock
        stby <= '0';

        -- Permitir tempo para a máquina de estados inicializar e transitar
        WAIT FOR (timeRG + 2) * clk_period; -- Tempo suficiente para cobrir o estado RG e a transição

        -- Permitir mais tempo para observar as transições de estado
        WAIT FOR timeMAX * clk_period; -- Tempo suficiente para cobrir todos os estados no modo normal

        -- Finalizar simulação
        ASSERT FALSE REPORT "Simulação Terminada" SEVERITY NOTE;
        WAIT;
    END PROCESS stby_process;

    -- Processo paralelo para alternar o sinal de teste
    test_process : PROCESS
    BEGIN
        WHILE TRUE LOOP
            test <= '0';
            WAIT FOR 2 * clk_period;
            test <= '1';
            WAIT FOR 2 * clk_period;
        END LOOP;
    END PROCESS test_process;

    -- Processo de contador
    counter_process : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            count <= count + 1;
            IF count = 271 THEN
                count <= 0; -- Redefinir contador se necessário
            END IF;
        END IF;
    END PROCESS counter_process;

END ARCHITECTURE tb;
