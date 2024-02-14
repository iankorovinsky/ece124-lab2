-- Members: Ian Korovinsky and Steven Yang | Lab2_REPORT | LS206 | Group 17
-- Import packages
library ieee;
use ieee.std_logic_1164.all;

-- Define hex mux entity
entity hex_mux is
port (
	hex_num3, hex_num2, hex_num1, hex_num0 : in std_logic_vector(3 downto 0); -- Input 4-bit hexs
	mux_select                             : in std_logic_vector(1 downto 0); -- Output 2-bit selector
	hex_out                                : out std_logic_vector(3 downto 0) -- Output 4-bit hex 
);
end hex_mux;


-- Define logic for hex mux
architecture mux_logic of hex_mux is

begin

	-- Multiplexer logic based on the selector
	with mux_select(1 downto 0) select
	hex_out <= hex_num0 when "00",
				  hex_num1 when "01",
				  hex_num2 when "10",
				  hex_num3 when "11";

end mux_logic;