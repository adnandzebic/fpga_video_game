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
// Program defined by 'C:\Users\hpm\Desktop\fpga_video_game\fpga_video_game\latest_fpga_video_game\software\software.psm'.
//
// Generated by KCPSM6 Assembler: 02 Dec 2015 - 14:56:43. 
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
    .INIT_01                   (256'h950F005C950F90010026D903002CD9020047D901001DD90020138001D51015FF),
    .INIT_02                   (256'h0297029C029800515000602B2023D510950F029850005000190160252023D510),
    .INIT_03                   (256'hDB0A1B001A0019016046203CD508950F038DD8039807D8029807DC01D5001564),
    .INIT_04                   (256'h0393029C02C9029802D7D510950F0051950F500050001F621EFF1D051C80DA0B),
    .INIT_05                   (256'h13D2124111C810415000038313F012FF11F010000383130F12FF110F10005000),
    .INIT_06                   (256'h038313CD124611CD1041038313CD124611C81046038313C8124611C810410383),
    .INIT_07                   (256'h104B038313CD125011C81050038313C8125011C8104B038313D2124B11C8104B),
    .INIT_08                   (256'h11C81055038313D2124F11CE104B038313D2125011CD104B038313CD125011CD),
    .INIT_09                   (256'h125A11D21055038313CD125A11CD1055038313C8125A11C81055038313D21255),
    .INIT_0A                   (256'h13CD126411CD105F038313CD125F11C8105F038313C8126411C8105F038313D2),
    .INIT_0B                   (256'h038313C8126E11C81069038313D2126411D2105F038313D2126411CD10640383),
    .INIT_0C                   (256'h1069038313D2126E11CD106E038313CD126E11CD1069038313CD126911C81069),
    .INIT_0D                   (256'h11CD1082038313CD128211C81082038313C8128811C81082038313D2126E11D2),
    .INIT_0E                   (256'h129311C8108C038313D2128711D21082038313D2128711CD1087038313CD1287),
    .INIT_0F                   (256'h13C8129B11C81096038313D2129611C81096038313D2128F11C8108F038313C8),
    .INIT_10                   (256'h038313D212A011C810A0038313D2129B11C8109B038313CD129B11CD10960383),
    .INIT_11                   (256'h10A0038313CD12A511CD10A0038313CD12A511C810A5038313C812A511C810A0),
    .INIT_12                   (256'h11C810AD038313C812B111C810AA038313D212A411CE10A0038313D212A511CD),
    .INIT_13                   (256'h12FF110E10000383130C12FF110C10000383130A12FF110A1000038313D212AD),
    .INIT_14                   (256'h138C12FF118C10000383138A12FF118A10000383138812FF118810000383130E),
    .INIT_15                   (256'hD603D502151ED601162DD500150A038DD603163CD502D601161ED500150A0383),
    .INIT_16                   (256'hD603163CD502D601161ED5001528038DD603163CD502D601161ED500151E038D),
    .INIT_17                   (256'hD603D502153CD601162DD5001528038DD603D502153CD601161ED5001528038D),
    .INIT_18                   (256'hD603163CD502D601161ED5001546038DD603D502153CD601163CD5001528038D),
    .INIT_19                   (256'hD603163CD502D601161ED5001564038DD603D502155AD601163CD5001546038D),
    .INIT_1A                   (256'h1623D502156ED601161ED5001573038DD603D5021573D601161ED5001582038D),
    .INIT_1B                   (256'hD5021573D6011637D500156E038DD6031637D502D6011623D500156E038DD603),
    .INIT_1C                   (256'h159BD601161ED5001591038DD603D5021573D601163CD5001582038DD603163B),
    .INIT_1D                   (256'hD601161ED500158C038DD603161ED502158CD601161ED5001591038DD603D502),
    .INIT_1E                   (256'h163CD5001591038DD603163CD5021591D601163CD500158C038DD603163CD502),
    .INIT_1F                   (256'hD50015A0038DD603163CD50215A0D601163CD500159B038DD603D502159BD601),
    .INIT_20                   (256'h10AA038DD603161ED502159BD601161ED50015A0038DD603163CD502D601161E),
    .INIT_21                   (256'h111E10BE0383132D12BE112D10AA0383133C12AA111E10AA0383131E12BE111E),
    .INIT_22                   (256'h12E6111E10E60383133C12D2111E10D20383131E12DC111E10C80383132D12BE),
    .INIT_23                   (256'h133C12FA113C10E60383132D12FA112D10E60383131E12FA111E10E60383133C),
    .INIT_24                   (256'h03831378125A11781046038313781246115A10460383135A125A115A10460383),
    .INIT_25                   (256'h10640383135A1278115A10640383136912501169105A03831378125A1169105A),
    .INIT_26                   (256'h115A1082038313781278115A1078038313781264115A10640383136912781169),
    .INIT_27                   (256'h128C115A108203831369128C115A1096038313781296115A1096038313781282),
    .INIT_28                   (256'h136912B4116910A00383135A12B4115A10A00383137812A0115A10A003831369),
    .INIT_29                   (256'hA2A5C65016E105E05000031C035102DD500050000383137812B4117810A00383),
    .INIT_2A                   (256'hD502950AD50022B0D6021600D50022B0D502950AD50022AD22A9A2A9C560160A),
    .INIT_2B                   (256'h05E0038DD503153C05F0DF01DE02DE00038DD503D501153C05F0038DDF03DF01),
    .INIT_2C                   (256'h9507500062CE22CFDEFF22CFDE005000038DD503153C05F0DF01D502D500950A),
    .INIT_2D                   (256'h06C0D500156450009C045000E2DB62DBDC1550000F50E2CFD5B4A2CFE2D3D50F),
    .INIT_2E                   (256'hD6039602D5029504D601960306C0D50095011564038DD6039603D5029501D601),
    .INIT_2F                   (256'hD601160306C0D50095011564038DD6031603D5029501D60106C0D5001564038D),
    .INIT_30                   (256'h038DD6031605D5029507D601960506C0D50095051564038DD6031602D5029504),
    .INIT_31                   (256'h06C0D500950A15645000038DD6039605D5029507D601160506C0D50095051564),
    .INIT_32                   (256'h1564038DD603D5029508D60106C0D500950C1564038DD603D5029507D6019602),
    .INIT_33                   (256'h06C0D5009509950C1564038DD6039602D5029502D601960206C0D5009508950A),
    .INIT_34                   (256'h038DD6031605D502D601960406C0D500950A950A1564038DD6031601D502D601),
    .INIT_35                   (256'hD601960706C0D5001564038DD6039602D502D601960506C0D500950515645000),
    .INIT_36                   (256'h95341564038DD603D5029504D60106C0D500952815645000038DD603D502950A),
    .INIT_37                   (256'hD5029504D601960406C0D50095401564038DD603D5029504D601160406C0D500),
    .INIT_38                   (256'h9504D504150150002389D5019504D5041501D303D202D101D0005000038DD603),
    .INIT_39                   (256'hC8600760160506C018F0E3FD23FDC8600760960A06C0180F15605000238FD501),
    .INIT_3A                   (256'h160506C018F323FDC8600760160506C018F223FDC8600760160506C018F123FD),
    .INIT_3B                   (256'h18F623FDC8600760160506C018F523FDC8600760160506C018F423FDC8600760),
    .INIT_3C                   (256'hD56023DED56123DED56223DED56323DED564950A05E023FDC8600760160506C0),
    .INIT_3D                   (256'h07C006F063E823DED55423DED55523DED55623DED55723DED55823DED55923DE),
    .INIT_3E                   (256'hDA059E01500004061C02C3EEDA019E0163E023E8C680183C08F0160123FDC760),
    .INIT_3F                   (256'h9807D701D50050009E015000C3FBDA109E015000C3F7DA089E0150005000C3F3),
    .INIT_40                   (256'h5000DA0BDB0A1B001A0150001B01240BDBFFDB0A500019020383D8039807D802),
    .INIT_41                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
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
    .INITP_00                  (256'h200802008020080200A00802AAD2280280F4A228AABD2A3D22DDDDA888000000),
    .INITP_01                  (256'h0080200802008020080200802008020080200802008020080200802008020080),
    .INITP_02                  (256'hA222A2228A228A22A2228A220080200802008020080200802008020080200802),
    .INITP_03                  (256'h8A2222A2228888A288A2222A222A2228888A288A2222A2228A22A2228A22A222),
    .INITP_04                  (256'h0200802008020080200802008020080200802008020080200802008028888A28),
    .INITP_05                  (256'h924A662299924A66226F637D2F76A4A9292AA92A9A8A9AF4D0AAA80200802008),
    .INITP_06                  (256'h9924A9924A9892A99229A492A692529A252999252A624A9924A99924A6649299),
    .INITP_07                  (256'h2A6D6D6B5A75F51D0F777777777753443443443443443443443D102D22D22AAA),
    .INITP_08                  (256'h00000000000000000000000000000000000000000000000000000000A86768A2),
    .INITP_09                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
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
