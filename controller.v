module controller (start, done, ldA, ldB, ldP, clrP, decB, eqZ, clk);
	input start, eqZ, clk;
	output done, ldA, ldB, ldP, clrP, decB;

	reg [2:0] state;
	parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100;

	always @(posedge clk)
	begin
		case (state)
			S0: if (start) state <= S1;
			S1: state <= S2;
			S2: state <= S3;
			S3: if (eqZ) state <= S4; 
			S4: state <= S4;
		endcase
	end

	always @(state)
	begin
		case (state)
			S0: begin done = 0; ldA = 0; ldB = 0; ldP = 0; clrP = 0; decB = 0; end
			S1: begin ldA = 1; end
			S2: begin ldA = 0; ldB = 1; clrP = 1; end
			S3: begin ldB = 0; clrP = 0; ldP = 1; decB = 1; end
			S4: begin ldP = 0; decB = 0; end
		endcase
	end

endmodule 