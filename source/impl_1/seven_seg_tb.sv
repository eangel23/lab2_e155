// Emma Angel
// eangel@hmc.edu
// 8/31/2025
// Testbench for seven segment display, reused from lab1
`timescale 1ns/1ps
module seven_seg_testbench();
	logic reset;
	logic clk;
	// inputs, outputs, and expected outputs
	logic [3:0] cur_s;
	logic [6:0] seg;
	logic [6:0] seg_expected;
	logic [31:0] vectornum, errors;
	logic [10:0] testvectors[10000:0];
	
	// Instantiation of top module
	seven_seg dut(
	.cur_s(cur_s),
	.seg(seg)
	);
	
	
	// Generate clock.
	always begin
		clk=1; #5;
		clk=0; #5;
	end
		
	initial begin
			$readmemb("./seven.tv", testvectors); // Read in test vectors
			vectornum=0;
			errors=0;
			reset=0; #22;
			reset=1;
	end
		
	// Apply test vectors on rising edge of clk.
	always @(posedge clk) begin
		#1;
		{cur_s, seg_expected } = testvectors[vectornum];
		end
		
	// Check results on falling edge of clk.
	always @(negedge clk)
		if (reset) begin // active low reset
			if (seg !== seg_expected) begin
				$display("Error: inputs = %b", {seg});
				$display(" outputs = %b(%b expected)", seg, seg_expected);
				// Increment the count of errors.
				errors = errors + 1;
			end
		vectornum = vectornum + 1;
		// Reached end of test vectors
		if (testvectors[vectornum] === 11'bx) begin
			$display("%d tests completed with %d errors", vectornum, errors);
			// Stop the simulation
			$stop;
		end
	end
endmodule
