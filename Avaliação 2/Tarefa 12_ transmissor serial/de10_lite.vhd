-------------------------------------------------------------------
-- Name        : de_10_lite.vhd
-- Author      : Elvis Fernandes
-- Version     : 0.1
-- Copyright   : Departamento de Eletrônica, Florianópolis, IFSC
-- Description : Tarefa 12: transmissor serial
-- Date        : 07/08/2024

-------------------------------------------------------------------
LIBRARY ieee;
USE IEEE.STD_LOGIC_1164.ALL;

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
    signal addr       : std_logic_vector(7 downto 0) := "11001100";        
    signal data       : std_logic_vector(7 downto 0) := "01010101";
    signal sdata      : std_logic; -- Sinal de saída

begin
    -- Instanciação do fsm_transmissor
    dut: entity work.simple_fsm_transmissor
        port map (
            clk   => MAX10_CLK1_50,
            start => SW(1),
            reset => SW(0),
            data  => data,
            addr  => addr,
            sdata => sdata
        );

    -- Mapear sdata para ARDUINO_IO
    ARDUINO_IO(0) <= sdata;

end architecture;

