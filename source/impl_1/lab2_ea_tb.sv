// Emma Angel
// eangel@hmc.edu
// 8/31/2025
// Tesbench for top module lab2_ea
`timescale 1ns/1ps
module top_tb;

  // DUT signals
  logic clk;
  logic reset;
  logic [3:0] s0, s1;
  logic [4:0] led;
  logic [6:0] seg;
  logic anode0, anode1;

  // Instantiate DUT
  top dut (
    .reset(reset),
    .s0(s0),
    .s1(s1),
    .led(led),
    .seg(seg),
    .anode0(anode0),
    .anode1(anode1)
  );
  
  // Expected values
  logic [6:0] seg_expected_s0;
  logic [6:0] seg_expected_s1;
  logic [4:0] led_expected;

  // Seven segment encoding
  always_comb begin
    case (s0)
      4'b0000: seg_expected_s0 = 7'b1000000;
      4'b0001: seg_expected_s0 = 7'b1111001;
      4'b0010: seg_expected_s0 = 7'b0100100;
      4'b0011: seg_expected_s0 = 7'b0110000;
      4'b0100: seg_expected_s0 = 7'b0011001;
      4'b0101: seg_expected_s0 = 7'b0010010;
      4'b0110: seg_expected_s0 = 7'b0000010;
      4'b0111: seg_expected_s0 = 7'b1111000;
      4'b1000: seg_expected_s0 = 7'b0000000;
      4'b1001: seg_expected_s0 = 7'b0010000;
      4'b1010: seg_expected_s0 = 7'b0001000;
      4'b1011: seg_expected_s0 = 7'b0000011;
      4'b1100: seg_expected_s0 = 7'b1000110;
      4'b1101: seg_expected_s0 = 7'b0100001;
      4'b1110: seg_expected_s0 = 7'b0000110;
      4'b1111: seg_expected_s0 = 7'b0001110;
      default: seg_expected_s0 = 7'b1111111;
    endcase
  end

  always_comb begin
    case (s1)
      4'b0000: seg_expected_s1 = 7'b1000000;
      4'b0001: seg_expected_s1 = 7'b1111001;
      4'b0010: seg_expected_s1 = 7'b0100100;
      4'b0011: seg_expected_s1 = 7'b0110000;
      4'b0100: seg_expected_s1 = 7'b0011001;
      4'b0101: seg_expected_s1 = 7'b0010010;
      4'b0110: seg_expected_s1 = 7'b0000010;
      4'b0111: seg_expected_s1 = 7'b1111000;
      4'b1000: seg_expected_s1 = 7'b0000000;
      4'b1001: seg_expected_s1 = 7'b0010000;
      4'b1010: seg_expected_s1 = 7'b0001000;
      4'b1011: seg_expected_s1 = 7'b0000011;
      4'b1100: seg_expected_s1 = 7'b1000110;
      4'b1101: seg_expected_s1 = 7'b0100001;
      4'b1110: seg_expected_s1 = 7'b0000110;
      4'b1111: seg_expected_s1 = 7'b0001110;
      default: seg_expected_s1 = 7'b1111111;
    endcase
  end
  
  
  // Generate clock.
  always begin
	  clk=1; #5;
	  clk=0; #5;
  end
  
  // Stimulus
  initial begin
    reset = 0; #22;
    reset = 1;
	
	// Apply all possible inputs 
	// loop through all 256 cases
	  for (int i = 0; i < 16; i++) begin
		for (int j = 0; j < 16; j++) begin
		  s0 = i;
		  s1 = j;
		  led_expected = i + j;
		  #2000; // let the signal settle
		end
	  end
	  
	/*
    // Apply a few test vectors
    s0 = 4'd3; s1 = 4'd7; #2000;
    s0 = 4'd9; s1 = 4'd5; #2000;
    s0 = 4'd0; s1 = 4'd0; #2000;
	s0 = 4'd8; s1 = 4'd9; #2000;
    s0 = 4'd10; s1 = 4'd5; #2000;
    s0 = 4'd0; s1 = 4'd1; #2000;
	*/
    $display("Simulation complete.");
    $finish;
  end

  // Assertions: check LED sum
  always @(posedge clk) begin #1
    assert (led == led_expected)
      else $error("LED sum mismatch: expected %d  got %d", led_expected, led);
  end

  // Assertions: check 7-seg vs anode
  always @(posedge clk) begin #1
    if (anode0) begin
      assert (seg == seg_expected_s0)
        else $error("7-seg mismatch for s0: expected %b, got %b", seg_expected_s0, seg);
    end
    if (anode1) begin #1
      assert (seg == seg_expected_s1)
        else $error("7-seg mismatch for s1: expected %b, got %b", seg_expected_s1, seg);
    end
  end

endmodule

