library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity signal_gen is
    port (
        clk   : in  BIT;
        outp  : OUT BIT
    );
end entity signal_gen;

architecture fsm of signal_gen is

    type state is (one, two, three);
    signal pr_state1, nx_state1 : state;
	signal pr_state2, nx_state2 : state;
	signal out1, out2: BIT;

begin

	-------------Lower section of machine #1---------------

	process(clk) is
		begin
			if (clk'event AND clk='1') then
            pr_state1 <= nx_state1;
			end if;
	end process;
	
	-------------Lower section of machine #2---------------
	process(clk) is
		begin
			if (clk'event AND clk='0') then
            pr_state2 <= nx_state2;
			end if;
	end process;
	
	-------------Uper section of machine #1 ---------------
	process(pr_state1)
	begin
		case pr_state1 is 
		
			when one =>
			out1 <='0';
			nx_state1<=two;
			
			when two =>
			out1 <='1';
			nx_state1<=three;
			
			when three =>
			out1 <='1';
			nx_state1<=one;
			
		end case;
	end process;
	
		-------------Uper section of machine #2 ---------------
	process(pr_state2)
	begin
		case pr_state2 is 
		
			when one =>
			out2 <='1';
			nx_state2<=two;
			
			when two =>
			out2 <='0';
			nx_state2<=three;
			
			when three =>
			out2 <='1';
			nx_state2<=one;
			
		end case;
	end process;
	
	outp <= out1 AND out2;
	
end architecture fsm;
