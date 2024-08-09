-------------------------------------------------------------------
-- Name        : de_10_lite.vhd
-- Author      : Elvis Fernandes
-- Version     : 0.1
-- Copyright   : Departamento de Eletrônica, Florianópolis, IFSC
-- Description : Tarefa 11: subprogramas
-- Date        : 02/08/2024
-------------------------------------------------------------------


    --Implemente um pacote que contenha a função especificada abaixo.
    --- Desenvolva usando a simulação.
    --- Sintetize e teste no kit DE10-Lite.
    --- Analise a quantidade de hardware utilizado no resultado da síntese.

    --Escreva uma função que faz a conversão de 4-bits BCD para display de 7-segmentos (0 a 0xF).
        --Use um vetor (array) constante para definir a tabela.
    --Escreve outra função que recebe um número de 8-bits e converte para dois diplays de 7 segmentos. Use a função acima.
        --Teste utilizando 2 displays de 7 segmentos e um contador síncrono.


LIBRARY ieee;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE work.bcd_to_7seg_pkg.ALL; -- Importar o pacote para usar as funções

entity de10_lite is 
port (
---------- CLOCK ----------
ADC_CLK_10: in std_logic;
MAX10_CLK1_50: in std_logic;
MAX10_CLK2_50: in std_logic;

----------- SDRAM ------------
DRAM_ADDR: out std_logic_vector (12 downto 0);
DRAM_BA: out std_logic_vector (1 downto 0);
DRAM_CAS_N: out std_logic;
DRAM_CKE: out std_logic;
DRAM_CLK: out std_logic;
DRAM_CS_N: out std_logic;		
DRAM_DQ: inout std_logic_vector(15 downto 0);
DRAM_LDQM: out std_logic;
DRAM_RAS_N: out std_logic;
DRAM_UDQM: out std_logic;
DRAM_WE_N: out std_logic;

----------- SEG7 ------------
HEX0: out std_logic_vector(7 downto 0);
HEX1: out std_logic_vector(7 downto 0);
HEX2: out std_logic_vector(7 downto 0);
HEX3: out std_logic_vector(7 downto 0);
HEX4: out std_logic_vector(7 downto 0);
HEX5: out std_logic_vector(7 downto 0);

----------- KEY ------------
KEY: in std_logic_vector(1 downto 0);

----------- LED ------------
LEDR: out std_logic_vector(9 downto 0);

----------- SW ------------
SW: in std_logic_vector(9 downto 0);

----------- VGA ------------
VGA_B: out std_logic_vector(3 downto 0);
VGA_G: out std_logic_vector(3 downto 0);
VGA_HS: out std_logic;
VGA_R: out std_logic_vector(3 downto 0);
VGA_VS: out std_logic;

----------- Accelerometer ------------
GSENSOR_CS_N: out std_logic;
GSENSOR_INT: in std_logic_vector(2 downto 1);
GSENSOR_SCLK: out std_logic;
GSENSOR_SDI: inout std_logic;
GSENSOR_SDO: inout std_logic;

----------- Arduino ------------
ARDUINO_IO: inout std_logic_vector(15 downto 0);
ARDUINO_RESET_N: inout std_logic
);
end entity;

architecture rtl of de10_lite is

    component counter is
        generic (
            DATA_WIDTH_OUT : integer := 7
        );
        port (
            clk       : in std_logic; 
            aclr_n    : in std_logic; 
            count_out : out unsigned(DATA_WIDTH_OUT downto 0)
        );
    end component counter;

    signal count_out         : unsigned(7 downto 0);
    signal hex0_output       : std_logic_vector(7 downto 0);
    signal hex1_output       : std_logic_vector(7 downto 0);
    signal clk_div           : std_logic := '0'; -- Sinal de clock dividido
    signal hex0_counter      : unsigned(3 downto 0) := (others => '0'); -- Contador para HEX0
    signal hex1_counter      : unsigned(3 downto 0) := (others => '0'); -- Contador para HEX1
    signal hex0_done         : std_logic := '0'; -- Sinal de conclusão de HEX0

begin

    -- Divisor de Clock para gerar um sinal de clock mais lento
    process(MAX10_CLK1_50)
        variable counter : integer := 0;
    begin
        if rising_edge(MAX10_CLK1_50) then
            counter := counter + 1;
            if counter = 50000000 then -- Ajuste este valor conforme necessário
                clk_div <= not clk_div;
                counter := 0;
            end if;
        end if;
    end process;

    -- Contador síncrono
    u_counter : counter
    generic map (
        DATA_WIDTH_OUT => 7
    )
    port map (
        clk       => clk_div, -- Usando o clock dividido
        aclr_n    => SW(1),  -- Evita reset contínuo
        count_out => count_out
    );

-- Processamento para atualizar os displays HEX
    process(clk_div)
    begin
        if rising_edge(clk_div) then
            -- Atualiza HEX0
            if hex0_counter = 15 then
                hex0_counter <= (others => '0');
                hex0_done <= '1'; -- Indica que HEX0 terminou de contar
            else
                hex0_counter <= hex0_counter + 1;
                hex0_done <= '0'; -- HEX0 ainda está contando
            end if;

            -- Atualiza HEX1 somente se HEX0 terminou a contagem
            if hex0_done = '1' then
                if hex1_counter = 15 then
                    hex1_counter <= (others => '0');
                else
                    hex1_counter <= hex1_counter + 1;
                end if;
            end if;

            -- Atualiza os displays HEX0 e HEX1
            hex0_output <= bcd_to_7seg(std_logic_vector(hex0_counter));
            hex1_output <= bcd_to_7seg(std_logic_vector(hex1_counter));
        end if;
    end process;

    -- Conectar as saídas aos displays HEX0 e HEX1
    HEX0 <= hex0_output;
    HEX1 <= hex1_output;

end architecture rtl;
