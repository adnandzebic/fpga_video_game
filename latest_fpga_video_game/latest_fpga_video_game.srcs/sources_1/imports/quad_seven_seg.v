// File: quad_seven_seg.v
// This is the top level design for EE178 Lab #2.
// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).
`timescale 1 ns / 1 ps
// Declare the module and its ports. This is
// using Verilog-2001 syntax.
module quad_seven_seg (
 input wire clk,
 input wire [3:0] val3,
 input wire dot3,
 input wire [3:0] val2,
 input wire dot2,
 input wire [3:0] val1,
 input wire dot1,
 input wire [3:0] val0,
 input wire dot0,
 output reg an3,
 output reg an2,
 output reg an1,
 output reg an0,
 output reg ca,
 output reg cb,
 output reg cc,
 output reg cd,
 output reg ce,
 output reg cf,
 output reg cg,
 output reg dp
 );

 
// My current design uses more than one clock?
// Creating the counter
 reg [15:0]counter;
  
 always @ (posedge clk)
  begin
    counter <= counter + 1;
  end
  
 
reg [6:0] temp0;
reg [6:0] temp1;
reg [6:0] temp2;
reg [6:0] temp3;
  
 always @ (*)
  begin
   case(counter[15:14]) //using only the 2 MSB's of the counter
     
    2'b00 : // Check if the first two MSBs are equal to 00
     begin
      // Enable only the fourth display
      {an0, an1, an2, an3} = 4'b0111;
      
      case(val0)
        4'h0 : temp0 = 7'b1000000; // Digit zero
        4'h1 : temp0 = 7'b1111001; // Digit one
        4'h2 : temp0 = 7'b0100100; // Digit two
        4'h3 : temp0 = 7'b0110000; // Digit three
        4'h4 : temp0 = 7'b0011001; // Digit four
        4'h5 : temp0 = 7'b0010010; // Digit five
        4'h6 : temp0 = 7'b0000010; // Digit six
        4'h7 : temp0 = 7'b1111000; // Digit seven
        4'h8 : temp0 = 7'b0000000; // Digit eight
        4'h9 : temp0 = 7'b0010000; // Digit nine
        4'hA : temp0 = 7'b0001000; // Digit A (hex)
        4'hB : temp0 = 7'b0000011; // Digit B (hex)
        4'hC : temp0 = 7'b0100111; // Digit C (hex)
        4'hD : temp0 = 7'b0100001; // Digit D (hex)
        4'hE : temp0 = 7'b0000110; // Digit E (hex)
        4'hF : temp0 = 7'b0001110; // Digit F (hex)
        default : temp0 = 7'bxxxxxxx; // Weird case
      endcase
      
      ca = temp0[0];
      cb = temp0[1];
      cc = temp0[2];
      cd = temp0[3];
      ce = temp0[4];
      cf = temp0[5];
      cg = temp0[6];
      
      case(dot0)
        0 : dp = 1;
        1 : dp = 0;
        default : dp = 1'bx;
      endcase
      
      
      
     end
     
    2'b01:  // Check if the first two MSBs are equal to 01
     begin
      // Enable only the third display
      {an0, an1, an2, an3} = 4'b1011;
      
      case(val1)
        4'h0 : temp1 = 7'b1000000; // Digit zero
        4'h1 : temp1 = 7'b1111001; // Digit one
        4'h2 : temp1 = 7'b0100100; // Digit two
        4'h3 : temp1 = 7'b0110000; // Digit three
        4'h4 : temp1 = 7'b0011001; // Digit four
        4'h5 : temp1 = 7'b0010010; // Digit five
        4'h6 : temp1 = 7'b0000010; // Digit six
        4'h7 : temp1 = 7'b1111000; // Digit seven
        4'h8 : temp1 = 7'b0000000; // Digit eight
        4'h9 : temp1 = 7'b0010000; // Digit nine
        4'hA : temp1 = 7'b0001000; // Digit A (hex)
        4'hB : temp1 = 7'b0000011; // Digit B (hex)
        4'hC : temp1 = 7'b0100111; // Digit C (hex)
        4'hD : temp1 = 7'b0100001; // Digit D (hex)
        4'hE : temp1 = 7'b0000110; // Digit E (hex)
        4'hF : temp1 = 7'b0001110; // Digit F (hex)
        default : temp0 = 7'bxxxxxxx; // Weird case
      endcase
      
      ca = temp1[0];
      cb = temp1[1];
      cc = temp1[2];
      cd = temp1[3];
      ce = temp1[4];
      cf = temp1[5];
      cg = temp1[6];

      case(dot1)
        0 : dp = 1;
        1 : dp = 0;
        default : dp = 1'bx;
      endcase
      
      
     end
     
    2'b10:  // Check if the first two MSBs are equal to 10
     begin
      // Enable the second display only
      {an0, an1, an2, an3} = 4'b1101;
      
      
      case(val2)
        4'h0 : temp2 = 7'b1000000; // Digit zero
        4'h1 : temp2 = 7'b1111001; // Digit one
        4'h2 : temp2 = 7'b0100100; // Digit two
        4'h3 : temp2 = 7'b0110000; // Digit three
        4'h4 : temp2 = 7'b0011001; // Digit four
        4'h5 : temp2 = 7'b0010010; // Digit five
        4'h6 : temp2 = 7'b0000010; // Digit six
        4'h7 : temp2 = 7'b1111000; // Digit seven
        4'h8 : temp2 = 7'b0000000; // Digit eight
        4'h9 : temp2 = 7'b0010000; // Digit nine
        4'hA : temp2 = 7'b0001000; // Digit A (hex)
        4'hB : temp2 = 7'b0000011; // Digit B (hex)
        4'hC : temp2 = 7'b0100111; // Digit C (hex)
        4'hD : temp2 = 7'b0100001; // Digit D (hex)
        4'hE : temp2 = 7'b0000110; // Digit E (hex)
        4'hF : temp2 = 7'b0001110; // Digit F (hex)
        default : temp0 = 7'bxxxxxxx; // Weird case
      endcase
      
      ca = temp2[0];
      cb = temp2[1];
      cc = temp2[2];
      cd = temp2[3];
      ce = temp2[4];
      cf = temp2[5];
      cg = temp2[6];
      
      case(dot2)
        0 : dp = 1;
        1 : dp = 0;
        default : dp = 1'bx;
      endcase
      
      
     end
      
    2'b11:  // Check if the first two MSBs are equal to 11
     begin
      // Enable the first display only
      {an0, an1, an2, an3} = 4'b1110;
      
      case(val3)
        4'h0 : temp3 = 7'b1000000; // Digit zero
        4'h1 : temp3 = 7'b1111001; // Digit one
        4'h2 : temp3 = 7'b0100100; // Digit two
        4'h3 : temp3 = 7'b0110000; // Digit three
        4'h4 : temp3 = 7'b0011001; // Digit four
        4'h5 : temp3 = 7'b0010010; // Digit five
        4'h6 : temp3 = 7'b0000010; // Digit six
        4'h7 : temp3 = 7'b1111000; // Digit seven
        4'h8 : temp3 = 7'b0000000; // Digit eight
        4'h9 : temp3 = 7'b0010000; // Digit nine
        4'hA : temp3 = 7'b0001000; // Digit A (hex)
        4'hB : temp3 = 7'b0000011; // Digit B (hex)
        4'hC : temp3 = 7'b0100111; // Digit C (hex)
        4'hD : temp3 = 7'b0100001; // Digit D (hex)
        4'hE : temp3 = 7'b0000110; // Digit E (hex)
        4'hF : temp3 = 7'b0001110; // Digit F (hex)
        default : temp0 = 7'bxxxxxxx; // Weird case
      endcase
      
      
      ca = temp3[0];
      cb = temp3[1];
      cc = temp3[2];
      cd = temp3[3];
      ce = temp3[4];
      cf = temp3[5];
      cg = temp3[6];
      
      
      case(dot3)
        0 : dp = 1;
        1 : dp = 0;
        default : dp = 1'bx;
      endcase
      
     end
   default : {an0, an1, an2, an3} = 4'bxxxx;
   endcase
  end
endmodule
