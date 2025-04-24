
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clockLogic is
    port (
        clk      : in  std_logic;
        rst      : in  std_logic;
        start    : in  std_logic;
        clk_en   : in  std_logic;
        mode     : in  std_logic;
        set_time : in  std_logic_vector(9 downto 0);
        lap      : in  std_logic;
        digits   : out std_logic_vector(31 downto 0)
    );
end entity;

architecture Behavioral of clockLogic is
    -- Časové registry
    signal ms     : integer range 0 to 99 := 0;  -- setiny pro časovač, desetiny pro stopky
    signal sec    : integer range 0 to 59 := 0;
    signal min    : integer range 0 to 9  := 0;

    signal running    : std_logic := '0';
    signal timer_set  : std_logic := '0';

    -- Mezičas pro stopky
    signal lap_min : integer range 0 to 9  := 0;
    signal lap_sec : integer range 0 to 59 := 0;
    signal lap_ms  : integer range 0 to 9  := 0;

begin

    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                ms   <= 0; sec <= 0; min <= 0;
                running <= '0';
                timer_set <= '0';
                lap_min <= 0; lap_sec <= 0; lap_ms <= 0;

            elsif start = '1' then
                running <= '1';

            elsif clk_en = '1' and running = '1' then
    if mode = '0' then
        -- STOPKY (desetiny sekundy)
        if ms = 9 then
            ms <= 0;
            if sec = 59 then
                sec <= 0;
                if min = 9 then
                    min <= 0;
                else
                    min <= min + 1;
                end if;
            else
                sec <= sec + 1;
            end if;
        else
            ms <= ms + 1;
        end if;

    else
        -- ČASOVAČ (setiny sekundy)
        if timer_set = '0' then
            if set_time(10) = '1' then
                -- Speciální případ pro "10 minut"
                min <= 9;
                sec <= 59;
                ms  <= 99;
            else
                -- Standardní nastavení 1 až 9 minut (SW1 až SW9)
                for i in 1 to 9 loop
                    if set_time(i) = '1' then
                        min <= i;
                        sec <= 0;
                        ms  <= 0;
                        exit;
                    end if;
                end loop;
            end if;
            timer_set <= '1';

        else
            -- Odpočítávání
            if ms = 0 then
                ms <= 99;
                if sec = 0 then
                    sec <= 59;
                    if min = 0 then
                        running <= '0';
                    else
                        min <= min - 1;
                    end if;
                else
                    sec <= sec - 1;
                end if;
            else
                ms <= ms - 1;
            end if;
        end if;
    end if;
end if;


            -- Uložení mezičasu pro stopky
            if lap = '1' and mode = '0' and running = '1' then
                lap_min <= min;
                lap_sec <= sec;
                lap_ms  <= ms;
            end if;

        end if;
    end process;

    -- Výstup digits
    process(mode, min, sec, ms, lap_min, lap_sec, lap_ms)
    begin
        if mode = '1' then
            -- ČASOVAČ: M SS MS (5 číslic)
            digits <= std_logic_vector(to_unsigned(min, 4)) &
                      std_logic_vector(to_unsigned(sec / 10, 4)) &
                      std_logic_vector(to_unsigned(sec mod 10, 4)) &
                      std_logic_vector(to_unsigned(ms / 10, 4)) &
                      std_logic_vector(to_unsigned(ms mod 10, 4)) & 
                      x"0" & x"0" & x"0";   -- Zbytek displeje zhasnutý
        else
            -- STOPKY: M SS D | M SS D (mezičas)
            digits <= std_logic_vector(to_unsigned(min, 4)) &
                      std_logic_vector(to_unsigned(sec / 10, 4)) &
                      std_logic_vector(to_unsigned(sec mod 10, 4)) &
                      std_logic_vector(to_unsigned(ms, 4)) &
                      std_logic_vector(to_unsigned(lap_min, 4)) &
                      std_logic_vector(to_unsigned(lap_sec / 10, 4)) &
                      std_logic_vector(to_unsigned(lap_sec mod 10, 4)) &
                      std_logic_vector(to_unsigned(lap_ms, 4));
        end if;
    end process;

end architecture;
