library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity signal_generator_1 is
    port (
        clk   : in  BIT;
        out1  : OUT BIT;
        out2  : OUT BIT
    );
end entity signal_generator_1;

architecture fsm of signal_generator_1 is

    type state is (one, two);
    signal pr_state1, nx_state1 : state;
    signal pr_state2, nx_state2 : state;
    

begin

    -- Process for detecting edges of the clock signal
    process(clk)
    begin
        if rising_edge(clk) then
            pr_state1 <= nx_state1;
        end if;
        
        if rising_edge(clk) or falling_edge(clk) then
            pr_state2 <= nx_state2;
        end if;
    end process;
    
    -- State machine for out1 (changes at rising edge of clk)
    process(pr_state1)
    begin
        case pr_state1 is 
            when one =>
                out1 <= '0';
                nx_state1 <= two;
            when two =>
                out1 <= '1';
				nx_state1 <= two;
			when two =>
                out1 <= '0';
				nx_state1 <= one;

			
        end case;
    end process;
    
    -- State machine for out2 (changes at both edges of clk)
    process(pr_state2)
    begin
        case pr_state2 is 
            when one =>
                out2 <= '0';
                nx_state2 <= two;
            when two =>
				if clk = '0' or clk = '1' then
                out2 <= '1';
				end if;
                nx_state2 <= two;

 
							
        end case;
    end process;

end architecture fsm;