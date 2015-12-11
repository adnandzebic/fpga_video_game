// File: linedraw.v
// This is the linedraw design for EE178 Lab #6.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 1 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.

module linedraw (
  input wire go,
  output wire busy,
  input wire [7:0] stax,
  input wire [7:0] stay,
  input wire [7:0] endx,
  input wire [7:0] endy,
  output wire wr,
  output wire [15:0] addr,
  input wire pclk
  );

  // Describe the actual linedraw for the assignment.
  // Please refer to the provided reference materials
  // or research line drawing algorithms.  The default
  // logic provided here will allow you to initially
  // draw pixels to test integration of your video
  // timing controller and the simulation environment.

    wire right, down, stopbreak, e2ltdx, e2gtdy, in_loop;
    wire signed [10:0] x1, x0, y1, y0, x1x0, y1y0, dx, dy, xnext, xb, xa, ynext, yb, ya;
    wire signed [11:0] errnext, err2, err1, e2;
    reg state = 0;
    reg signed [11:0] err = 0;
    reg signed [10:0] x = 0, y = 0;

    assign x0 = {3'b0, stax}; // x start
    assign y0 = {3'b0, stay}; // y start
    assign x1 = {3'b0, endx}; // x end
    assign y1 = {3'b0, endy}; // y end
    
    assign x1x0 = x1 - x0; 
    assign y1y0 = y1 - y0;
    assign right = !x1x0[10];
    assign down = !y1y0[10];
    
    assign dx = right ? x1x0 : (-x1x0);
    assign dy = down ? (-y1y0) : y1y0;

    assign errnext = in_loop ? err2 : (dx + dy);
    assign err2 = e2ltdx ? (err1 + dx) : err1;
    assign err1 = e2gtdy ? (err + dy) : err;
    
    assign e2 = err<<1;
    
    assign e2gtdy = (e2 > dy) ? 1 : 0;
    assign e2ltdx = (e2 < dx) ? 1 : 0;

    assign xnext = in_loop ? xb : x0;
    assign xb = e2gtdy ? xa : x;
    assign xa = right ? (x+1) : (x-1);
    
    assign ynext = in_loop ? yb : y0;
    assign yb = e2ltdx ? ya : y;
    assign ya = down ? (y+1) : (y-1);

    /*
    assign err = errnext;
    assign x = xnext;
    assign y = ynext;
    */
    
    always @ (posedge pclk)
    begin      
        err <= errnext;
        x <= xnext;
        y <= ynext;
    end
    
    assign stopbreak = (((x==x1)&(y==y1)) ? 1 : 0);
    
    always @ (posedge pclk)
    begin
        case (state)
        0: if (go) state <= 1; // idle state
        1: if (stopbreak) state <= 0; // running state
        default: state <= 0;
        endcase
    end
  
  assign in_loop = (state == 1);
//  assign done = (state == 2);
  
  assign busy = in_loop;
  assign wr = in_loop;
  assign addr = {y[7:0],x[7:0]};

endmodule
