library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_clockLogic is
end;

architecture testbench of tb_clockLogic is
    signal clk    : std_logic := '0';
    signal rst    : std_logic := '0';
    signal clk_en : std_logic := '0';
    signal start  : std_logic := '0';
    signal digits : std_logic_vector(31 downto 0);

    constant clk_period : time := 10 ns;

begin

    clk_gen : process
    begin
        while now < 400 ms loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    uut: entity work.clockLogic
        port map (
            clk     => clk,
            rst     => rst,
            clk_en  => clk_en,
            digits  => digits,
            start   => start
        );

    stim_proc: process
    begin
        rst <= '1'; wait for 20 ns; rst <= '0';
        
        wait for 160 ns;
        
        start <= '1'; wait for 20 ns; start <= '0';

        for i in 0 to 500 loop
            clk_en <= '1'; wait for clk_period; clk_en <= '0';
            wait for 10 ms - clk_period;
        end loop;

        wait for 100 ms;
    end process;

end architecture;
