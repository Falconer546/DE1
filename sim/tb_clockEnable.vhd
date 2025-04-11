library ieee;
use ieee.std_logic_1164.all;

entity tb_clockEnable is
end;

architecture testbench of tb_clockEnable is
    signal clk   : std_logic := '0';
    signal rst   : std_logic := '0';
    signal pulse : std_logic;

    constant clk_period : time := 10 ns;

begin
    clk_process : process
    begin
        while now < 2 ms loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
        wait;
    end process;

    uut: entity work.clockEnable
        generic map (n_periods => 10)
        port map (
            clk   => clk,
            rst   => rst,
            pulse => pulse
        );
    stim_proc: process
    begin
        wait for 50 ns;
        rst <= '1'; wait for 20 ns; rst <= '0';
        wait;
    end process;

end architecture;
