-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : Sat, Wed, 30 April 2025 11:41:52 GMT
-- Request id : cfwk-fed377c2-681646550622d

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_clockLogic is
end tb_clockLogic;

architecture tb of tb_clockLogic is

    component clockLogic
        port (
            clk      : in std_logic;
            rst      : in std_logic;
            start    : in std_logic;
            clk_en   : in std_logic;
            mode     : in std_logic;
            set_time : in std_logic_vector (9 downto 0);
            lap      : in std_logic;
            digits   : out std_logic_vector (31 downto 0)
        );
    end component;

    signal clk      : std_logic := '0';
    signal rst      : std_logic := '0';
    signal start    : std_logic := '0';
    signal clk_en   : std_logic := '0';
    signal mode     : std_logic := '0';  -- 0 = stopky, 1 = èasovaè
    signal set_time : std_logic_vector (9 downto 0) := (others => '0');
    signal lap      : std_logic := '0';
    signal digits   : std_logic_vector (31 downto 0);

    constant clk_period : time := 10 ns;
    signal TbSimEnded : std_logic := '0';

begin

    -- DUT
    uut : clockLogic
        port map (
            clk      => clk,
            rst      => rst,
            start    => start,
            clk_en   => clk_en,
            mode     => mode,
            set_time => set_time,
            lap      => lap,
            digits   => digits
        );

    -- Generování hodin
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

    
    stim_proc : process
    begin
        
        --  Reset
      
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        wait for 20 ns;

       
        -- 2) STOPKY režim -poèítání a mezièas
     
        mode <= '0';        -- Stopky
        start <= '1'; wait for 10 ns; start <= '0';

        for i in 0 to 15 loop
            clk_en <= '1'; wait for clk_period; clk_en <= '0';
            wait for 4 * clk_period;  -- pauza pro simulaci reálného bìhu
        end loop;

        -- Mezièas
        lap <= '1'; wait for clk_period; lap <= '0';
        wait for 100 ns;

        
        -- 3) ÈASOVAÈ - odpoèítávání z 2 minut
       
        rst <= '1'; wait for 20 ns; rst <= '0';
        mode <= '1';        -- Èasovaè
        set_time(1) <= '1'; -- SW2 ? 2 minuty
        start <= '1'; wait for 10 ns; start <= '0';

        for i in 0 to 15 loop
            clk_en <= '1'; wait for clk_period; clk_en <= '0';
            wait for 2 * clk_period;
        end loop;

       
        TbSimEnded <= '1';
        wait;
    end process;

end tb;
