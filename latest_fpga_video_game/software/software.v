///////////////////////////////////////////////////////////////////////////////////////////
// Copyright � 2010-2013, Xilinx, Inc.
// This file contains confidential and proprietary information of Xilinx, Inc. and is
// protected under U.S. and international copyright and other intellectual property laws.
///////////////////////////////////////////////////////////////////////////////////////////
//
// Disclaimer:
// This disclaimer is not a license and does not grant any rights to the materials
// distributed herewith. Except as otherwise provided in a valid license issued to
// you by Xilinx, and to the maximum extent permitted by applicable law: (1) THESE
// MATERIALS ARE MADE AVAILABLE "AS IS" AND WITH ALL FAULTS, AND XILINX HEREBY
// DISCLAIMS ALL WARRANTIES AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY,
// INCLUDING BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-INFRINGEMENT,
// OR FITNESS FOR ANY PARTICULAR PURPOSE; and (2) Xilinx shall not be liable
// (whether in contract or tort, including negligence, or under any other theory
// of liability) for any loss or damage of any kind or nature related to, arising
// under or in connection with these materials, including for any direct, or any
// indirect, special, incidental, or consequential loss or damage (including loss
// of data, profits, goodwill, or any type of loss or damage suffered as a result
// of any action brought by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the possibility of the same.
//
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-safe, or for use in any
// application requiring fail-safe performance, such as life-support or safety
// devices or systems, Class III medical devices, nuclear facilities, applications
// related to the deployment of airbags, or any other applications that could lead
// to death, personal injury, or severe property or environmental damage
// (individually and collectively, "Critical Applications"). Customer assumes the
// sole risk and liability of any use of Xilinx products in Critical Applications,
// subject only to applicable laws and regulations governing limitations on product
// liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS PART OF THIS FILE AT ALL TIMES.
//
///////////////////////////////////////////////////////////////////////////////////////////
//
// Production definition of a 2K program for KCPSM6 in a 7-Series device using a 
// RAMB36E1 primitive.
//
// Note: The complete 12-bit address bus is connected to KCPSM6 to facilitate future code 
//       expansion with minimum changes being required to the hardware description. 
//       Only the lower 11-bits of the address are actually used for the 2K address range
//       000 to 7FF hex.  
//
// Program defined by 'C:\Users\hpm\Desktop\fpga_video_game\latest_fpga_video_game\software\software.psm'.
//
// Generated by KCPSM6 Assembler: 02 Dec 2015 - 19:27:16. 
//
///////////////////////////////////////////////////////////////////////////////////////////
 
`timescale 1 ns / 1 ps
 
module software (
  input  [11:0] address,
  output [17:0] instruction,
  input         bram_enable,
  input         clk
  );
 
  wire [15:0] address_a;
  wire [35:0] data_in_a;
  wire [35:0] data_out_a;
  wire [15:0] address_b;
  wire [35:0] data_in_b;
  wire [35:0] data_out_b;
  wire        enable_b;
  wire        clk_b;
  wire [7:0]  we_b;
  
  assign address_a = {1'b1, address[10:0], 4'b1111};
  assign instruction = {data_out_a[33:32],  data_out_a[15:0]};
  assign data_in_a = {35'b000000000000000000000000000000000000, address[11]};
  
  assign address_b = 16'b1111111111111111;
  assign data_in_b = {2'h0,  data_out_b[33:32], 16'h0000, data_out_b[15:0]};
  assign enable_b = 1'b0;
  assign we_b = 8'h00;
  assign clk_b = 1'b0;
 
  RAMB36E1 #(
    .READ_WIDTH_A              (18),
    .WRITE_WIDTH_A             (18),
    .DOA_REG                   (0),
    .INIT_A                    (36'h000000000),
    .RSTREG_PRIORITY_A         ("REGCE"),
    .SRVAL_A                   (36'h000000000),
    .WRITE_MODE_A              ("WRITE_FIRST"),
    .READ_WIDTH_B              (18),
    .WRITE_WIDTH_B             (18),
    .DOB_REG                   (0),
    .INIT_B                    (36'h000000000),
    .RSTREG_PRIORITY_B         ("REGCE"),
    .SRVAL_B                   (36'h000000000),
    .WRITE_MODE_B              ("WRITE_FIRST"),
    .INIT_FILE                 ("NONE"),
    .SIM_COLLISION_CHECK       ("ALL"),
    .RAM_MODE                  ("TDP"),
    .RDADDR_COLLISION_HWCONFIG ("DELAYED_WRITE"),
    .EN_ECC_READ               ("FALSE"),
    .EN_ECC_WRITE              ("FALSE"),
    .RAM_EXTENSION_A           ("NONE"),
    .RAM_EXTENSION_B           ("NONE"),
    .SIM_DEVICE                ("7SERIES"),
    .INIT_00                   (256'hD505150FD50615031F621EFF1D051C801B001A00190014001300120011001000),
    .INIT_01                   (256'h0078950F700090010039D9030048D9020063D901001DD90020138001D51015FF),
    .INIT_02                   (256'h70001000700160372043D0781001700160372043D0F010017001202DD510950F),
    .INIT_03                   (256'h10017001202DD510950F028C7000500070005000190070001000700150001901),
    .INIT_04                   (256'h9807DC01D500156401E6032C0328006D5000500019037000100060472032D0F0),
    .INIT_05                   (256'h1EFF1D051C80DA0BDB0A1B001A00190160622058D508950F041DD8039807D802),
    .INIT_06                   (256'h12FF110F100050000423032C035903280367D510950F006D950F500050001F62),
    .INIT_07                   (256'h124611C81041041313D2124111C810415000041313F012FF11F010000413130F),
    .INIT_08                   (256'h13D2124B11C8104B041313CD124611CD1041041313CD124611C81046041313C8),
    .INIT_09                   (256'h041313CD125011CD104B041313CD125011C81050041313C8125011C8104B0413),
    .INIT_0A                   (256'h1055041313D2125511C81055041313D2124F11CE104B041313D2125011CD104B),
    .INIT_0B                   (256'h11C8105F041313D2125A11D21055041313CD125A11CD1055041313C8125A11C8),
    .INIT_0C                   (256'h126411CD1064041313CD126411CD105F041313CD125F11C8105F041313C81264),
    .INIT_0D                   (256'h13CD126911C81069041313C8126E11C81069041313D2126411D2105F041313D2),
    .INIT_0E                   (256'h041313D2126E11D21069041313D2126E11CD106E041313CD126E11CD10690413),
    .INIT_0F                   (256'h1087041313CD128711CD1082041313CD128211C81082041313C8128811C81082),
    .INIT_10                   (256'h11C8108F041313C8129311C8108C041313D2128711D21082041313D2128711CD),
    .INIT_11                   (256'h129B11CD1096041313C8129B11C81096041313D2129611C81096041313D2128F),
    .INIT_12                   (256'h13C812A511C810A0041313D212A011C810A0041313D2129B11C8109B041313CD),
    .INIT_13                   (256'h041313D212A511CD10A0041313CD12A511CD10A0041313CD12A511C810A50413),
    .INIT_14                   (256'h1000041313D212AD11C810AD041313C812B111C810AA041313D212A411CE10A0),
    .INIT_15                   (256'h118810000413130E12FF110E10000413130C12FF110C10000413130A12FF110A),
    .INIT_16                   (256'h1200113010000413138C12FF118C10000413138A12FF118A10000413138812FF),
    .INIT_17                   (256'h132D1200111E10000413132D1200112D10000413133C1200113010000413133C),
    .INIT_18                   (256'h0413131E1200111E10000413131E1200111E10000413131E1200111E10000413),
    .INIT_19                   (256'h105A04131378125A11781046041313781246115A10460413135A125A115A1046),
    .INIT_1A                   (256'h116910640413135A1278115A10640413136912501169105A04131378125A1169),
    .INIT_1B                   (256'h1282115A1082041313781278115A1078041313781264115A1064041313691278),
    .INIT_1C                   (256'h1369128C115A108204131369128C115A1096041313781296115A109604131378),
    .INIT_1D                   (256'h0413136912B4116910A00413135A12B4115A10A00413137812A0115A10A00413),
    .INIT_1E                   (256'h0413133C120A111E100A0413131E121E111E100A50000413137812B4117810A0),
    .INIT_1F                   (256'h102804131332121E113210140413133C121E1132101E0413133C121E113C100A),
    .INIT_20                   (256'h111E103C0413132D123C112D10280413131E123C111E10280413133C1228111E),
    .INIT_21                   (256'h1250111E105A041313321250111E10460413133C1246111E10460413133C123C),
    .INIT_22                   (256'h131E1278111E10640413133C1264111E10640413133C125A111E105A04131332),
    .INIT_23                   (256'h0413133C1282111E10820413133C1278113C10640413132D1278112D10640413),
    .INIT_24                   (256'h10A00413133C1296113C10820413133C1296111E10960413131E1296111E1082),
    .INIT_25                   (256'h111E10BE0413133C12BE111E10BE0413133C12AA111E10B40413133C12AA111E),
    .INIT_26                   (256'h12DC111E10DC0413133C12D2113C10BE0413132D12D2112D10BE0413131E12D2),
    .INIT_27                   (256'h132D12F0112D10DC0413132D12F0111E10F00413131E12F0111E10DC0413133C),
    .INIT_28                   (256'h131E122D111E102350000413133C12EF112E10DC0413133C12F0112D10DC0413),
    .INIT_29                   (256'h0413133C12231132101904131332121911281019041313281219111E10230413),
    .INIT_2A                   (256'h104B0413131E124B111E10370413133C1237111E10370413133C122D113C1023),
    .INIT_2B                   (256'h112E10370413133C124B112D10370413132D124B112D10370413132D124B111E),
    .INIT_2C                   (256'h1269112D10550413131E1269111E10550413133C1255111E10550413133C124A),
    .INIT_2D                   (256'h131E1282111E10730413133C1273111E10730413133C1269113C10550413132D),
    .INIT_2E                   (256'h0413133C12821137108704131337128711231087041313231287111E10820413),
    .INIT_2F                   (256'h10910413133C129B111E109B0413131E12A5111E10910413133C1282113C1073),
    .INIT_30                   (256'h111E10CD0413133C12B9111E10B90413131E12C3111E10AF0413133C12A5113C),
    .INIT_31                   (256'h12E1112D10E10413132D12E1112D10CD0413132D12CD111E10CD0413131E12E1),
    .INIT_32                   (256'hA335C65016E105E0500003AC03E1036D50000413133C12E1113C10CD0413133C),
    .INIT_33                   (256'hD502950AD5002340D6021600D5002340D502950AD500233D2339A339C560160A),
    .INIT_34                   (256'h05E0041DD503153C05F0DF01DE02DE00041DD503D501153C05F0041DDF03DF01),
    .INIT_35                   (256'h95075000635E235FDEFF235FDE005000041DD503153C05F0DF01D502D500950A),
    .INIT_36                   (256'h06C0D500156450009C045000E36B636BDC1550000F50E35FD5B4A35FE363D50F),
    .INIT_37                   (256'hD6039602D5029504D601960306C0D50095011564041DD6039603D5029501D601),
    .INIT_38                   (256'hD601160306C0D50095011564041DD6031603D5029501D60106C0D5001564041D),
    .INIT_39                   (256'h041DD6031605D5029507D601960506C0D50095051564041DD6031602D5029504),
    .INIT_3A                   (256'h06C0D500950A15645000041DD6039605D5029507D601160506C0D50095051564),
    .INIT_3B                   (256'h1564041DD603D5029508D60106C0D500950C1564041DD603D5029507D6019602),
    .INIT_3C                   (256'h06C0D5009509950C1564041DD6039602D5029502D601960206C0D5009508950A),
    .INIT_3D                   (256'h041DD6031605D502D601960406C0D500950A950A1564041DD6031601D502D601),
    .INIT_3E                   (256'hD601960706C0D5001564041DD6039602D502D601960506C0D500950515645000),
    .INIT_3F                   (256'h95341564041DD603D5029504D60106C0D500952815645000041DD603D502950A),
    .INIT_40                   (256'hD5029504D601960406C0D50095401564041DD603D5029504D601160406C0D500),
    .INIT_41                   (256'h9504D504150150002419D5019504D5041501D303D202D101D0005000041DD603),
    .INIT_42                   (256'hC8600760160506C018F0E48D248DC8600760960A06C0180F15605000241FD501),
    .INIT_43                   (256'h160506C018F3248DC8600760160506C018F2248DC8600760160506C018F1248D),
    .INIT_44                   (256'h18F6248DC8600760160506C018F5248DC8600760160506C018F4248DC8600760),
    .INIT_45                   (256'hD560246ED561246ED562246ED563246ED564950A05E0248DC8600760160506C0),
    .INIT_46                   (256'h07C006F06478246ED554246ED555246ED556246ED557246ED558246ED559246E),
    .INIT_47                   (256'hDA059E01500004961C02C47EDA019E0164702478C680183C08F01601248DC760),
    .INIT_48                   (256'h9807D701D50050009E015000C48BDA109E015000C487DA089E0150005000C483),
    .INIT_49                   (256'h5000DA0BDB0A1B001A0150001B01249BDBFFDB0A500019020413D8039807D802),
    .INIT_4A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F                   (256'h2014000000000000000000000000000000000000000000000000000000000000),
    .INITP_00                  (256'h0200A00802AAD2280280F4A228AAA33D7D2EE338CFD7F5F48EDDDDA888000000),
    .INITP_01                  (256'h2008020080200802008020080200802008020080200802008020080200802008),
    .INITP_02                  (256'h0080200802008020080200802008020080200802008020080200802008020080),
    .INITP_03                  (256'h2008020080200A00802008020080200802008020080200802008020080200802),
    .INITP_04                  (256'h0080200802008020080200802008020080200802008020080200802008020080),
    .INITP_05                  (256'h2008020080200802008020080200802008020080200802008020080200A00802),
    .INITP_06                  (256'h99924A66226F637D2F76A4A9292AA92A9A8A9AF4D0AAA0080200802008020080),
    .INITP_07                  (256'h4A9892A99229A492A692529A252999252A624A9924A99924A6649299924A6622),
    .INITP_08                  (256'h5A75F51D0F777777777753443443443443443443443D102D22D22AAA9924A992),
    .INITP_09                  (256'h000000000000000000000000000000000000000000000000A86768A22A6D6D6B),
    .INITP_0A                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F                  (256'h8000000000000000000000000000000000000000000000000000000000000000))
  rom_2048x18 (
    .ADDRARDADDR               (address_a),
    .ENARDEN                   (bram_enable),
    .CLKARDCLK                 (clk),
    .DOADO                     (data_out_a[31:0]),
    .DOPADOP                   (data_out_a[35:32]), 
    .DIADI                     (data_in_a[31:0]),
    .DIPADIP                   (data_in_a[35:32]), 
    .WEA                       (4'h0),
    .REGCEAREGCE               (1'b0),
    .RSTRAMARSTRAM             (1'b0),
    .RSTREGARSTREG             (1'b0),
    .ADDRBWRADDR               (address_b),
    .ENBWREN                   (enable_b),
    .CLKBWRCLK                 (clk_b),
    .DOBDO                     (data_out_b[31:0]),
    .DOPBDOP                   (data_out_b[35:32]), 
    .DIBDI                     (data_in_b[31:0]),
    .DIPBDIP                   (data_in_b[35:32]), 
    .WEBWE                     (we_b),
    .REGCEB                    (1'b0),
    .RSTRAMB                   (1'b0),
    .RSTREGB                   (1'b0),
    .CASCADEINA                (1'b0),
    .CASCADEINB                (1'b0),
    .CASCADEOUTA               (),
    .CASCADEOUTB               (),
    .DBITERR                   (),
    .ECCPARITY                 (),
    .RDADDRECC                 (),
    .SBITERR                   (),
    .INJECTDBITERR             (1'b0),
    .INJECTSBITERR             (1'b0));
 
endmodule
