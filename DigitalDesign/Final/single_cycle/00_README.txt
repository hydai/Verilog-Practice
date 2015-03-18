# README for CS4125 Final Project 2014

## Good luck and happy designing

### Setup File for Synopsys Design Compiler

You should rename it to .synopsys_dc.setup

-    synopsys_dc.setup

### A Sample Test Stimulus

The stimulus comes with a Makefile, a header file and the sample waveform for
your reference.

-    Makefile
-    header.v
-    risc_t.v
-    risc.orig.fsdb

### Memory Model

-    RAM2Kx32.v
-    RAM2Kx32_slow_syn.db

### Sample test programs (binary code):

Note: Some of them may not be fully verified.  They are here for your
reference.  Please report any bug you find out.

-    01_gcd_plain-unified.dat
     The test code of GCD function for unified instruction/data memory.
     In the test stimulus rist_t.v using separate I/D memory, the test
     code is split to two files:

         01_gcd_plain-bin.dat for the binary code and
         01_gcd_plain-data.dat for the data segment.

     Note that the following test programs are all in the unified style.
     You should convert them to separate format by your own.
         
-    02_mult.dat
-    03_division.dat
-    04_lcm.dat
-    05_factorial.dat
-    06_fibonacci_recursive.dat
-    07_lcm_2.dat
-    08_summation.dat
-    09_fabonacci.dat
-    10_division_2.dat
-    11_lcm_3.dat
-    12_factional_2.dat
-    13_procedure_call.dat

