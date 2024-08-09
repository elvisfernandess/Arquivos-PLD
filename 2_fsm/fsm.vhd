library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsm is
    port (
        clk   : in  std_logic;
        rst   : in  std_logic;
        inp   : in  std_logic;
        outp  : out std_logic_vector (1 downto 0)
    );
end entity fsm;

architecture rtl of fsm is

    type state_type is (state1, state2, state3, state4);
    signal state : state_type;

begin

    process (rst, clk) is
    begin
        if rst = '1' then
            state <= state1;
        elsif rising_edge(clk) then
            case state is
                when state1 =>
                    if inp = '1' then 
                        state <= state2;
                    else 
                        state <= state1;
                    end if;
                    
                when state2 =>
                    if inp = '1' then 
                        state <= state4;
                    else 
                        state <= state3;
                    end if;
                    
                when state3 =>
                    if inp = '1' then 
                        state <= state4;
                    else 
                        state <= state3;
                    end if;
                    
                when state4 =>
                    if inp = '1' then 
                        state <= state1;
                    else 
                        state <= state2;
                    end if;
            end case;
        end if;
    end process;
    
    -- Saída(s) tipo Moore:
    -- Apenas relacionadas com o estado.
    moore: process(state)
    begin
        case state is 
            when state1 =>
                outp <= "00";
                
            when state2 =>
                outp <= "01";
                
            when state3 =>
                outp <= "10";
                
            when state4 =>
                outp <= "11";
        end case;
    end process;
    
end architecture rtl;
