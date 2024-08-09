library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY counter IS
    PORT (
        clk   : IN  std_logic;
		rst   : IN  std_logic;
        count : OUT std_logic_vector (3 downto 0)
    );
END ENTITY counter;

ARCHITECTURE state_machine OF counter IS

    TYPE state IS (zero, one, two, three, four, five, six, seven, eight, nine);
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
	PROCESS(pr_state)
	BEGIN
		CASE pr_state IS 
		
			WHEN zero =>
			count <="0000";
			nx_state <=one;
			
			WHEN one =>
			count <="0001";
			nx_state <=two;
			
			WHEN two =>
			count <="0010";
			nx_state <=three;
			
			WHEN three =>
			count <="0011";
			nx_state <=four;
			
			WHEN four =>
			count <="0100";
			nx_state <=five;
			
			WHEN five =>
			count <="0101";
			nx_state <=six;
			
			WHEN six =>
			count <="0110";
			nx_state <=seven;
			
			WHEN seven =>
			count <="0111";
			nx_state <=eight;
						
			WHEN eight =>
			count <="1000";
			nx_state <=nine;
			
			WHEN nine =>
			count <="1001";
			nx_state <=zero;
			

		END CASE;
	END PROCESS;
	
END ARCHITECTURE state_machine;
