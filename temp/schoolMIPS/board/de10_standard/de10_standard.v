module de10_standard
(
    input                       CLOCK2_50,
    input                       CLOCK3_50,
    input                       CLOCK4_50,
    input                       CLOCK_50,

    input            [3:0]      KEY,

    input            [9:0]      SW,

    output           [9:0]      LEDR,

    output           [6:0]      HEX0,
    output           [6:0]      HEX1,
    output           [6:0]      HEX2,
    output           [6:0]      HEX3,
    output           [6:0]      HEX4,
    output           [6:0]      HEX5,
	
	inout [35:0] GPIO
);

    // wires & inputs
    wire          clk;
    wire          clkIn     =  CLOCK_50;
    wire          rst_n     =  KEY[0];
    wire          clkEnable =  SW [9] | ~KEY[1];
    wire [  3:0 ] clkDevide =  SW [8:5];
    wire [  4:0 ] regAddr   =  SW [4:0];
    wire [ 31:0 ] regData;
	
	// DIP-switch
	wire [7:0] dip_sw = GPIO [35:28];

    //cores
    sm_top sm_top
    (
        .clkIn      ( clkIn     ),
        .rst_n      ( rst_n     ),
        .clkDevide  ( clkDevide ),
        .clkEnable  ( clkEnable ),
        .clk        ( clk       ),
        .regAddr    ( regAddr   ),
        .regData    ( regData   ),
		.dip_sw		( dip_sw	)
    );

    //outputs
    assign LEDR[0]   = clk;
    assign LEDR[9:1] = regData[8:0];

    wire [ 31:0 ] h7segment = regData;

    sm_hex_display digit_5 ( h7segment [23:20] , HEX5 [6:0] );
    sm_hex_display digit_4 ( h7segment [19:16] , HEX4 [6:0] );
    sm_hex_display digit_3 ( h7segment [15:12] , HEX3 [6:0] );
    sm_hex_display digit_2 ( h7segment [11: 8] , HEX2 [6:0] );
    sm_hex_display digit_1 ( h7segment [ 7: 4] , HEX1 [6:0] );
    sm_hex_display digit_0 ( h7segment [ 3: 0] , HEX0 [6:0] );
    
    external_sm_hex_display external_sm_hex_display
	(
		.digit_in_1(h7segment[3:0]),
		.digit_in_2(h7segment[7:4]),
		.digit_in_3(h7segment[11:8]),
		.clkIn(clkIn),
		.seven_segments(GPIO[11:0])
	);
	
endmodule
