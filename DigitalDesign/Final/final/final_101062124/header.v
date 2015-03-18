// file header here
//

`timescale  1ns/100ps

// Switch between FSDB or VCD format of output waveform
`define FSDB

// Option to dump the entire memory content
`define DEBUG_MEM

// Option to trace read/write access to the data memory from the top level
`define DEBUG_DATAMEM_RW

// Option to trace memory read/write 
// Turned off by default because it would be annoying
//`define DEBUG_MEM_RW

// Option to capture the instruction register at the positive-edge clock
// instead of the change of the instruction register
// Trade-off:
// a. With this option disabled:
//     1. Identical instructions will not be prompted if they are
//        consecutive in order.
//     (Becasue I use 'always @(ir)'.)
// b. With this option enabled:
//     1. Unknown instruction in the beginning will be captured.
//     2. The program counter will be displayed one cycle ahead from its
//        corresponding instruction.
//     (Becasue I use 'always @(posedge clk)' which causes a delay.)
// I consider the trade-off a feature instead of a bug, because you might
// need to adapt the deassembler and revise it whatever necessary in your
// design.
//
//`define CYC_BASED_DEASSEMBLY
