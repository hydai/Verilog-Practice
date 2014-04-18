module ADD_SUB(A, B, value_result_tens, value_result_units, sign_result, KEY_IN, clk, reset_n, operator);
	output [3:0] value_result_tens;
	output [3:0] value_result_units;
	output [3:0] A;
	output [3:0] B;
	output sign_result;
	input [1:0] operator;
	input [3:0] KEY_IN;
	input reset_n;
	input clk;
	/*
	reg [3:0] A, B, value_result_tens, value_result_units;
	reg sign_result;
	
	wire [3:0] next_A, next_B, next_ten, next_unit, next_In;
	wire next_sign;
	*/
	
	reg [3:0] next_A, next_B, next_ten, next_unit;
	reg slt;
	reg next_sign;
	reg tmpIn;
	
	// add your design here
	always @(posedge clk) begin
		if (!reset_n) begin
			next_A <= 0;
			next_B <= 0;
			next_ten <= 0;
			next_unit <= 0;
			next_sign <= 0;
			slt <= 0;
		end else begin
			if (KEY_IN == 4'hA) begin
				slt <= 0;
			end else if (KEY_IN == 4'hB) begin
				slt <= 1;
			end else begin
				if (slt == 0) begin
					next_A <= KEY_IN;
				end else begin
					next_B <= KEY_IN;
				end
			end
			if (operator[0] == 0) begin
				if (A+B >= 10) begin
					next_ten <= 1;
					next_unit <= A + B - 10;
				end else begin
					next_ten <= 0;
					next_unit <= A + B;
				end
				next_sign <= 0;
			end else if (operator[1] == 0) begin
				if (A > B || A == B) begin
					{next_ten, next_unit} <= A - B;
					next_sign <= 0;
				end else begin
					{next_ten, next_unit} <= B - A;
					next_sign <= 1;
				end
			end else begin
				{next_ten, next_unit} <= {next_ten, next_unit};
			end
		end
	end
	assign A = next_A;
	assign B = next_B;
	assign value_result_tens = next_ten;
	assign value_result_units = next_unit;
	assign sign_result = next_sign;
	/*
	always @(posedge clk) begin
		if (!reset_n) begin
			A <= 0;
			B <= 0;
			value_result_tens <= 0;
			value_result_units <= 0;
			sign_result <= 0;
			tmpIn <= 0;
		end else begin
			A <= next_A;
			B <= next_B;
			value_result_tens <= next_ten;
			value_result_units <= next_unit;
			sign_result <= next_sign;
			tmpIn <= next_In;
		end
	end
	*/
	/*
	assign next_In = (!reset_n)?(0):(KEY_IN);
	assign next_A = (!reset_n)?
							(0): 	// !reset_n
							(		// reset_n
								(tmpIn == 4'hA)?
									(KEY_IN): 		// tmpIn == 4'hA
									(A)				// tmpIn != 4'hA
							);
	assign next_B = (!reset_n)?
							(0): 	// !reset_n
							(		// reset_n
								(tmpIn == 4'hB)?
									(KEY_IN): 		// tmpIn == 4'hB
									(B)				// tmpIn != 4'hB
							);
	
	assign {next_ten, next_unit} = (!reset_n)?
												(0):	// !reset_n
												(		// reset_n
													(operator[0] == 0)?
														(		// add
															A + B
														):
														(		// do not add
															(operator[1] == 0)?
																(		// sub
																	(A >= B)?
																		(		// A >= B
																			A - B
																		):
																		(		// A < B
																			B - A
																		)
																):
																(		// do not add and sub
																	{value_result_tens, value_result_units}
																)
														)
												);
	assign next_sign = (!reset_n)?
								(0):	// !reset_n
								(		// reset_n
									(operator[0] == 0)?
										(		// add
											0
										):
										(		// do not add
											(operator[1] == 0)?
												(		// sub
													(A >= B)?
														(		// A >= B
															0
														):
														(		// A < B
															1
														)
												):
												(		// do not add and sub
													sign_result
												)
										)
								);
								*/
								
	/*
	if (!reset_n) begin
		assign next_A = 0;
		assign next_B = 0;
		assign next_ten = 0;
		assign next_unit = 0;
		assign next_sign = 0;
		assign next_In = 0;
	end else begin
		assign next_In = KEY_IN;
		if (tmpIn == 4'hA) begin
			assign next_A = KEY_IN;
			assign next_B = B;
		end else if (tmpIn == 4'hB) begin
			assign next_A = A;
			assign next_B = KEY_IN;
		end else begin
			assign next_A = A;
			assign next_B = B;
		end
		
		if (operator[0] == 0) begin
			assign {next_ten, next_unit} = A + B;
			assign next_sign = 0;
		end else if (operator[1] == 0) begin
			if (A >= B) begin
				assign {next_ten, next_unit} = A - B;
				assign next_sign = 0;
			end else begin
				assign {next_ten, next_unit} = B - A;
				assign next_sign = 1;
			end
		end else begin
			assign next_ten = value_result_tens;
			assign next_unit = value_result_units;
			assign next_sign = sign_result;
		end
	end // end of reset_n block
	*/
endmodule
