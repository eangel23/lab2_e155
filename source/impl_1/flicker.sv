// Emma Angel
// eangel@hmc.edu
// 9/5/2025
// This modules takes in a clk and outputs inverse flickering signals at 1000 Hz
module flicker (
	input logic clk,
	input logic reset,
	output logic anode0,
	output logic anode1
	);
	logic [24:0] counter = 0;

	// Clk divider 12MHz -> 1000 Hz for clk, 6000 cycle
   always_ff @(posedge clk) begin
	if(reset == 0) begin
		counter <= 0;
		anode0 <= 0;
		anode1 <= 1;
	end
     else if (counter == 24'd60) begin
		 counter <= 0;
		 anode0 <= ~anode0;
		 anode1 <= ~anode1;
	end
	else begin
		counter <= counter + 1;
	end
  end
endmodule