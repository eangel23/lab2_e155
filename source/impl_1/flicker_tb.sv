// Emma Angel
// eangel@hmc.edu
// 9/6/2025
// Testbench for flicker module
`timescale 1ns/1ps

module flicker_tb;

  // DUT signals
  logic clk;
  logic reset;
  logic anode0, anode1;

  // Instantiate DUT
  flicker dut (
    .clk(clk),
    .reset(reset),
    .anode0(anode0),
    .anode1(anode1)
  );
  // Generate clock signal with a period of 10 timesteps.
  always
	begin
		clk = 1; #5;
		clk = 0; #5;
	end
  

  // Stimulus
  initial begin
    // Apply reset, is my reset active low?
    reset = 0;
    #200;         // hold reset for some cycles
    reset = 1;
  end

  // Monitor outputs
  initial begin
    $display("Time(ns) | Reset | Counter Flip Events | anode0 | anode1");
    $monitor("%8t | %b     | %b | %b     | %b",
              $time, reset, dut.counter, anode0, anode1);
  end

  // Assertions (basic checks)
  always @(posedge clk) begin
    if (reset) begin
      // Check complementary outputs
      if (anode0 === anode1) begin
        $error("Outputs not complementary at time %t", $time);
      end
    end
  end

endmodule
