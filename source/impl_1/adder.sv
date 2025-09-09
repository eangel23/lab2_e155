// Emma Angel
// eangel@hmc.edu
// 9/5/2025
// This modules takes in two 4 bit binary numbers and outputs the 5 bit sum to be dsiplayed with led
module adder (
	input logic [3:0] s0,
	input logic [3:0] s1,
	output logic [4:0] led
	);
	
	assign led = s0 + s1;
 
endmodule