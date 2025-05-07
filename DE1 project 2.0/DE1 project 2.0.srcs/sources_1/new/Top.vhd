
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Top is
    port (
        CLK100MHZ : in  std_logic;
        BTNC      : in  std_logic;                 
        BTNU      : in  std_logic;                 
        BTNR      : in  std_logic;                 
        SW        : in  std_logic_vector(10 downto 0);  
        SEG       : out std_logic_vector(6 downto 0);
        AN        : out std_logic_vector(7 downto 0);
        DP        : out std_logic;
        LED       : out std_logic
    );
end entity;

architecture Behavioral of Top is

    -- Signály
    signal clk_100ms : std_logic;
    signal clk_10ms : std_logic;
    signal clk_1kHz  : std_logic;
    signal digits    : std_logic_vector(31 downto 0);
    signal clk_selected : std_logic;
    signal time_zero : std_logic;
begin

    -- Clock enable pro ?asování
    clkEn100ms : entity work.clockEnable
        generic map (
            n_periods => 10_000_000   -- 100ms (100 MHz)
        )
        port map (
            clk   => CLK100MHZ,
            rst   => BTNC,
            pulse => clk_100ms
        );

    clkEn10ms : entity work.clockEnable
    generic map (
        n_periods => 1_000_000   -- 10ms (100 MHz)
    )
    port map (
            clk   => CLK100MHZ,
            rst   => BTNC,
            pulse => clk_10ms
        );

    -- Clock enable pro refresh 7seg (1kHz)
    clkEn1kHz : entity work.clockEnable
        generic map (
            n_periods => 100_000   -- 1ms (100 MHz)
        )
        port map (
            clk   => CLK100MHZ,
            rst   => BTNC,
            pulse => clk_1kHz
        );

    clk_selected <= clk_10ms when SW(0) = '1' else clk_100ms;

clkLogic : entity work.clockLogic
    port map (
        clk      => CLK100MHZ,
        rst      => BTNC,
        start    => BTNU,
        clk_en   => clk_selected,  -- Dynamický výb?r
        mode     => SW(0),
        set_time => SW(10 downto 1),
        lap      => BTNR,
        digits   => digits,
        time_zero => time_zero
    );

    -- Logika pro 7-segmenty
    segLogic : entity work.segmentLogic
        port map (
            clk     => CLK100MHZ,
            rst     => BTNC,
            clk_en  => clk_1kHz,
            mode    => SW(0),
            digits  => digits,
            seg     => SEG,
            an      => AN,
            dp      => DP
        );
    LED <= time_zero;
end architecture;