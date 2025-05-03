-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : Sat, Wed, 30 April 2025 11:36:25 GMT
-- Request id : cfwk-fed377c2-681644f7c0bb3

library ieee;
use ieee.std_logic_1164.all;

entity tb_clockEnable is
end tb_clockEnable;

architecture tb of tb_clockEnable is

    component clockEnable
        generic (
            n_periods : integer := 5  
        );
        port (
            clk   : in std_logic;
            rst   : in std_logic;
            pulse : out std_logic
        );
    end component;

    signal clk    : std_logic := '0';
    signal rst    : std_logic := '0';
    signal pulse  : std_logic;

    constant clk_period : time := 10 ns;
    signal TbSimEnded   : std_logic := '0';

begin

   
    uut: clockEnable
        generic map (
            n_periods => 5  -- v�stupn� pulz ka�d�ch 5 hodinov�ch cykl�
        )
        port map (
            clk   => clk,
            rst   => rst,
            pulse => pulse
        );

    -- Generov�n� hodinov�ho sign�lu
    clk_process : process
    begin
        while TbSimEnded = '0' loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
        wait;
    end process;

   
    stim_proc: process
    begin
        -- Reset na za��tku
        rst <= '1';
        wait for clk_period * 2;
        rst <= '0';

        -- pulz ka�d�ch 5 cykl�
        wait for clk_period * 30;

        -- Konec simulace
        TbSimEnded <= '1';
        wait;
    end process;

end tb;
