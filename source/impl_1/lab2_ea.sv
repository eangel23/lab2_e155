// Emma Angel
// eangel@hmc.edu
// 9/8/2025
// Top level module to drive two seven segment displays using the same seven segment module
// Also outputs the sum of the two digits displayed on 5 LEDs 
module top (
	input logic reset, // do i really need a reset
	input logic [3:0] s0,
	input logic [3:0] s1,
	output logic [4:0] led,
	output logic [6:0] seg,
	output logic anode0,
	output logic anode1
	);
	// Define internal variables
	logic clk;
	logic [3:0] cur_s; // Current s value being displayed
	// Internal high-speed oscillator 12 MHz
	HSOSC #(.CLKHF_DIV(2'b10))
	hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(clk));
	
	// Mux for switching
	// if anode 0 is on then you should take in the value for display 0 (s0), else take on the value of display 1 (s1)
	always_comb // does this need to be in an always comb, why would it need to be in an always_comb
		cur_s = anode0 ? s0 : s1;
		
	// declare submodules
	flicker flicker(clk, reset, anode0, anode1);
	adder adder(s0, s1, led);
	// 7 segment module
	seven_seg seven_seg(cur_s,seg);
 
endmodule
