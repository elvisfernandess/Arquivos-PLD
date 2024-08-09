-------------------------------------------------------------------
-- Name        : prescaler.vhd
-- Author      : Elvis Fernandes
-- Version     : 0.1
-- Copyright   : Departamento de Eletrônica, Florianópolis, IFSC
-- Description : Tarefa 10: Temporizador com PWM 
-- Date        : 12/07/2024
-------------------------------------------------------------------
-- Implemente um temporizador de 8-bits com as seguintes características:
-- 2 canais de comparação, cada canal com seu complementar. Total de 4 pinos.
-- Modo de contagem progressiva.
-- 8 níveis configurações de velocidade (prescaler).
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity prescaler is
    port(
        clk         : in  std_logic;
        rst         : in  std_logic;
        sel_pr      : in  std_logic_vector(2 downto 0);
        input_comp1 : in  unsigned(7 downto 0);
        input_comp2 : in  unsigned(7 downto 0);
        out_clk     : out std_logic;
        comp_out1   : out std_logic;
        comp_out2   : out std_logic;
        comp_out3   : out std_logic;
        comp_out4   : out std_logic;
        counter     : out unsigned(7 downto 0) -- Sinal de contador de 8 bits
    );
end prescaler;

architecture rtl of prescaler is
    signal clk4        : std_logic;
    signal clk16       : std_logic;
    signal clk32       : std_logic;
    signal clk64       : std_logic;
    signal clk128      : std_logic;
    signal clk256      : std_logic;
    signal counter_sig : unsigned(7 downto 0) := (others => '0'); -- Contador de 8 bits
begin

    -- Processo para a geração dos sinais de clock divididos
    process(clk, rst)
        variable cont4   : integer range 0 to 3; -- Ajustado para 3 para cobrir 4 estados
        variable cont16  : integer range 0 to 8;
        variable cont32  : integer range 0 to 16;
        variable cont64  : integer range 0 to 32;
        variable cont128 : integer range 0 to 64;
        variable cont256 : integer range 0 to 128;
    begin
        if rst = '1' then
            clk4    <= '0';
            clk16   <= '0';
            clk32   <= '0';
            clk64   <= '0';
            clk128  <= '0';
            clk256  <= '0';
            cont4   := 0;
            cont16  := 0;
            cont32  := 0;
            cont64  := 0;
            cont128 := 0;
            cont256 := 0;
        elsif rising_edge(clk) then
            cont4   := cont4 + 1;
            cont16  := cont16 + 1;
            cont32  := cont32 + 1;
            cont64  := cont64 + 1;
            cont128 := cont128 + 1;
            cont256 := cont256 + 1;

            if cont4 = 3 then
                clk4  <= not clk4;
                cont4 := 0;
            end if;

            if cont16 = 8 then
                clk16  <= not clk16;
                cont16 := 0;
            end if;

            if cont32 = 16 then
                clk32  <= not clk32;
                cont32 := 0;
            end if;

            if cont64 = 32 then
                clk64  <= not clk64;
                cont64 := 0;
            end if;

            if cont128 = 64 then
                clk128  <= not clk128;
                cont128 := 0;
            end if;

            if cont256 = 128 then
                clk256  <= not clk256;
                cont256 := 0;
            end if;
        end if;
    end process;

    -- Processo para o contador de 8 bits
    process(clk, rst)
    begin
        if rst = '1' then
            counter_sig <= (others => '0'); -- Reset do contador
        elsif rising_edge(clk) then
            counter_sig <= counter_sig + 1;
        end if;
    end process;

    -- Processo para os comparadores
    process(counter_sig, input_comp1, input_comp2)
    begin
        if counter_sig >= input_comp1 then
            comp_out1 <= '1';
            comp_out2 <= '0';
        else
            comp_out1 <= '0';
            comp_out2 <= '1';
        end if;

        if counter_sig >= input_comp2 then
            comp_out3 <= '1';
            comp_out4 <= '0';
        else
            comp_out3 <= '0';
            comp_out4 <= '1';
        end if;
    end process;

    -- Mux 8:1
    -- Seleciona o clk escolhido
    with sel_pr select out_clk <=
        clk and (not rst) when "000",
        clk4 when "001",
        clk16 when "010",
        clk32 when "011",
        clk64 when "100",
        clk128 when "101",
        clk256 when "110",
        '0' when others;

    -- Saída do contador
    counter <= counter_sig;

end rtl;
