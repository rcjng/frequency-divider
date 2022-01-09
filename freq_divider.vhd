-- =============================================================================================================
--   Name                           :| Ver  :| Author					:| Last Mod. Date 	:| Changes Made:
--   Adjustable Frequency Divider   :| V1.0 :| Robert Jiang			    :| 12/02/2021		:| Added VHDL file
-- =============================================================================================================
--   Description
--   Divides a clock signal by N using a counter where N is defaulted to 2 and can be specified by the user
-- =============================================================================================================

-- library declarations
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- entity implementation
entity freq_divider is 
    
    generic (
        N : positive := 2);

    port (
        CLK_IN : in std_logic;
        CLK_OUT : out std_logic);

end freq_divider;

-- architecture implementation
architecture freq_divider_arch of freq_divider is

    signal next_count, count : integer := 0;
    signal CLK_INT : std_logic := '0';

begin

    CLK_OUT <= CLK_INT;
    
    -- sequential logic : stores counter and flips clock every N clock cycles
    seq : process (CLK_IN) is
    begin

        if (rising_edge(CLK_IN)) then
            
            count <= next_count;

            if (next_count = 0) then
                CLK_INT <= NOT(CLK_INT);
            end if;

        end if;

    end process seq;

    -- combinational logic : increments counter
    comb : process (count) is
    begin

        next_count <= (count + 1) mod N;
        
    end process comb;

end freq_divider_arch;