library ieee;
use ieee.std_logic_1164.all;

entity Top is
    port (
        CLK100MHZ : in  std_logic;
        BTNC      : in  std_logic;
        SW1       : in  std_logic;
        SEG       : out std_logic_vector(6 downto 0);
        AN        : out std_logic_vector(7 downto 0);
        DP        : out std_logic
    );
end entity;

architecture Behavioral of Top is

    -- Signály
    signal clk_10ms  : std_logic;
    signal clk_1kHz  : std_logic;
    signal digits    : std_logic_vector(31 downto 0);

begin

    -- Clock enable - 10ms
    clkEn10ms : entity work.clockEnable
        generic map (
            n_periods => 1_000_000
        )
        port map (
            clk   => CLK100MHZ,
            rst   => BTNC,
            pulse => clk_10ms
        );

    -- Clock enable - 1kHz
    clkEn1kHz : entity work.clockEnable
        generic map (
            n_periods => 100_000
        )
        port map (
            clk   => CLK100MHZ,
            rst   => BTNC,
            pulse => clk_1kHz
        );

    -- Clock logic
    clkLogic : entity work.clockLogic
        port map (
            clk     => CLK100MHZ,
            rst     => BTNC,
            start   => SW1,
            clk_en  => clk_10ms,
            digits  => digits
        );

    -- Segment logic
    segLogic : entity work.segmentLogic
        port map (
            clk     => CLK100MHZ,
            rst     => BTNC,
            clk_en  => clk_1kHz,
            digits  => digits,
            seg     => SEG,
            an      => AN,
            dp      => DP
        );

end architecture;
