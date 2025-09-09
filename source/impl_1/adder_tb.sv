// Emma Angel
// eangel@hmc.edu
// 9/6/2025
// Testbench for adder module
`timescale 1ns/1ps

module adder_tb;

  // Testbench signals
  logic [3:0] s0, s1;
  logic [4:0] led;
  logic [4:0] led_expected;

  // Instantiate DUT
  adder dut (
    .s0(s0),
    .s1(s1),
    .led(led)
  );
  
  initial begin
	  // loop through all 256 cases
	  for (int i = 0; i < 16; i++) begin
		for (int j = 0; j < 16; j++) begin
		  s0 = i;
		  s1 = j;
		  led_expected = i + j;
		  #1; // let the signal settle

		  // check expected
		  assert (led == led_expected)
		  // if not throw an error
		  else $error("Test failed: %0d + %0d != %0d (got %0d)", i, j, led_expected, led);
		end
	  end

	  $display("All %0d test cases passed!", 16*16);
	  $finish;
  end
endmodule
