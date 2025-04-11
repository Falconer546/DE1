library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clockLogic is
    port (
        clk     : in  std_logic;
        rst     : in  std_logic;
        start   : in  std_logic;
        clk_en  : in  std_logic;
        digits  : out std_logic_vector(31 downto 0)
    );
end entity;

architecture Behavioral of clockLogic is
    signal ms   : integer range 0 to 99 := 0;
    signal sec  : integer range 0 to 59 := 0;
    signal min  : integer range 0 to 59 := 0;
    signal hour : integer range 0 to 23 := 0;

    signal d0, d1, d2, d3, d4, d5, d6, d7 : std_logic_vector(3 downto 0);
    signal running : std_logic := '0';
begin

    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                ms   <= 0;
                sec  <= 0;
                min  <= 0;
                hour <= 0;
            elsif start = '1' then
                running <= '1';
            elsif clk_en = '1' and running = '1' then
                if ms = 99 then
                    ms <= 0;
                    if sec = 59 then
                        sec <= 0;
                        if min = 59 then
                            min <= 0;
                            if hour = 23 then
                                hour <= 0;
                            else
                                hour <= hour + 1;
                            end if;
                        else
                            min <= min + 1;
                        end if;
                    else
                        sec <= sec + 1;
                    end if;
                else
                    ms <= ms + 1;
                end if;
            end if;
        end if;
    end process;
    
    d0 <= std_logic_vector(to_unsigned(ms mod 10, 4));
    d1 <= std_logic_vector(to_unsigned(ms / 10, 4));
    d2 <= std_logic_vector(to_unsigned(sec mod 10, 4));
    d3 <= std_logic_vector(to_unsigned(sec / 10, 4));
    d4 <= std_logic_vector(to_unsigned(min mod 10, 4));
    d5 <= std_logic_vector(to_unsigned(min / 10, 4));
    d6 <= std_logic_vector(to_unsigned(hour mod 10, 4));
    d7 <= std_logic_vector(to_unsigned(hour / 10, 4));

    digits <= d7 & d6 & d5 & d4 & d3 & d2 & d1 & d0;

end architecture;
