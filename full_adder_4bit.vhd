-- Members: Ian Korovinsky and Steven Yang
-- Import packages
library ieee;
use ieee.std_logic_1164.all;

-- Define full adder (4 bit) entity
entity full_adder_4bit is port (
   BUS0_b3, BUS1_b3, BUS0_b2, BUS1_b2, BUS0_b1, BUS1_b1, BUS0_b0, BUS1_b0 : in std_logic; -- Input bits for 2-1 muxs
 	Carry_In   		: in  std_logic; -- Input carry bit for first 2-1 mux
	Carry_Out3		: out std_logic; -- Output carry out bit (MSB) for last 2-1 mux
	SUM				: out std_logic_vector(3 downto 0) -- Output sum bits from all four 2-1 muxs, stored in a 4-bit vector
   
	
); 
end full_adder_4bit;

-- Define logic and structure for full adder (4 bit)
architecture full_adder_4bit_logic of full_adder_4bit is
	
	-- Define full adder (1 bit) component
	component full_adder_1bit port (
		INPUT_A, INPUT_B 						: in std_logic; -- Input mux bits
		CARRY_IN                         : in std_logic; -- Input carry bit
		FULL_ADDER_CARRY_OUTPUT          : out std_logic; -- Output carry bit
		FULL_ADDER_SUM_OUTPUT            : out std_logic -- Output sum bit
	);
	end component;

	-- Define intermediate signals to store carry out bits between daisy-chained 2-1 muxs 	
	signal Carry_Out0	: std_logic;
	signal Carry_Out1	: std_logic;
	signal Carry_Out2	: std_logic;

-- Defines logic
begin
	
	-- Instantiate 4 1-bit full adders, storing intermediary carry outs in instantiated signals and sums outputs in sum vector
	INST1: full_adder_1bit port map(BUS1_b0, BUS0_b0, Carry_In, Carry_Out0, SUM(0));
	INST2: full_adder_1bit port map(BUS1_b1, BUS0_b1, Carry_Out0, Carry_Out1, SUM(1));
	INST3: full_adder_1bit port map(BUS1_b2, BUS0_b2, Carry_Out1, Carry_Out2, SUM(2));
	INST4: full_adder_1bit port map(BUS1_b3, BUS0_b3, Carry_Out2, Carry_Out3, SUM(3));

	
end full_adder_4bit_logic;


