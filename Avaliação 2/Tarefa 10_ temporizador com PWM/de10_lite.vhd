
-------------------------------------------------------------------
-- Name        : de_10_lite.vhd
-- Author      : Elvis Fernandes
-- Version     : 0.1
-- Copyright   : Departamento de Eletrônica, Florianópolis, IFSC
-- Description : Tarefa 10: Temporizador com PWM
-- Date        : 12/07/2024

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

    component unnamed is
        port(
            source : out std_logic_vector(15 downto 0); -- source
            probe  : in  std_logic_vector(7 downto 0) := (others => 'X') -- probe
        );
    end component unnamed;

    -- signal clk        : std_logic;
    -- signal rst        : std_logic;
    signal sel_pr           : std_logic_vector(2 downto 0) := "010"; -- Ajustado para 3 bits
    signal input_comp1      : unsigned(7 downto 0)         := "00001000";
    signal input_comp2      : unsigned(7 downto 0)         := "00001100";
    signal out_clk          : std_logic;
    signal comp_out1        : std_logic;
    signal comp_out2        : std_logic;
    signal comp_out3        : std_logic;
    signal comp_out4        : std_logic;
    signal counter          : unsigned(7 downto 0);
    signal source           : std_logic_vector(15 downto 0);
    signal probe            : std_logic_vector(7 downto 0);
    signal result_std_logic : std_logic_vector(7 downto 0);

begin

    u0 : component unnamed
        port map(
            source => source,           -- sources.source
            probe  => probe             --  probes.probe
        );

    probe       <= result_std_logic;
    input_comp1 <= unsigned(source(7 downto 0));
    input_comp2 <= unsigned(source(15 downto 8));

    dut : entity work.prescaler
        port map(
            clk         => MAX10_CLK1_50,
            rst         => SW(3),
            sel_pr      => SW(2 downto 0),
            input_comp1 => input_comp1,
            input_comp2 => input_comp2,
            out_clk     => out_clk,
            comp_out1   => ARDUINO_IO(0),
            comp_out2   => ARDUINO_IO(1),
            comp_out3   => ARDUINO_IO(2),
            comp_out4   => ARDUINO_IO(3),
            counter     => counter
        );

end architecture;
