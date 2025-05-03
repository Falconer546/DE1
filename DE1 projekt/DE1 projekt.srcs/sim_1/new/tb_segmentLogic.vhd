-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : Wed, 30 April 2025 11:43:41 GMT
-- Request id : cfwk-fed377c2-681647bd11f09

library ieee;
use ieee.std_logic_1164.all;

entity tb_segmentLogic is
end tb_segmentLogic;

architecture tb of tb_segmentLogic is

    component segmentLogic
        port (clk    : in std_logic;
              rst    : in std_logic;
              clk_en : in std_logic;
              mode   : in std_logic;
              digits : in std_logic_vector (31 downto 0);
              seg    : out std_logic_vector (6 downto 0);
              an     : out std_logic_vector (7 downto 0);
              dp     : out std_logic);
    end component;

    signal clk    : std_logic;
    signal rst    : std_logic;
    signal clk_en : std_logic;
    signal mode   : std_logic;
    signal digits : std_logic_vector (31 downto 0);
    signal seg    : std_logic_vector (6 downto 0);
    signal an     : std_logic_vector (7 downto 0);
    signal dp     : std_logic;

    constant TbPeriod : time := 1000 ns; -- ***EDIT*** Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : segmentLogic
    port map (clk    => clk,
              rst    => rst,
              clk_en => clk_en,
              mode   => mode,
              digits => digits,
              seg    => seg,
              an     => an,
              dp     => dp);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- ***EDIT*** Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed
        clk_en <= '0';
        mode <= '0';
        digits <= (others => '0');

        -- Reset generation
        -- ***EDIT*** Check that rst is really your reset signal
        rst <= '1';
        wait for 100 ns;
        rst <= '0';
        wait for 100 ns;

        -- ***EDIT*** Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_segmentLogic of tb_segmentLogic is
    for tb
    end for;
end cfg_tb_segmentLogic;