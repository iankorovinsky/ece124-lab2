-- Members: Ian Korovinsky and Steven Yang
-- Import packages
library ieee;
use ieee.std_logic_1164.all;

-- Define 2 - 1 multiplexer entity
entity logic_mux2 is
port (
	logic_num0, logic_num1 					: in std_logic_vector(3 downto 0); -- Input 4 bit vector
	logic_select2                           : in std_logic; -- Input selector bit
   logic_out2                               : out std_logic_vector(3 downto 0) -- Output 4 bit vector
);
end logic_mux2;

-- Define logic for 2-1 mux - mux is used for adding/not-adding hex values
architecture mux_logic of logic_mux2 is

begin
	-- Multiplexer logic based on the selector, depending on whether button is pressed down or not
	with logic_select2 select
	logic_out2 <= logic_num0 when '0',
				  logic_num1 when '1';

end mux_logic;