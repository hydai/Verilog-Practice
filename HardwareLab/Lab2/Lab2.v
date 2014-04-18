`timescale 1ns / 1ps
module Lab2(a0, a1, a2, a3, b0, b1, b2, b3, M, s0, s1, s2, s3);
	input a0, a1, a2, a3;
	input b0, b1, b2, b3;
	input M;
	output s0, s1, s2, s3;	
	wire t1, t2, t3, t4;
	wire x1, x2, x3, x4;
	
	xor(x1, b0, M);
	xor(x2, b1, M);
	xor(x3, b2, M);
	xor(x4, b3, M);
	one_bit_fa1 ob1(s0, t1, a0, x1, M);	// use gate-level
	one_bit_fa1 ob2(s1, t2, a1, x2, t1);
	one_bit_fa1 ob3(s2, t3, a2, x3, t2);
	one_bit_fa1 ob4(s3, t4, a3, x4, t3);
	
endmodule

module one_bit_fa1(sum, c_out, p, q, c_in);
	input p, q, c_in;
	output sum, c_out;
	wire t1, t2, t3, t4;
	xor(t1, p, q);
	xor(sum, t1, c_in);
	
	xor(t4, p, q);
	and(t2, p, q);
	and(t3, c_in, t4);
	or(c_out, t2, t3);

endmodule
