library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Timer is
    generic (
        ClockFrequency : integer := 50000000 -- Clock Frequency in Hz (e.g., 100 MHz)
    );
    port (
        Clk     : in  std_logic;                  -- Clock signal
        nRst    : in  std_logic;                  -- Active-low reset signal
        Hrs     : out integer;                    -- Output for Hours
        Mins    : out integer;                    -- Output for Minutes
        Secs    : out integer;                    -- Output for Seconds
        SevenSeg_Hr_Tens : out std_logic_vector(6 downto 0); -- Display hours tens
        SevenSeg_Hr_Ones : out std_logic_vector(6 downto 0); -- Display hours ones
        SevenSeg_Min_Tens : out std_logic_vector(6 downto 0); -- Display minutes tens
        SevenSeg_Min_Ones : out std_logic_vector(6 downto 0); -- Display minutes ones
        SevenSeg_Sec_Tens : out std_logic_vector(6 downto 0); -- Display seconds tens
        SevenSeg_Sec_Ones : out std_logic_vector(6 downto 0)  -- Display seconds ones
    );
end entity;

architecture rtl of Timer is
    signal Ticks_Internal : integer := 0;
    signal Secs_Internal  : integer := 0;
    signal Mins_Internal  : integer := 0;
    signal Hrs_Internal   : integer := 0;

    signal Hr_Tens  : integer;
    signal Hr_Ones  : integer;
    signal Min_Tens : integer;
    signal Min_Ones : integer;
    signal Sec_Tens : integer;
    signal Sec_Ones : integer;
    
    -- Function to convert a digit (0-9) to 7-segment display encoding
    function SevenSegDecoder (digit : integer) return std_logic_vector is
    begin
        case digit is
            when 0 => return not "0111111";  -- '0'
            when 1 => return not "0000110";  -- '1'
            when 2 => return not "1011011";  -- '2'
            when 3 => return not "1001111";  -- '3'
            when 4 => return not "1100110";  -- '4'
            when 5 => return not "1101101";  -- '5'
            when 6 => return not "1111101";  -- '6'
            when 7 => return not "0000111";  -- '7'
            when 8 => return not "1111111";  -- '8'
            when 9 => return not "1101111";  -- '9'
            when others => return not "0000000";  -- Default: all segments off
        end case;
    end function;

begin

    -- Assign internal signals to output ports
    Hrs <= Hrs_Internal;
    Mins <= Mins_Internal;
    Secs <= Secs_Internal;

    -- Break the hours, minutes, and seconds into tens and ones digits
    Hr_Tens  <= Hrs_Internal / 10;
    Hr_Ones  <= Hrs_Internal mod 10;
    Min_Tens <= Mins_Internal / 10;
    Min_Ones <= Mins_Internal mod 10;
    Sec_Tens <= Secs_Internal / 10;
    Sec_Ones <= Secs_Internal mod 10;

    -- Assign 7-segment display outputs using the decoder
    SevenSeg_Hr_Tens <= SevenSegDecoder(Hr_Tens);
    SevenSeg_Hr_Ones <= SevenSegDecoder(Hr_Ones);
    SevenSeg_Min_Tens <= SevenSegDecoder(Min_Tens);
    SevenSeg_Min_Ones <= SevenSegDecoder(Min_Ones);
    SevenSeg_Sec_Tens <= SevenSegDecoder(Sec_Tens);
    SevenSeg_Sec_Ones <= SevenSegDecoder(Sec_Ones);

    -- Process to increment hours, minutes, and seconds
    process (Clk)
    begin
        if rising_edge(Clk) then
            if nRst = '0' then
                -- Reset the counter and time values
                Ticks_Internal   <= 0;
                Secs_Internal    <= 0;
                Mins_Internal    <= 0;
                Hrs_Internal     <= 0;

            else
                if Ticks_Internal = ClockFrequency - 1 then
                    -- One second has passed
                    Ticks_Internal <= 0;
                    
                    -- Increment seconds
                    if Secs_Internal = 59 then
                        Secs_Internal <= 0;
                        
                        -- Increment minutes
                        if Mins_Internal = 59 then
                            Mins_Internal <= 0;
                            
                            -- Increment hours
                            if Hrs_Internal = 23 then
                                Hrs_Internal <= 0;
                            else
                                Hrs_Internal <= Hrs_Internal + 1;
                            end if;
                            
                        else
                            Mins_Internal <= Mins_Internal + 1;
                        end if;
                        
                    else
                        Secs_Internal <= Secs_Internal + 1;
                    end if;
                    
                else
                    Ticks_Internal <= Ticks_Internal + 1;
                end if;
            end if;
        end if;
    end process;

end architecture;
