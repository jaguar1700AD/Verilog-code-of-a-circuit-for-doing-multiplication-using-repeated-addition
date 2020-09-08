module test_bench;
	reg [15:0] data_in;
	reg start, clk;
	wire done;

	wire ldA, ldB, ldP, clrP, decB, eqZ;
	controller controlP(start, done, ldA, ldB, ldP, clrP, decB, eqZ, clk);
	data_path dataP(ldA, ldB, ldP, clrP, decB, eqZ, data_in, clk);

	initial
	begin
		data_in = 16'd0; start = 0; clk = 0;
		#2 start = 1;
		# 100 $finish;
	end

	always #5 clk = ~clk;

	initial
	begin
		#17 data_in = 17;
		#10 data_in = 5;
	end

	initial
	begin
		$monitor($time, " %d, %b", dataP.Y, done);
		$dumpfile("mul.vcd"); 
		$dumpvars(0, test_bench);
	end

endmodule