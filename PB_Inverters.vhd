-- Members: Ian Korovinsky and Steven Yang
-- Import packages
LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- Define PB Inverters entity
ENTITY PB_Inverters IS
	PORT
	(
		pb_n : IN std_logic_vector(3 downto 0); -- Input 4 bit button vector
		pb : OUT std_logic_vector(3 downto 0) -- Output 4 bit vector corresponding to inverted buttons
	);
END PB_Inverters;


-- Define logic of PB inverters
ARCHITECTURE gates of PB_Inverters IS

BEGIN

-- The output vector 'pb' is assigned the bitwise not of input vector 'pb_n', (0 becomes 1, 1 becomes 0)
pb <= not(pb_n);

END gates;