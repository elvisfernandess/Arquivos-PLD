-------------------------------------------------------------------
-- Name        : de_10_lite.vhd
-- Author      : Elvis Fernandes
-- Version     : 0.1
-- Copyright   : Departamento de Eletrônica, Florianópolis, IFSC
-- Description : Tarefa 09: síntese multiplicador
-- Date        : 26/04/2024
-------------------------------------------------------------------
LIBRARY ieee;
USE IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity de10_lite is
    port(
        ---------- CLOCK ----------
        ADC_CLK_10      : in    std_logic;
        MAX10_CLK1_50   : in    std_logic;
        MAX10_CLK2_50   : in    std_logic;
        ----------- SDRAM ------------
        DRAM_ADDR       : out   std_logic_vector(12 downto 0);
        DRAM_BA         : out   std_logic_vector(1 downto 0);
        DRAM_CAS_N      : out   std_logic;
        DRAM_CKE        : out   std_logic;
        DRAM_CLK        : out   std_logic;
        DRAM_CS_N       : out   std_logic;
        DRAM_DQ         : inout std_logic_vector(15 downto 0);
        DRAM_LDQM       : out   std_logic;
        DRAM_RAS_N      : out   std_logic;
        DRAM_UDQM       : out   std_logic;
        DRAM_WE_N       : out   std_logic;
        ----------- SEG7 ------------
        HEX0            : out   std_logic_vector(7 downto 0);
        HEX1            : out   std_logic_vector(7 downto 0);
        HEX2            : out   std_logic_vector(7 downto 0);
        HEX3            : out   std_logic_vector(7 downto 0);
        HEX4            : out   std_logic_vector(7 downto 0);
        HEX5            : out   std_logic_vector(7 downto 0);
        ----------- KEY ------------
        KEY             : in    std_logic_vector(1 downto 0);
        ----------- LED ------------
        LEDR            : out   std_logic_vector(9 downto 0);
        ----------- SW ------------
        SW              : in    std_logic_vector(9 downto 0);
        ----------- VGA ------------
        VGA_B           : out   std_logic_vector(3 downto 0);
        VGA_G           : out   std_logic_vector(3 downto 0);
        VGA_HS          : out   std_logic;
        VGA_R           : out   std_logic_vector(3 downto 0);
        VGA_VS          : out   std_logic;
        ----------- Accelerometer ------------
        GSENSOR_CS_N    : out   std_logic;
        GSENSOR_INT     : in    std_logic_vector(2 downto 1);
        GSENSOR_SCLK    : out   std_logic;
        GSENSOR_SDI     : inout std_logic;
        GSENSOR_SDO     : inout std_logic;
        ----------- Arduino ------------
        ARDUINO_IO      : inout std_logic_vector(15 downto 0);
        ARDUINO_RESET_N : inout std_logic
    );
end entity;

architecture rtl of de10_lite is

    signal product8x8     : unsigned(15 downto 0); -- Sinal de saída do multiplicador 8x8.
    signal input          : unsigned(7 downto 0);
    signal reset_a        : std_logic;
    signal start          : std_logic;
    signal done_flag      : std_logic;
    signal segs           : unsigned(7 downto 0);
    signal product8x8_out : unsigned(15 downto 0);
    signal dataa          : unsigned(7 downto 0);
    signal datab          : unsigned(15 downto 8);
    signal hex_0_uns      : unsigned(7 downto 0);
    signal hex_1_uns      : unsigned(7 downto 0);
    signal hex_2_uns      : unsigned(7 downto 0);
    signal hex_3_uns      : unsigned(7 downto 0);
    --signal produto8x8_parte_med  : std_logic_vector(15 downto 8);
    signal produto8x8_0   : std_logic_vector(3 downto 0);
    signal produto8x8_1   : std_logic_vector(7 downto 4);
    signal produto8x8_2   : std_logic_vector(11 downto 8);
    signal produto8x8_3   : std_logic_vector(15 downto 12);
    signal source         : std_logic_vector(15 downto 0);
    signal probe          : std_logic_vector(15 downto 0);

    component unnamed is
        port(
            source : out std_logic_vector(15 downto 0); -- source
            probe  : in  std_logic_vector(15 downto 0) := (others => 'X') -- probe
        );
    end component unnamed;

    signal produto_std_logic : std_logic_vector(15 downto 0);

begin

    u0 : component unnamed
        port map(
            source => source,           -- sources.source
            probe  => probe             --  probes.probe
        );

    probe <= produto_std_logic;

    dataa <= unsigned(source(7 downto 0));
    datab <= unsigned(source(15 downto 8));

    -- Instanciando o DUT
    dut : entity work.multiplicador8x8
        generic map(
            DATA_WIDTH => 16
        )
        port map(
            dataa          => dataa,
            datab          => datab,
            start          => SW(2),
            reset_a        => SW(1),
            clk            => SW(0),
            done_flag      => LEDR(0),
            product8x8_out => product8x8,
            segs           => segs
        );

    HEX5 <= std_logic_vector(segs);

    produto_std_logic <= std_logic_vector(product8x8);

    seven_segment_cntrl_hex0 : entity work.seven_segment_cntrl
        port map(
            input => produto_std_logic(3 downto 0),
            segs  => hex_0_uns);

    HEX0 <= std_logic_vector(hex_0_uns);

    seven_segment_cntrl_hex1 : entity work.seven_segment_cntrl
        port map(
            input => produto_std_logic(7 downto 4),
            segs  => hex_1_uns);

    HEX1 <= std_logic_vector(hex_1_uns);

    seven_segment_cntrl_hex2 : entity work.seven_segment_cntrl
        port map(
            input => produto_std_logic(11 downto 8),
            segs  => hex_2_uns);

    HEX2 <= std_logic_vector(hex_2_uns);

    seven_segment_cntrl_hex3 : entity work.seven_segment_cntrl
        port map(
            input => produto_std_logic(15 downto 12),
            segs  => hex_3_uns);

    HEX3 <= std_logic_vector(hex_3_uns);

end architecture;
