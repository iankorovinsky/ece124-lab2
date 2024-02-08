-- Members: Ian Korovinsky and Steven Yang
-- Import packages
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Define top file inputs and outputs
entity LogicalStep_Lab2_top is port (
   clkin_50			: in	std_logic; -- Input, clock-type
	pb_n			: in	std_logic_vector(3 downto 0); -- Input, buttons
 	sw   			: in  std_logic_vector(7 downto 0); 		-- Input, switches
   leds				: out std_logic_vector(7 downto 0); 		-- Inputs, leds that go on/off depending on the switch content
   seg7_data 		: out std_logic_vector(6 downto 0); 		-- Output, 7 bit vector for segment displays
	seg7_char1  	: out	std_logic;				    		-- Output, 1 bit logic value for digit 1
	seg7_char2  	: out	std_logic				    		-- Output, 1 bit logic value for digit 2
	
); 
end LogicalStep_Lab2_top;

architecture SimpleCircuit of LogicalStep_Lab2_top is
--
-- Components Used ---
------------------------------------------------------------------- 
	
	-- 4 bit adder component
	component full_adder_4bit port (

		-- Inputs
		BUS0_b3, BUS1_b3, BUS0_b2, BUS1_b2, BUS0_b1, BUS1_b1, BUS0_b0, BUS1_b0 : in std_logic; -- Input bits
		Carry_In   		: in  std_logic; -- Input carry bit

		-- Outputs
		Carry_Out3		: out std_logic; -- Output carry out bit (MSB)
		SUM				: out std_logic_vector(3 downto 0) -- Output sum bits stored in a 4-bit vector
	);
	end component;

	-- Seven segment display component
	component SevenSegment port (
		hex   		:  in  std_logic_vector(3 downto 0);   -- Input, the 4 bit data to be displayed
		sevenseg 	:  out std_logic_vector(6 downto 0)    -- Output, 7-bit outputs to a 7-segment
		); 
	end component;

	-- Seven segment display multiplexer component
	component segment7_mux port (
		clk		: in std_logic := '0'; -- Input, clock-style
		DIN2     : in std_logic_vector(6 downto 0); -- Input, 7 bit vector
		DIN1	   : in std_logic_vector(6 downto 0);  -- Input, 7 bit vector
		DOUT	   : out std_logic_vector(6 downto 0);  -- Output, 7 bit vector
		DIG2	   : out std_logic;  -- Output, 1 bit relating to digit 2
		DIG1	   : out std_logic   -- Output, 1 bit relating to digit 1
	);
	end component;
	
	-- 4 bit inverter component
	component PB_Inverters port (
		pb_n : IN std_logic_vector(3 downto 0); -- Input 4 bit button vector
		pb : OUT std_logic_vector(3 downto 0) -- Output 4 bit vector corresponding to inverted buttons
	); 
	end component;

	-- Mux for 7 segment display component
	component logic_mux port (
		logic_in0, logic_in1 						: in std_logic_vector(3 downto 0); -- Input 4 bit vectors
		logic_select                           : in std_logic_vector(1 downto 0); -- Input 2 bit selector
		logic_out                              : out std_logic_vector(3 downto 0) -- Output 4 bit vector 
	);
	end component;
	
	-- 2 to 1 Multiplexer component
	component logic_mux2 port (
		logic_num0, logic_num1 : in std_logic_vector(3 downto 0); -- Input 4 bit vector
		logic_select2                             : in std_logic; -- Input selector bit
		logic_out2                                : out std_logic_vector(3 downto 0) -- Output 4 bit vector
	);
	end component;
	

	
	-- Define intermediate signals to store temporary values in circuit

	-- 7 bit signals for seg7 display
	signal seg7_A		: std_logic_vector(6 downto 0);
	signal seg7_B		: std_logic_vector(6 downto 0);

	-- 4 bit signals for hexadecimals, buttons, and full adder (4 bit) hex sum
	signal hex_A		: std_logic_vector(3 downto 0);
	signal hex_B      : std_logic_vector(3 downto 0);
	signal pb			: std_logic_vector(3 downto 0);
	signal full_adder_4bit_hex_sum : std_logic_vector(3 downto 0);

	signal carry_out3_remaining : std_logic; -- Carry out after last daisy-chained 2-to-1 mux
	signal carry_out3_concatenation : std_logic_vector(3 downto 0); -- Concatenated value of previous variable
	signal Operand_A : std_logic_vector(3 downto 0); -- Connected to ALU over hex_A
	signal Operand_B : std_logic_vector(3 downto 0); -- Connected to ALU over hex_B
	
	
-- Define logic for circuit

begin

	-- Logic for connecting switches to binary operand signals, and defining how components are interconnected
	-- This includes mapping input switches to operands, connecting full adders, and managing display outputs

	-- maps out switch inputs 
	hex_A <= sw(3 downto 0);
	hex_B <= sw(7 downto 4);
		
	-- carry concatenation
	carry_out3_concatenation <= "000" & carry_out3_remaining; 
	
	-- 4 bit adder that takes in switch inputs and outputs the sum and carry out
	INST0: full_adder_4bit port map (hex_A(3), hex_B(3), hex_A(2), hex_B(2), hex_A(1), hex_B(1), hex_A(0), hex_B(0), '0', carry_out3_remaining, full_adder_4bit_hex_sum);
	
	-- decoders for the digit data
	INST1: SevenSegment port map(Operand_A, seg7_A);
	INST2: SevenSegment port map(Operand_B, seg7_B);

	-- 7 segment display multiplexer logic for displaying accurate digits
	INST3: segment7_mux port map(clkin_50, seg7_A, seg7_B, seg7_data, seg7_char2, seg7_char1);

	-- Inverter for buttons
	INST4: PB_Inverters port map(pb_n, pb);

	-- Multiplexers for computing button press logic
	INST5: logic_mux port map(hex_A, hex_B, pb(1 downto 0), leds(3 downto 0));
	INST6: logic_mux2 port map (hex_B, carry_out3_concatenation, pb(2), Operand_B);
	INST7: logic_mux2 port map (hex_A, full_adder_4bit_hex_sum, pb(2), Operand_A);

end SimpleCircuit;

