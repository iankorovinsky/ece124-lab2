LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY PB_Inverters IS
	PORT
	(
		pb_n : IN std_logic_vector(3 downto 0); -- input
		pb : OUT std_logic_vector(3 downto 0) -- output
	);
END PB_Inverters;

ARCHITECTURE gates of PB_Inverters IS

BEGIN
-- The output vector 'pb' is assigned the bitwise not of input vector 'pb_n'.
pb <= not(pb_n);

END gates;