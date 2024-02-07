-- Ian Korovinsky
-- Steven Yang

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LogicalStep_Lab2_top is port (
   clkin_50			: in	std_logic;
	pb_n			: in	std_logic_vector(3 downto 0);
 	sw   			: in  std_logic_vector(7 downto 0); 		-- The switch inputs
   leds				: out std_logic_vector(7 downto 0); 		-- for displaying the switch content
   seg7_data 		: out std_logic_vector(6 downto 0); 		-- 7-bit outputs to a 7-segment
	seg7_char1  	: out	std_logic;				    		-- seg7 digit1 selector
	seg7_char2  	: out	std_logic				    		-- seg7 digit2 selector
	
); 
end LogicalStep_Lab2_top;

architecture SimpleCircuit of LogicalStep_Lab2_top is
--
-- Components Used ---
------------------------------------------------------------------- 
	
	-- 4 bit adder
	component full_adder_4bit port (

		-- Inputs
		BUS0_b3, BUS1_b3, BUS0_b2, BUS1_b2, BUS0_b1, BUS1_b1, BUS0_b0, BUS1_b0 : in std_logic;
		Carry_In   		: in  std_logic;

		-- Outputs
		Carry_Out3		: out std_logic;
		SUM				: out std_logic_vector(3 downto 0)
	);
	end component;

	-- Seven segment display
	component SevenSegment port (
		hex   		:  in  std_logic_vector(3 downto 0);   -- The 4 bit data to be displayed
		sevenseg 	:  out std_logic_vector(6 downto 0)    -- 7-bit outputs to a 7-segment
		); 
	end component;

	-- Seven segment display multiplexer
	component segment7_mux port (
		clk		: in std_logic := '0';
		DIN2     : in std_logic_vector(6 downto 0);
		DIN1	   : in std_logic_vector(6 downto 0);
		DOUT	   : out std_logic_vector(6 downto 0);
		DIG2	   : out std_logic;
		DIG1	   : out std_logic
	);
	end component;
	
	-- 4 bit inverter
	component PB_Inverters port (
		pb_n : IN std_logic_vector(3 downto 0);
		pb : OUT std_logic_vector(3 downto 0)
	); 
	end component;

	-- Mux for 7 segment display
	component logic_mux port (
		logic_in0, logic_in1 						: in std_logic_vector(3 downto 0);
		logic_select                           : in std_logic_vector(1 downto 0);
		logic_out                              : out std_logic_vector(3 downto 0)
	);
	end component;
	
	-- 2 - 1 Multiplexer
	component logic_mux2 port (
		logic_num0, logic_num1 : in std_logic_vector(3 downto 0);
		logic_select2                             : in std_logic;
		logic_out2                                : out std_logic_vector(3 downto 0)
	);
	end component;
	

	
-- Create any signals, or temporary variables to be used
--
--  std_logic_vector is a signal which can be used for logic operations such as OR, AND, NOT, XOR
--

	-- 7 bit signals
	signal seg7_A		: std_logic_vector(6 downto 0);
	signal seg7_B		: std_logic_vector(6 downto 0);

	-- 4 bit signals
	signal hex_A		: std_logic_vector(3 downto 0);
	signal hex_B      : std_logic_vector(3 downto 0);
	signal pb			: std_logic_vector(3 downto 0);
	signal full_adder_4bit_hex_sum : std_logic_vector(3 downto 0);

	signal carry_out3_remaining : std_logic;
	signal carry_out3_concatenation : std_logic_vector(3 downto 0);
	signal Operand_A : std_logic_vector(3 downto 0);
	signal Operand_B : std_logic_vector(3 downto 0);
	
	
-- Here the circuit begins

begin

	-- Logic for connecting switches to binary operand signals, and defining how components are interconnected.
	-- This includes mapping input switches to operands, connecting full adders, and managing display outputs.

	hex_A <= sw(3 downto 0);
	hex_B <= sw(7 downto 4);
	
	--COMPONENT HOOKUP
	--generate the seven segment coding
	
	carry_out3_concatenation <= "000" & carry_out3_remaining; 
	
	INST0: full_adder_4bit port map (hex_A(3), hex_B(3), hex_A(2), hex_B(2), hex_A(1), hex_B(1), hex_A(0), hex_B(0), '0', carry_out3_remaining, full_adder_4bit_hex_sum);
	INST1: SevenSegment port map(Operand_A, seg7_A);
	INST2: SevenSegment port map(Operand_B, seg7_B);
	INST3: segment7_mux port map(clkin_50, seg7_A, seg7_B, seg7_data, seg7_char2, seg7_char1);
	INST4: PB_Inverters port map(pb_n, pb);
	INST5: logic_mux port map(hex_A, hex_B, pb(1 downto 0), leds(3 downto 0));
	INST6: logic_mux2 port map (hex_B, carry_out3_concatenation, pb(2), Operand_B);
	INST7: logic_mux2 port map (hex_A, full_adder_4bit_hex_sum, pb(2), Operand_A);

end SimpleCircuit;

