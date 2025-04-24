
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_segmentLogic is
end;

architecture testbench of tb_segmentLogic is
    signal clk     : std_logic := '0';
    signal rst     : std_logic := '0';
    signal clk_en  : std_logic := '0';
    signal digits  : std_logic_vector(31 downto 0) := x"01234567";
    signal seg     : std_logic_vector(6 downto 0);
    signal blink   : std_logic := '0';
    signal an      : std_logic_vector(7 downto 0);
    signal dp      : std_logic;

    constant clk_period : time := 10 ns;

begin
    -- Generátor hodin (100 MHz)
    clk_gen : process
    begin
        while now < 20 ms loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
        wait;
    end process;

    -- Generátor clk_en pro přepínání číslic
    clk_en_proc : process
    begin
        while now < 20 ms loop
            clk_en <= '1';
            wait for 100 us;
            clk_en <= '0';
            wait for 100 us;
        end loop;
        wait;
    end process;

    -- Generátor blink (simulace blikání dvojtečky)
    blink_proc : process
    begin
        while now < 20 ms loop
            blink <= '1';
            wait for 500 us;
            blink <= '0';
            wait for 500 us;
        end loop;
        wait;
    end process;

    -- DUT instance
    uut: entity work.segmentLogic
        port map (
            clk     => clk,
            rst     => rst,
            clk_en  => clk_en,
            digits  => digits,
            blink   => blink,
            seg     => seg,
            an      => an,
            dp      => dp
        );

    -- Reset a start simulace
    stim_proc: process
    begin
        rst <= '1'; wait for 20 ns; rst <= '0';
        wait;
    end process;

end architecture;
