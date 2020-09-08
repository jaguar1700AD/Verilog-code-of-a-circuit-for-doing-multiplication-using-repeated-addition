module data_path(ldA, ldB, ldP, clrP, decB, eqZ, data_in, clk);
	input ldA, ldB, ldP, clrP, decB;
	input [15:0] data_in;
	input clk;
	output eqZ;

	wire [15:0] X, Y, Z, Bout, Bus;

	assign Bus = data_in;

	PIPO1 reg_A (ldA, Bus, X, clk);
	PIPO2 reg_P (ldP, clrP, Z, Y, clk);
	ADDER Ad (X, Y, Z);
	PIPO3 reg_B (ldB, decB, Bus, Bout, clk);
	COMP comp_B (Bout, eqZ); 
endmodule

module PIPO1 (ldA, Bus, X, clk);
	input ldA, clk;
	input [15:0] Bus;
	output reg [15:0] X;

	always @(posedge clk)
	begin
		if (ldA) X <= Bus;
	end
endmodule 

module PIPO2 (ldP, clrP, Z, Y, clk);
	input ldP, clrP, clk;
	input [15:0] Z;
	output reg [15:0] Y;

	always @(posedge clk)
	begin
		if (clrP) Y <= 16'b0;
		else if (ldP) Y <= Z;
	end
endmodule 

module PIPO3 (ldB, decB, Bus, Bout, clk);
	input ldB, decB, clk;
	input [15:0] Bus;
	output reg [15:0] Bout;

	always @(posedge clk)
	begin
		if (ldB) Bout <= Bus;
		else if (decB) Bout <= Bout - 1;
	end
endmodule 

module ADDER (X, Y, Z);
	input [15:0] X, Y;
	output [15:0] Z;
	assign Z = X + Y;
endmodule

module COMP (Bout, eqZ);
	input [15:0] Bout;
	output eqZ;
	assign eqZ = (Bout == 1);
endmodule



