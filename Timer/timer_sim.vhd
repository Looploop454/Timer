library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Specify the new library for simulation

entity Timer_Sim is
end entity;

architecture sim of Timer_Sim is

    constant ClockFrequency : integer := 100e6; -- 100MHz
    constant ClockPeriod : time := 1000 ms;

    signal Clk              : std_logic := '1';
    signal nRst             : std_logic := '0';
    signal Hrs              : integer;
    signal Mins             : integer;
    signal Secs             : integer;

    -- Signals for 7-segment displays (6 total: 2 for hours, 2 for minutes, 2 for seconds)
    signal SevenSeg_Hr_Tens : std_logic_vector(6 downto 0);
    signal SevenSeg_Hr_Ones : std_logic_vector(6 downto 0);
    signal SevenSeg_Min_Tens : std_logic_vector(6 downto 0);
    signal SevenSeg_Min_Ones : std_logic_vector(6 downto 0);
    signal SevenSeg_Sec_Tens : std_logic_vector(6 downto 0);
    signal SevenSeg_Sec_Ones : std_logic_vector(6 downto 0);

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

    -- Instance of the Timer
    i_Timer: entity work.Timer(rtl)
        port map(
			 Clk => Clk,
			 nRst => nRst,
			 Hrs => Hrs,				
			 Mins => Mins,
			 Secs => Secs,
			 SevenSeg_Hr_Tens => SevenSeg_Hr_Tens,
			 SevenSeg_Hr_Ones => SevenSeg_Hr_Ones,
			 SevenSeg_Min_Tens => SevenSeg_Min_Tens,
			 SevenSeg_Min_Ones => SevenSeg_Min_Ones,
			 SevenSeg_Sec_Tens => SevenSeg_Sec_Tens,
			 SevenSeg_Sec_Ones => SevenSeg_Sec_Ones
		);


    -- Generate clock signal
    Clk <= not Clk after ClockPeriod / 2;

    -- Break the hours, minutes, and seconds into tens and ones digits
    Hr_Tens  <= Hrs / 10;
    Hr_Ones  <= Hrs mod 10;
    Min_Tens <= Mins / 10;
    Min_Ones <= Mins mod 10;
    Sec_Tens <= Secs / 10;
    Sec_Ones <= Secs mod 10;

    -- Assign 7-segment display outputs using the decoder
    SevenSeg_Hr_Tens <= SevenSegDecoder(Hr_Tens);
    SevenSeg_Hr_Ones <= SevenSegDecoder(Hr_Ones);
    SevenSeg_Min_Tens <= SevenSegDecoder(Min_Tens);
    SevenSeg_Min_Ones <= SevenSegDecoder(Min_Ones);
    SevenSeg_Sec_Tens <= SevenSegDecoder(Sec_Tens);
    SevenSeg_Sec_Ones <= SevenSegDecoder(Sec_Ones);

    -- Simulation process
    process is
    begin
        -- Hold reset low for 5 clock cycles to ensure proper reset
		wait until rising_edge(Clk);
		wait until rising_edge(Clk);
		
		nRst <= '1';  -- Release reset

        
        -- Simulate for a few seconds
        wait for 1000000 sec;
        
        -- End the simulation
        wait;
    end process;

end architecture;