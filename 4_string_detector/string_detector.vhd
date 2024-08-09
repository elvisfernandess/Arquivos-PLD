library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY string_detector IS
    PORT (
        clk   : IN  std_logic;
		rst   : IN  std_logic;
		d     : IN  std_logic;
        q     : OUT std_logic
    );
END ENTITY string_detector;

ARCHITECTURE my_arch OF string_detector IS

    TYPE state IS (zero, one, two, three);
    SIGNAL pr_state, nx_state : state;

BEGIN

	-------------Lower section---------------

	PROCESS(rst, clk) IS
		BEGIN
			IF rst = '1' THEN
            pr_state <= zero;
			ELSIF (clk'event AND clk='1') THEN
            pr_state <= nx_state;
			END IF;
	END PROCESS;
	
	-------------Upper section---------------
	PROCESS(d, pr_state)
	BEGIN
		CASE pr_state IS 
		
			WHEN zero =>
			q <='0';
			nx_state <=one;
			if (d = '1') then 
			nx_state <=one;
			ELSE nx_state <=zero;
			END IF;
			
			WHEN one =>
			if (d = '1') then 
			nx_state <=two;
			ELSE nx_state <=zero;
			END IF;
			
			WHEN two =>
			if (d = '1') then 
			nx_state <=three;
			ELSE nx_state <=zero;
			END IF;
			
			WHEN three =>
			q <='1';
			if (d = '0') then 
			nx_state <=one;
			ELSE nx_state <=three;
			END IF;
			
		END CASE;
	END PROCESS;
	
END ARCHITECTURE my_arch;
