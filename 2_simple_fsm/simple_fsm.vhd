library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity simple_fsm is
    port (
        a     : in  BIT;
        b     : in  BIT;
        d     : in  BIT;
        clk   : in  BIT;
		rst   : in  BIT;
        x     : OUT BIT
    );
end entity simple_fsm;

architecture rtl of simple_fsm is

    type state is (stateA, stateB);
    signal pr_state, nx_state : state;

begin

	-------------Lower section---------------

	process(rst, clk) is
		begin
			if rst = '1' then
            pr_state <= stateA;
			elsif (clk'event AND clk='1') then
            pr_state <= nx_state;
			end if;
	end process;
	
	-------------Uper section---------------
	process(a,b,d,pr_state)
	begin
		case pr_state is 
			when stateA =>
			x <=a;
			if (d='1') then nx_state<=stateB;
			else nx_state<=stateA;
			end if;
			when stateB =>
			x<=b;
			if(d='1') then nx_state<=stateA;
			else nx_state <=stateB;
			end if;
		end case;
	end process;
	
end architecture rtl;
