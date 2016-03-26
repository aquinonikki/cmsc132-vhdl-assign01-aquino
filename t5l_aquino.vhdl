-- File name: t5l_aquino.vhdl

-- Library Statements
library IEEE; use IEEE.std_logic_1164.all;

--Entity Definition
entity t5l_aquino is
	port(alarm: out std_logic;
	i: in std_logic_vector(2 downto 0); --in_buzzer 
	o: in std_logic_vector(2 downto 0)); --out_buzzer
end entity t5l_aquino; 

-- 0: boggis
-- 1: bunce
-- 2: bean

-- Architecture Definition
architecture buzzer of t5l_aquino is

begin
	process (i(2), i(1), i(0), o(2), o(1), o(0)) is -- activate when any input changes
	
	begin
		if((i(2) = '0') and (i(1) = '0') and (i(0) = '0') and (o(2) = '0') and (o(1) = '0') and (o(0) = '0'))
			then alarm <= '0';
		else alarm <= '1';
		end if; 
		
	end process;
end architecture buzzer;
