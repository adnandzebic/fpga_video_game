`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/28/2015 08:20:30 AM
// Design Name:
// Module Name: linedraw
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


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

  /*
  assign busy = go;
  assign wr = go;
  assign addr = {stay,stax};
  */

  /*
  NOTE:
  go = start
  busy = !done ??
  wr = plot  ??
  */


  assign addr[7:0] = x;
  assign addr[15:8] = y;

  // Datapath for dx, dy, right and down
  wire signed [10:0] x0, y0, x1, y1, x1x0, y1y0, dx, dy;
  wire right, down;
  

  assign x0 = {3'b0, stax};
  assign y0 = {3'b0, stay};
  assign x1 = {3'b0, endx};
  assign y1 = {3'b0, endy};

  assign x1x0 = x1 - x0;
  assign y1y0 = y1 - y0;

  assign right = ~(x1x0[10]);
  assign down = ~(y1y0[10]);

  assign dx = right ? x1x0 : (-x1x0); // dx <= x1x0 when right = '1' else -x1x0;
  assign dy = down ? (-y1y0) : y1y0;
  // Datapath for err
  wire signed [11:0] err_next, err1, err2, e2;
  reg signed [11:0] err;
  wire e2_lt_dx, e2_gt_dy, in_loop, start;
  reg plot;

  assign e2 = err << 1;
  
  assign e2_gt_dy = (e2 > dy) ? 1 : 0;
  assign e2_lt_dx = (e2 < dx) ? 1 : 0;
  
  assign err1 = e2_gt_dy ? (err + dy) : err;
  assign err2 = e2_lt_dx ? (err1 + dx) : err1;
  
  assign err_next = (in_loop == 0) ? (dx + dy) : err2;


  // Datapath for x and y
  reg signed [10:0] x, y;
  wire signed [10:0] x_next, y_next, xa, ya, xb, yb;
  wire stop;

  assign x_next = (in_loop == 0) ? x0 : xb;
  assign xb = e2_gt_dy ? xa : x;
  assign xa = right ? (x + 1) : (x - 1);
  
  assign y_next = (in_loop == 0) ? y0 : yb;
  assign yb = e2_lt_dx ? ya : y;
  assign ya = down ? (y + 1) : (y - 1);
  
  assign stop = ( (x == x1) && (y == y1) ) ? 1 : 0;


  always @(posedge pclk)
  begin
    err <= err_next;
    x <= x_next;
    y <= y_next;
  end

  // Control stuff
  reg [1:0] state;
  reg [1:0] next_state;

  parameter [1:0] IDLE_STATE = 2'b11;
  parameter [1:0] RUNNING_STATE = 2'b01;
  parameter [1:0] DONE_STATE = 2'b10;

  always @(posedge pclk)
  begin
    state <= next_state;
  end

  always @*
  begin
    case(state)
      IDLE_STATE:       if (start) next_state = RUNNING_STATE;
      RUNNING_STATE:    if (stop) next_state = DONE_STATE;
      DONE_STATE:       if (start) next_state = RUNNING_STATE;
                        else next_state = IDLE_STATE;
      default:          next_state = IDLE_STATE;
    endcase
  end

  assign in_loop = (state == RUNNING_STATE) ? 1 : 0;
  assign done = (state == DONE_STATE) ? 1 : 0;

  always @*
  begin
    plot = in_loop;
  end

  // My hacks
  assign busy = in_loop;
  assign start = go;
  assign wr = plot;
endmodule
