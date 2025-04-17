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
    signal an      : std_logic_vector(7 downto 0);
    signal dp      : std_logic;

    constant clk_period : time := 10 ns;

begin
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

    uut: entity work.segmentLogic
        port map (
            clk     => clk,
            rst     => rst,
            clk_en  => clk_en,
            digits  => digits,
            seg     => seg,
            an      => an,
            dp      => dp
        );

    stim_proc: process
    begin
        rst <= '1'; wait for 20 ns; rst <= '0';
        wait for 50 ns;

        for i in 0 to 15 loop
            clk_en <= '1'; wait for clk_period; clk_en <= '0';
            wait for 999 * clk_period;
        end loop;
        wait;
    end process;

end architecture;
