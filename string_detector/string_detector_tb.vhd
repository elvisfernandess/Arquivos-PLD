LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY string_detector_tb IS
END ENTITY string_detector_tb;

ARCHITECTURE tb OF string_detector_tb IS

    signal clk   : std_logic;
	signal rst   : std_logic;
	signal d     : std_logic;
	signal q     : std_logic;
    
BEGIN

    dut: ENTITY work.string_detector
        PORT MAP (
            clk    => clk,
            rst    => rst,
			d      => d,
			q      => q
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
	
	-- Processo de entrada d
    d_process: PROCESS
    BEGIN
        d <= '1';
        WAIT FOR 15 ns;
		d <= '0';
        WAIT FOR 10 ns;
        d <= '1';
		WAIT FOR 10 ns;
		d <= '0';
		WAIT FOR 25 ns;
    END PROCESS d_process;
	
END ARCHITECTURE tb;
