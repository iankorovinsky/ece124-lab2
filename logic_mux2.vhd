library ieee;
use ieee.std_logic_1164.all;

-- 2 - 1 multiplexer
entity logic_mux2 is
port (
	logic_num0, logic_num1 : in std_logic_vector(3 downto 0);
	logic_select2                             : in std_logic;
   logic_out2                                : out std_logic_vector(3 downto 0)
);
end logic_mux2;

architecture mux_logic of logic_mux2 is

begin
	-- mux logic
	with logic_select2 select
	logic_out2 <= logic_num0 when '0',
				  logic_num1 when '1';

end mux_logic;