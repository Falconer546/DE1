-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : Wed, 30 April 2025 11:43:41 GMT
-- Request id : cfwk-fed377c2-681647bd11f09


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_segmentLogic is
end entity;

architecture sim of tb_segmentLogic is

    component segmentLogic
        port (
            clk     : in  std_logic;
            rst     : in  std_logic;
            clk_en  : in  std_logic;
            mode    : in  std_logic;
            digits  : in  std_logic_vector(31 downto 0);
            finish  : in  std_logic;
            seg     : out std_logic_vector(6 downto 0);
            an      : out std_logic_vector(7 downto 0);
            dp      : out std_logic
        );
    end component;

    -- Signals
    signal clk     : std_logic := '0';
    signal rst     : std_logic := '1';
    signal clk_en  : std_logic := '0';
    signal mode    : std_logic := '1'; -- èasovaè
    signal digits  : std_logic_vector(31 downto 0) := (others => '0');
    signal finish  : std_logic := '0';
    signal seg     : std_logic_vector(6 downto 0);
    signal an      : std_logic_vector(7 downto 0);
    signal dp      : std_logic;

    constant clk_period : time := 10 ns;
begin

    -- DUT
    uut : segmentLogic
        port map (
            clk     => clk,
            rst     => rst,
            clk_en  => clk_en,
            mode    => mode,
            digits  => digits,
            finish  => finish,
            seg     => seg,
            an      => an,
            dp      => dp
        );

    -- Clock generation
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for clk_period/2;
            clk <= '1';
            wait for clk_period/2;
        end loop;
        wait;
    end process;

    -- Stimuli
    stim_proc : process
    begin
        rst <= '1';
        wait for 30 ns;
        rst <= '0';

        -- Enable refresh
        clk_en <= '1';

        -- Display 00:00.00
        digits <= x"00000000";

        -- Simulate that finish = '1' (èasovaè dobìhl)
        finish <= '1';

        wait for 5 ms;

        -- Simulate end of blinking
        finish <= '0';

        wait for 1 ms;
        clk_en <= '0';
        wait;
    end process;

end architecture;