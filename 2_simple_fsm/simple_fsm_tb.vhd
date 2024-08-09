library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity simple_fsm_tb is
end entity simple_fsm_tb;

architecture tb of simple_fsm_tb is

    signal a     : BIT;
    signal b     : BIT;
    signal d     : BIT;
    signal clk   : BIT;
    signal rst   : BIT;
	signal x   	 : BIT;

begin

    dut: entity work.simple_fsm
        port map (
            a      => a,
            b      => b,
            d      => d,
            clk    => clk,
            rst    => rst,
			x      => x
        );

	-- Processo de a
    a_process: process
    begin
		a <= '0';
		wait for 20 ns;
        a <= '1';
		wait for 5 ns;
		a <= '0';
		wait for 80 ns;
		a <= '1';
		wait for 5 ns;
		a <= '0';
        wait;

		--wait for 35 ns;
        --wait;
    end process a_process;
	
	-- Processo de b
    b_process: process
    begin
		b <= '0';
		wait for 60 ns;
        b <= '1';
        wait for 5 ns;
        b <= '0';
		wait for 5 ns;
		b <= '1';
		wait for 5 ns;
        b <= '0';
		wait for 5 ns;
		b <= '1';
		wait for 5 ns;
        b <= '0';
		wait for 5 ns;
		b <= '1';
        --wait;
    end process b_process;
	
	-- Processo de d
    d_process: process
    begin
	    wait for 20 ns;
        d <= '0';
        wait for 15 ns;
        d <= '1';
		wait for 20 ns;
        d <= '0';
		wait for 30 ns;
        d <= '1';
		wait for 10 ns;
		d <= '0';
		wait for 10 ns;
		d <= '1';
		wait for 10 ns;
		d <= '0';
		--wait;
    end process d_process;

    -- Gera um CLOCK
    stimulus_process_clk : process
    begin
        clk <= '0';
        wait for 10 ns; 
        clk <= '1';    
        wait for 10 ns;
    end process stimulus_process_clk;

	-- Processo de RESET
    reset_process: process
    begin
        rst <= '1';
        wait for 3 ns;
        rst <= '0';
        wait;
    end process reset_process;
	
end architecture tb;
