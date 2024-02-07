-- Members: Ian Korovinsky and Steven Yang
-- Import packages
library ieee;
use ieee.std_logic_1164.all;

-- Define full adder (1 bit) entity
entity full_adder_1bit is
port (
	INPUT_A, INPUT_B 						: in std_logic; -- Input bits A and B
	CARRY_IN                         : in std_logic; -- Input carry bit
	FULL_ADDER_CARRY_OUTPUT          : out std_logic; -- Output carry bit
	FULL_ADDER_SUM_OUTPUT            : out std_logic -- Output sum bit
);
end full_adder_1bit;


-- Define logic for full adder (1 bit)
architecture mux_logic of full_adder_1bit is

begin
	-- Compute carry output and assign
	FULL_ADDER_CARRY_OUTPUT <= (INPUT_A AND INPUT_B) OR (CARRY_IN AND (INPUT_A XOR INPUT_B));

	-- Comput sum output and assign
	FULL_ADDER_SUM_OUTPUT <= (INPUT_A XOR INPUT_B) XOR CARRY_IN;
	
end mux_logic;