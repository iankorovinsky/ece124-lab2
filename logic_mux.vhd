-- Members: Ian Korovinsky and Steven Yang | Lab2_REPORT | LS206 | Group 17
-- Import packages
library ieee;
use ieee.std_logic_1164.all;

-- Define logic mux entity
entity logic_mux is
port (
	logic_in0, logic_in1 				   : in std_logic_vector(3 downto 0); -- Input 4 bit vectors
	logic_select                           : in std_logic_vector(1 downto 0); -- Input 2 bit selector
	logic_out                              : out std_logic_vector(3 downto 0) -- Output 4 bit vector 
);
end logic_mux;


-- Define logic for mux - mux is used for leds
architecture mux_logic of logic_mux is

begin

	-- Multiplexer logic based on the selector, performing logical operations based on which buttons are pressed down
	with logic_select(1 downto 0) select
	logic_out <= logic_in0 AND logic_in1 when "00",
				  logic_in0 OR logic_in1 when "01",
				  logic_in0 XOR logic_in1 when "10",
				  logic_in0 XNOR logic_in1 when "11";

end mux_logic;