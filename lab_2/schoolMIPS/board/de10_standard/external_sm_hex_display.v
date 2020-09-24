module external_sm_hex_display
(
	input [3:0] digit_in_1,
	input [3:0] digit_in_2,
	input [3:0] digit_in_3,
	
	input clkIn, // wire to CLOCK_50
	
	output [11:0] seven_segments
);
	
	wire [7:0] digit1, digit2, digit3;
	
	sm_hex_display_our digit_00 (digit_in_1, digit1);
	sm_hex_display_our digit_01 (digit_in_2, digit2);
	sm_hex_display_our digit_02 (digit_in_3, digit3);
	
	sm_hex_display_digit sm_hex_display_digit
	(
		.digit1(digit1),
		.digit2(digit2),
		.digit3(digit3),
		.clkIn(ClkIn),
		.seven_segments(seven_segments)
	);
	
endmodule
