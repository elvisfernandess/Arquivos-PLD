library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity signal_generator_1_tb is
end entity signal_generator_1_tb;

architecture tb of signal_generator_1_tb is

    signal clk   : BIT;
    signal out1  : BIT;
	signal out2  : BIT;
	
begin

    dut: entity work.signal_generator_1
        port map (
            clk    => clk,
 			out1   => out1,
			out2   => out2
        );


    -- Gera um CLOCK
    stimulus_process_clk : process
    begin
        clk <= '0';
        wait for 5 ns; 
        clk <= '1';    
        wait for 5 ns;
    end process stimulus_process_clk;

end architecture tb;
