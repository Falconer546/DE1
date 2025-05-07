
library ieee;
    use ieee.std_logic_1164.all;

-------------------------------------------------

entity Bin2Seg is
    port (
        clear : in    std_logic;                    
        bin   : in    std_logic_vector(3 downto 0); 
        seg   : out   std_logic_vector(6 downto 0)  
    );
end entity Bin2Seg;

-------------------------------------------------

architecture behavioral of Bin2Seg is
begin

    p_7seg_decoder : process (bin, clear) is
    begin

        if (clear = '1') then
            seg <= "1111111";  -- Clear the display
        else

            case bin is

                when x"0" =>
                    seg <= "1000000";

                when x"1" =>
                    seg <= "1111001";

                when x"2" =>
                    seg <= "0100100";

                when x"3" =>
                    seg <= "0110000";

                when x"4" =>
                    seg <= "0011001";

                when x"5" =>
                    seg <= "0010010";

                when x"6" =>
                    seg <= "0000010";

                when x"7" =>
                    seg <= "1111000";

                when x"8" =>
                    seg <= "0000000";

                when x"9" =>
                    seg <= "0010000";
                    
                when others =>
                    seg <= "1111111";

            end case;

        end if;

    end process p_7seg_decoder;

end architecture behavioral;