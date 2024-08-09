LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY fsm_tb IS
END ENTITY fsm_tb;

ARCHITECTURE tb OF fsm_tb IS

    signal clk   : std_logic;
	signal rst   : std_logic;
	signal inp   : std_logic;
	signal outp  : std_logic_vector (1 downto 0);
    
BEGIN

    dut: ENTITY work.fsm
        PORT MAP (
            clk    => clk,
            rst    => rst,
			inp    => inp,
			outp   => outp
        );

    -- Gera um CLOCK
    stimulus_process_clk : PROCESS
    BEGIN
        clk <= '0';
        WAIT FOR 5 ns; 
        clk <= '1';    
        WAIT FOR 5 ns;
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
    inp_process: PROCESS
    BEGIN
        inp <= '0';
        WAIT FOR 3 ns;
		
		inp <= '1';
        WAIT FOR 2 ns;
		
		inp <= '0';
        WAIT FOR 7 ns;
		
		inp <= '1';
        WAIT FOR 9 ns;

        --WAIT FOR 10 ns;
        --d <= '1';
		--WAIT FOR 10 ns;
		--d <= '0';
		--WAIT FOR 25 ns;
    END PROCESS inp_process;
	
END ARCHITECTURE tb;
