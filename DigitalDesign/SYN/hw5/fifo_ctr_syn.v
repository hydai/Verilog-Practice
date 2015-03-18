
module fifo_ctr ( clk, rst_n, push, pop, empty, almost_empty, full, 
        almost_full, error, cen, wen, oen, addr );
  output [4:0] addr;
  input clk, rst_n, push, pop;
  output empty, almost_empty, full, almost_full, error, cen, wen, oen;
  wire   \state_next[0] , N31, N32, N33, N34, N36, N37, N38, N39, N41, N42,
         N43, N44, N45, N47, N48, N49, N50, n9, n10, n11, n12, n13, n14, n15,
         n19, n20, n21, n22, n23, n24, n25, n27, n28, n29, n30, n31, n32, n33,
         n34, n35, n36, n37, n38, n39, n41, n42, n43, n44, n45, n46, n47, n48,
         n49, n50, n51, \add_109/carry[4] , \add_109/carry[3] ,
         \add_109/carry[2] , \add_104/carry[4] , \add_104/carry[3] ,
         \add_104/carry[2] , n53, n54, n55, n56, n57, n58, n59, n60, n62, n63;
  wire   [1:0] state;
  wire   [4:0] head;
  wire   [4:0] tail;
  wire   [4:0] head_next;
  assign oen = 1'b0;
  assign cen = 1'b0;
  assign full = 1'b0;
  assign empty = 1'b0;
  assign almost_empty = N45;

  DFFRX1 \head_reg[4]  ( .D(head_next[4]), .CK(clk), .RN(rst_n), .Q(head[4]), 
        .QN(n13) );
  DFFRX1 \tail_reg[4]  ( .D(n50), .CK(clk), .RN(rst_n), .Q(tail[4]), .QN(n45)
         );
  DFFRX1 \tail_reg[1]  ( .D(n48), .CK(clk), .RN(rst_n), .Q(tail[1]), .QN(n42)
         );
  DFFRX1 \head_reg[3]  ( .D(head_next[3]), .CK(clk), .RN(rst_n), .Q(head[3]), 
        .QN(n12) );
  DFFRX1 \tail_reg[3]  ( .D(n46), .CK(clk), .RN(rst_n), .Q(tail[3]), .QN(n44)
         );
  DFFRX1 \head_reg[2]  ( .D(head_next[2]), .CK(clk), .RN(rst_n), .Q(head[2]), 
        .QN(n11) );
  DFFRX1 \tail_reg[2]  ( .D(n47), .CK(clk), .RN(rst_n), .Q(tail[2]), .QN(n43)
         );
  DFFRX1 \state_reg[1]  ( .D(n51), .CK(clk), .RN(rst_n), .Q(state[1]), .QN(n53) );
  DFFRX1 \head_reg[1]  ( .D(head_next[1]), .CK(clk), .RN(rst_n), .Q(head[1]), 
        .QN(n10) );
  DFFRX1 \head_reg[0]  ( .D(head_next[0]), .CK(clk), .RN(rst_n), .Q(head[0]), 
        .QN(n9) );
  DFFRX1 \tail_reg[0]  ( .D(n49), .CK(clk), .RN(rst_n), .Q(tail[0]), .QN(n41)
         );
  DFFRX1 \state_reg[0]  ( .D(\state_next[0] ), .CK(clk), .RN(rst_n), .Q(
        state[0]), .QN(n54) );
  CLKINVX1 U50 ( .A(n24), .Y(wen) );
  CLKINVX1 U51 ( .A(n23), .Y(n62) );
  CLKINVX1 U52 ( .A(n19), .Y(almost_full) );
  XOR2X1 U53 ( .A(n13), .B(N50), .Y(n28) );
  XOR2X1 U54 ( .A(n45), .B(N44), .Y(n34) );
  XNOR2X1 U55 ( .A(n44), .B(N43), .Y(n38) );
  NAND4X1 U56 ( .A(n28), .B(n29), .C(n30), .D(n31), .Y(n19) );
  XOR2X1 U57 ( .A(n10), .B(N47), .Y(n29) );
  NOR2X1 U58 ( .A(n32), .B(n33), .Y(n30) );
  XOR2X1 U59 ( .A(n11), .B(N48), .Y(n31) );
  OAI221XL U60 ( .A0(n15), .A1(n54), .B0(N45), .B1(n63), .C0(wen), .Y(
        \state_next[0] ) );
  CLKINVX1 U61 ( .A(n14), .Y(n63) );
  AND4X1 U62 ( .A(n34), .B(n35), .C(n36), .D(n37), .Y(N45) );
  XOR2X1 U63 ( .A(n42), .B(N41), .Y(n35) );
  NOR2X1 U64 ( .A(n38), .B(n39), .Y(n36) );
  XOR2X1 U65 ( .A(n43), .B(N42), .Y(n37) );
  OAI211X1 U66 ( .A0(n19), .A1(n20), .B0(n21), .C0(n22), .Y(n51) );
  NAND2X1 U67 ( .A(state[0]), .B(n23), .Y(n20) );
  NOR2X1 U68 ( .A(n53), .B(state[0]), .Y(n14) );
  NOR2X1 U69 ( .A(n62), .B(state[1]), .Y(n24) );
  XNOR2X1 U70 ( .A(n12), .B(N49), .Y(n32) );
  NAND2X1 U71 ( .A(n15), .B(state[0]), .Y(n21) );
  OAI2BB2XL U72 ( .B0(n44), .B1(n14), .A0N(N38), .A1N(n14), .Y(n46) );
  OAI2BB2XL U73 ( .B0(n43), .B1(n14), .A0N(N37), .A1N(n14), .Y(n47) );
  OAI2BB2XL U74 ( .B0(n42), .B1(n14), .A0N(N36), .A1N(n14), .Y(n48) );
  OAI2BB2XL U75 ( .B0(n41), .B1(n14), .A0N(n41), .A1N(n14), .Y(n49) );
  OAI2BB2XL U76 ( .B0(n45), .B1(n14), .A0N(N39), .A1N(n14), .Y(n50) );
  OAI2BB2XL U77 ( .B0(n13), .B1(n24), .A0N(N34), .A1N(n24), .Y(head_next[4])
         );
  OAI2BB2XL U78 ( .B0(n12), .B1(n24), .A0N(N33), .A1N(n24), .Y(head_next[3])
         );
  OAI2BB2XL U79 ( .B0(n11), .B1(n24), .A0N(N32), .A1N(n24), .Y(head_next[2])
         );
  OAI2BB2XL U80 ( .B0(n10), .B1(n24), .A0N(N31), .A1N(n24), .Y(head_next[1])
         );
  OAI2BB2XL U81 ( .B0(n9), .B1(n24), .A0N(n9), .A1N(n24), .Y(head_next[0]) );
  ADDHXL U82 ( .A(head[1]), .B(head[0]), .CO(\add_104/carry[2] ), .S(N31) );
  ADDHXL U83 ( .A(tail[1]), .B(tail[0]), .CO(\add_109/carry[2] ), .S(N36) );
  ADDHXL U84 ( .A(head[2]), .B(\add_104/carry[2] ), .CO(\add_104/carry[3] ), 
        .S(N32) );
  ADDHXL U85 ( .A(tail[2]), .B(\add_109/carry[2] ), .CO(\add_109/carry[3] ), 
        .S(N37) );
  XOR2X1 U86 ( .A(n9), .B(tail[0]), .Y(n33) );
  XOR2X1 U87 ( .A(n41), .B(head[0]), .Y(n39) );
  ADDHXL U88 ( .A(head[3]), .B(\add_104/carry[3] ), .CO(\add_104/carry[4] ), 
        .S(N33) );
  ADDHXL U89 ( .A(tail[3]), .B(\add_109/carry[3] ), .CO(\add_109/carry[4] ), 
        .S(N38) );
  NAND2X1 U90 ( .A(state[0]), .B(state[1]), .Y(n22) );
  NOR2BX1 U91 ( .AN(push), .B(pop), .Y(n23) );
  NOR2BX1 U92 ( .AN(pop), .B(push), .Y(n15) );
  OAI22XL U93 ( .A0(n9), .A1(wen), .B0(n41), .B1(n21), .Y(addr[0]) );
  OAI22XL U94 ( .A0(n10), .A1(wen), .B0(n42), .B1(n21), .Y(addr[1]) );
  OAI22XL U95 ( .A0(n11), .A1(wen), .B0(n43), .B1(n21), .Y(addr[2]) );
  OAI22XL U96 ( .A0(n12), .A1(wen), .B0(n44), .B1(n21), .Y(addr[3]) );
  OAI22XL U97 ( .A0(n13), .A1(wen), .B0(n45), .B1(n21), .Y(addr[4]) );
  OAI221XL U98 ( .A0(state[0]), .A1(n25), .B0(n62), .B1(n22), .C0(n27), .Y(
        error) );
  AOI221XL U99 ( .A0(state[1]), .A1(n23), .B0(pop), .B1(n53), .C0(n15), .Y(n25) );
  NAND3X1 U100 ( .A(state[0]), .B(push), .C(pop), .Y(n27) );
  NOR2X1 U101 ( .A(tail[1]), .B(tail[0]), .Y(n55) );
  AO21X1 U102 ( .A0(tail[0]), .A1(tail[1]), .B0(n55), .Y(N47) );
  NAND2X1 U103 ( .A(n55), .B(n43), .Y(n56) );
  OAI21XL U104 ( .A0(n55), .A1(n43), .B0(n56), .Y(N48) );
  XNOR2X1 U105 ( .A(tail[3]), .B(n56), .Y(N49) );
  NOR2X1 U106 ( .A(tail[3]), .B(n56), .Y(n57) );
  XOR2X1 U107 ( .A(tail[4]), .B(n57), .Y(N50) );
  XOR2X1 U108 ( .A(\add_104/carry[4] ), .B(head[4]), .Y(N34) );
  XOR2X1 U109 ( .A(\add_109/carry[4] ), .B(tail[4]), .Y(N39) );
  NOR2X1 U110 ( .A(head[1]), .B(head[0]), .Y(n58) );
  AO21X1 U111 ( .A0(head[0]), .A1(head[1]), .B0(n58), .Y(N41) );
  NAND2X1 U112 ( .A(n58), .B(n11), .Y(n59) );
  OAI21XL U113 ( .A0(n58), .A1(n11), .B0(n59), .Y(N42) );
  XNOR2X1 U114 ( .A(head[3]), .B(n59), .Y(N43) );
  NOR2X1 U115 ( .A(head[3]), .B(n59), .Y(n60) );
  XOR2X1 U116 ( .A(head[4]), .B(n60), .Y(N44) );
endmodule

