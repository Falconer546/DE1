--! @brief Clock enable
--! @version 1.3
--! @copyright (c) 2019-2025 Tomas Fryza, MIT license
--!
--! This VHDL file generates pulses of the clock enable signal.
--! Each pulse is one period of the clock signal wide, and its
--! repetition is determined by the N_PERIODS generic.

--! Developed using TerosHDL, Vivado 2020.2, and EDA Playground.
--! Tested on Nexys A7-50T board and xc7a50ticsg324-1L FPGA.
-------------------------------------------------

library ieee;
  use ieee.std_logic_1164.all;

-------------------------------------------------

entity clockEnable is
  generic (
    n_periods : integer := 3 
  );
  port (
    clk   : in    std_logic; 
    rst   : in    std_logic; 
    pulse : out   std_logic  
  );
end entity clockEnable;

-------------------------------------------------

architecture behavioral of clockEnable is

  signal sig_count : integer range 0 to n_periods - 1;

begin

  --! poèítá pulzy od 0 do n_periods - 1
  p_clk_enable : process (clk) is
  begin
 -- øízení èítaèe
    if (rising_edge(clk)) then                   
      if (rst = '1') then                        
        sig_count <= 0;

      -- logika poèítání
      elsif (sig_count < (n_periods - 1)) then
        sig_count <= sig_count + 1;              

      -- konec poèítání
      else
        sig_count <= 0;
      end if;
    end if;

  end process p_clk_enable;

  -- pulse clk dlouhý
  pulse <= '1' when (sig_count = n_periods - 1) else
           '0';

end architecture behavioral;