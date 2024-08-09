-------------------------------------------------------
--! Tarefa 08: FSM
--! Aluno: Elvis Fernandes
--! Data: 16/04/2024
--! Arquivo: mult_control.vhd
-------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mult_control is
    port(
        clk       : in  std_logic;      -- Clock de entrada
        reset_a   : in  std_logic;      -- Sinal de reset assíncrono
        start     : in  std_logic;      -- Sinal de início da operação
        count     : in  unsigned(1 downto 0); -- Contador de operações
        input_sel : out unsigned(1 downto 0); -- Seleção de entrada
        shift_sel : out std_logic_vector(1 downto 0); -- Seleção de deslocamento
        state_out : out unsigned(2 downto 0); -- Estado atual da máquina de estados
        done      : out std_logic;      -- Sinal de conclusão
        clk_ena   : out std_logic;      -- Sinal de habilitação do clock
        sclr_n    : out std_logic       -- Sinal de reset assíncrono
    );
end entity mult_control;

architecture RTL of mult_control is
    type state_type is (IDLE, LSB, MID, MSB, CALC_DONE, ERR);
    signal state         : state_type;
    signal done_internal : std_logic;

begin

    state_transition : process(clk, reset_a) is
    begin
        if reset_a = '1' then
            state <= IDLE;
        elsif rising_edge(clk) then
            case state is
                when IDLE =>
                    if start = '1' then
                        state <= LSB;
                    end if;
                when LSB =>
                    if start = '0' and (count = "00" or count = "01") then
                        state <= MID;
                    else
                        state <= ERR;
                    end if;
                when MID =>
                    if start = '0' and count = "01" then
                        state <= MSB;
                    else
                        state <= ERR;
                    end if;
                when MSB =>
                    if start = '0' and count = "10" then
                        state <= CALC_DONE;
                    else
                        state <= ERR;
                    end if;
                when CALC_DONE =>
                    if start = '0' and done_internal = '1' then
                        state <= IDLE;
                    end if;
                when ERR =>
                    if start = '1' then
                        state <= LSB;
                    end if;
            end case;
        end if;
    end process state_transition;

    process(state)
    begin
        state_out <= "000";
        case state is
            when IDLE =>
            when LSB       => state_out <= "001";
            when MID       => state_out <= "010";
            when MSB       => state_out <= "011";
            when CALC_DONE => state_out <= "100";
            when ERR       => state_out <= "101";
        end case;

    end process;

    process(state, start, count) is
    begin
        input_sel <= "00";
        shift_sel <= "00";
        done      <= '0';
        clk_ena   <= '0';
        sclr_n    <= '1';

        case state is
            when IDLE =>
                if start = '1' then
                    input_sel <= "00";
                    shift_sel <= "00";
                    done      <= '0';
                    clk_ena   <= '1';
                    sclr_n    <= '0';
                end if;

            when LSB =>
                if start = '0' and count = "00" then
                    input_sel <= "00";
                    shift_sel <= "00";
                    done      <= '0';
                    clk_ena   <= '1';
                    sclr_n    <= '1';
                end if;

            when MID =>

                if start = '0' and count = "01" then
                    input_sel <= "01";
                    shift_sel <= "01";
                    done      <= '0';
                    clk_ena   <= '1';
                    sclr_n    <= '1';
                end if;

            when MSB =>

                if start = '0' and count = "10" then
                    input_sel <= "10";
                    shift_sel <= "01";
                    done      <= '0';
                    clk_ena   <= '1';
                    sclr_n    <= '1';
                end if;

            when CALC_DONE =>

                if start = '0' and count = "11" then
                    input_sel <= "11";
                    shift_sel <= "10";
                    --done      <= done_internal; -- Alterado para usar o sinal interno
                    done      <= '0';
                    clk_ena   <= '1';
                    sclr_n    <= '1';
                end if;

            when ERR =>

                if start = '1' then
                    input_sel <= "10";
                    shift_sel <= "10";
                    done      <= '0';
                    clk_ena   <= '0';
                    sclr_n    <= '1';
                end if;

                if start = '0' then
                    input_sel <= "10";
                    shift_sel <= "10";
                    done      <= '1';
                    clk_ena   <= '0';
                    sclr_n    <= '1';
                end if;

            when others =>
                input_sel <= "11";
                shift_sel <= "11";
                done      <= '0';
                clk_ena   <= '0';
                sclr_n    <= '1';
        end case;
    end process;

    -- Processo auxiliar para atribuir o valor do sinal done
    done_internal_process : process(state)
    begin
        case state is
            when CALC_DONE =>
                done_internal <= '1';   -- Atribui '1' quando a máquina de estados está em CALC_DONE
            when others =>
                done_internal <= '0';   -- Atribui '0' para qualquer outro estado
        end case;
    end process done_internal_process;

end architecture RTL;
