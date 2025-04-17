library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity segmentLogic is
    port (
        clk     : in  std_logic;
        rst     : in  std_logic;
        clk_en  : in  std_logic;
        digits  : in  std_logic_vector(31 downto 0);
        seg     : out std_logic_vector(6 downto 0);
        an      : out std_logic_vector(7 downto 0)
        --dp      : out std_logic
    );
end entity;

architecture Behavioral of SegmentLogic is

    signal digit_index     : unsigned(2 downto 0) := (others => '0');
    signal current_digit   : std_logic_vector(3 downto 0);

begin

    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                digit_index <= (others => '0');
            elsif clk_en = '1' then
                digit_index <= digit_index + 1;
            end if;
        end if;
    end process;

    process(digit_index, digits)
    begin
        case digit_index is
            when "000" =>
                current_digit <= digits(3 downto 0);
                an <= "11111110";
                --dp <= '1'; -- dot
            when "001" =>
                current_digit <= digits(7 downto 4);
                an <= "11111101";
                --dp <= '1';
            when "010" =>
                current_digit <= digits(11 downto 8);
                an <= "11111011";
                --dp <= '1';
            when "011" =>
                current_digit <= digits(15 downto 12);
                an <= "11110111";
                --dp <= '0';
            when "100" =>
                current_digit <= digits(19 downto 16);
                an <= "11101111";
                --dp <= '0';
            when "101" =>
                current_digit <= digits(23 downto 20);
                an <= "11011111";
                --dp <= '1';
            when "110" =>
                current_digit <= digits(27 downto 24);
                an <= "10111111";
                --dp <= '1';
            when others =>
                current_digit <= digits(31 downto 28);
                an <= "01111111";
                --dp <= '1';
        end case;
    end process;

    -- Decoder instance
    decoder_inst : entity work.Bin2Seg
        port map (
            clear => '0',
            bin   => current_digit,
            seg   => seg
        );

end architecture;