LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY counter_tb IS
END ENTITY counter_tb;

ARCHITECTURE tb OF counter_tb IS

    signal clk   : std_logic;
	signal rst   : std_logic;
    signal count : std_logic_vector (3 downto 0);

BEGIN

    dut: ENTITY work.counter
        PORT MAP (
            clk    => clk,
            rst    => rst,
			count  => count
        );

    -- Gera um CLOCK
    stimulus_process_clk : PROCESS
    BEGIN
        clk <= '0';
        WAIT FOR 10 ns; 
        clk <= '1';    
        WAIT FOR 10 ns;
    END PROCESS stimulus_process_clk;

	-- Processo de RESET
    reset_process: PROCESS
    BEGIN
        rst <= '1';
        WAIT FOR 3 ns;
        rst <= '0';
        WAIT;
    END PROCESS reset_process;
	
END ARCHITECTURE tb;
