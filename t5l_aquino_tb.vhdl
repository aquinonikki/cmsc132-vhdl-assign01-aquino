-- File name: t5l_aquino_tb.vhdl

-- Library Statements
library IEEE; use IEEE.std_logic_1164.all;
use iEEE.numeric_std.all;

--Entity Definition
entity t5l_aquino_tb is -- constants are defined here
	constant MAX_COMB: integer := 64;
	constant DELAY: time := 10 ns; -- delay value in testing
end entity t5l_aquino_tb;

architecture tb of t5l_aquino_tb is
	signal alarm: std_logic; -- valid dataindicator from the UUT
	signal i: std_logic_vector(2 downto 0); -- inputs to UUT
	signal o: std_logic_vector(2 downto 0); -- inputs to UUT
	
	-- Component declaration
	component t5l_aquino is
		port(alarm: out std_logic; -- true if >= 1 asserted
		i: in std_logic_vector(2 downto 0);
		o: in std_logic_vector(2 downto 0)); -- ix (0 <= x <= 3) indicates decimal value x;
	end component t5l_aquino;
	
begin -- begin main body of the tb architecture
	-- instantiate the unit under test
	UUt: component t5l_aquino port map (alarm, i, o);
	
	--main process: generate test vectors and check results
	main: process is
		variable temp: unsigned(5 downto 0); 
		variable expected_alarm: std_logic;
		variable error_count: integer := 0; -- number of simulation errors
		
	begin
		report "Start simulation";
		
		-- generate all possible input values, since max = 15
		for x in 0 to 63 loop
			temp := TO_UNSIGNED(x, 6);
				i(0) <= std_logic(temp(5));
				i(1) <= std_logic(temp(4));
				i(2) <= std_logic(temp(3));
				o(0) <= std_logic(temp(2));
				o(1) <= std_logic(temp(1));
				o(2) <= std_logic(temp(0));
				
				--compute expected values
				
			if((temp(5)='0') and (temp(4)='0') and (temp(3)='0') and (temp(2)='0') and (temp(1)='0') and (temp(0)='0'))
				then expected_alarm := '0';
			else
				expected_alarm := '1';
			end if; 
				
			
			wait for DELAY; -- wait, and then compare with UUT outputs
			
			-- check if output of circuit is the same as the expected value
			assert (expected_alarm = alarm)
					report "ERROR: Expected alarm " &
						std_logic'image(expected_alarm) &
						" at time " & time'image(now);
			
			-- increment number of errors
			if(expected_alarm/=alarm) then
				error_count := error_count + 1;
			end if;
		end loop;
		
		wait for DELAY;
		
		-- report errors
		assert (error_count=0)
			report "ERROR: There were " &
				integer'image(error_count) & " errors!";
				
		-- there are no errors
		if(error_count = 0) then
			report "Simulation completed with NO errors.";
		end if;
		
		wait; -- terminate the simulation
	end process;
end architecture tb;
				
