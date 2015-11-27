// File: vga_timing.v
// This is the vga timing design for EE178 Lab #4.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 1 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.

module vga_timing (
  output wire [10:0] vcount,
  output wire vsync,
  output wire vblnk,
  output wire [10:0] hcount,
  output wire hsync,
  output wire hblnk,
  input wire pclk
  );
  
  reg [10:0]hcounter;
  assign hcount = hcounter; // dummy variable?
  
  reg [10:0]vcounter;
  assign vcount = vcounter;
  
  
  
  // Describe the actual circuit for the assignment.
  // Video timing controller set for 800x600@60fps
  // using a 40 MHz pixel clock per VESA spec.
  
  // reg RESETvcount;
  // reg RESEThcount;
  
  assign hblnk = (hcounter >= 800); // This means im in the horizontal blanking state
  assign vblnk = (vcounter >= 600); // This means im in the vertical blanking state
  assign hsync = (hcounter >= 840 && hcounter <= 968);
  assign vsync = (vcounter >= 601 && vcounter <= 605);


  // horizontal stuff
  always @ (posedge pclk)
  begin
    if (hcounter == 1055)
    begin
        hcounter <= 0;
    end
    
    else
    begin
        hcounter <= hcounter + 1;
    end
  end
  
  
  // vertical stuff
  always @ (posedge pclk)
  begin
      if (vcounter == 627 && hcounter == 1055)
      begin
        vcounter <= 0;
      end
  
      else if (hcounter == 1055)
      begin
        vcounter <= vcounter + 1;
      end
  end
 
endmodule
