library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity signal_gen_tb is
end entity signal_gen_tb;

architecture tb of signal_gen_tb is

    signal clk   : BIT;
    signal outp  : BIT;

begin

    dut: entity work.signal_gen
        port map (
            clk    => clk,
 			outp   => outp
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
