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
// Program defined by '{psmname}.psm'.
//
// Generated by KCPSM6 Assembler: 2015-12-01T22:19:05. 
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
    .INIT_01                   (256'h2021D510950F0054950F90010024D902003FD901001BD90020138001D51015FF),
    .INIT_02                   (256'h0389D8039807D8029807DC01D5001564028F0298029400495000500019016023),
    .INIT_03                   (256'h950F500050001F621EFF1D051C80DA0BDB0A1B001A001901603E2034D508950F),
    .INIT_04                   (256'h11F01000037F130F12FF110F10005000038F029802C5029402D3D510950F0049),
    .INIT_05                   (256'h11C81046037F13C8124611C81041037F13D2124111C810415000037F13F012FF),
    .INIT_06                   (256'h125011C8104B037F13D2124B11C8104B037F13CD124611CD1041037F13CD1246),
    .INIT_07                   (256'h13D2125011CD104B037F13CD125011CD104B037F13CD125011C81050037F13C8),
    .INIT_08                   (256'h037F13C8125A11C81055037F13D2125511C81055037F13D2124F11CE104B037F),
    .INIT_09                   (256'h105F037F13C8126411C8105F037F13D2125A11D21055037F13CD125A11CD1055),
    .INIT_0A                   (256'h11D2105F037F13D2126411CD1064037F13CD126411CD105F037F13CD125F11C8),
    .INIT_0B                   (256'h126E11CD1069037F13CD126911C81069037F13C8126E11C81069037F13D21264),
    .INIT_0C                   (256'h13C8128811C81082037F13D2126E11D21069037F13D2126E11CD106E037F13CD),
    .INIT_0D                   (256'h037F13D2128711CD1087037F13CD128711CD1082037F13CD128211C81082037F),
    .INIT_0E                   (256'h1096037F13D2128F11C8108F037F13C8129311C8108C037F13D2128711D21082),
    .INIT_0F                   (256'h11C8109B037F13CD129B11CD1096037F13C8129B11C81096037F13D2129611C8),
    .INIT_10                   (256'h12A511C810A5037F13C812A511C810A0037F13D212A011C810A0037F13D2129B),
    .INIT_11                   (256'h13D212A411CE10A0037F13D212A511CD10A0037F13CD12A511CD10A0037F13CD),
    .INIT_12                   (256'h037F130A12FF110A1000037F13D212AD11C810AD037F13C812B111C810AA037F),
    .INIT_13                   (256'h1000037F138812FF11881000037F130E12FF110E1000037F130C12FF110C1000),
    .INIT_14                   (256'hD603163CD502D601161ED500150A037F138C12FF118C1000037F138A12FF118A),
    .INIT_15                   (256'hD603163CD502D601161ED500151E0389D603D502151ED601162DD500150A0389),
    .INIT_16                   (256'hD603D502153CD601161ED50015280389D603163CD502D601161ED50015280389),
    .INIT_17                   (256'hD603D502153CD601163CD50015280389D603D502153CD601162DD50015280389),
    .INIT_18                   (256'hD603D502155AD601163CD50015460389D603163CD502D601161ED50015460389),
    .INIT_19                   (256'hD603D5021573D601161ED50015820389D603163CD502D601161ED50015640389),
    .INIT_1A                   (256'h1637D502D6011623D500156E0389D6031623D502156ED601161ED50015730389),
    .INIT_1B                   (256'h1573D601163CD50015820389D603163BD5021573D6011637D500156E0389D603),
    .INIT_1C                   (256'h158CD601161ED50015910389D603D502159BD601161ED50015910389D603D502),
    .INIT_1D                   (256'hD601163CD500158C0389D603163CD502D601161ED500158C0389D603161ED502),
    .INIT_1E                   (256'h163CD500159B0389D603D502159BD601163CD50015910389D603163CD5021591),
    .INIT_1F                   (256'hD50015A00389D603163CD502D601161ED50015A00389D603163CD50215A0D601),
    .INIT_20                   (256'h133C12AA111E10AA037F131E12BE111E10AA0389D603161ED502159BD601161E),
    .INIT_21                   (256'h037F131E12DC111E10C8037F132D12BE111E10BE037F132D12BE112D10AA037F),
    .INIT_22                   (256'h10E6037F131E12FA111E10E6037F133C12E6111E10E6037F133C12D2111E10D2),
    .INIT_23                   (256'h115A1046037F135A125A115A1046037F133C12FA113C10E6037F132D12FA112D),
    .INIT_24                   (256'h12501169105A037F1378125A1169105A037F1378125A11781046037F13781246),
    .INIT_25                   (256'h13781264115A1064037F1369127811691064037F135A1278115A1064037F1369),
    .INIT_26                   (256'h037F13781296115A1096037F13781282115A1082037F13781278115A1078037F),
    .INIT_27                   (256'h10A0037F137812A0115A10A0037F1369128C115A1082037F1369128C115A1096),
    .INIT_28                   (256'h102D5000037F137812B4117810A0037F136912B4116910A0037F135A12B4115A),
    .INIT_29                   (256'h22A5A2A5C560160AA2A1C65016E105E050000318034D02D9037F131E1223111E),
    .INIT_2A                   (256'h05F00389DF03DF01D502950AD50022ACD6021600D50022ACD502950AD50022A9),
    .INIT_2B                   (256'hDF01D502D500950A05E00389D503153C05F0DF01DE02DE000389D503D501153C),
    .INIT_2C                   (256'hD5B4A2CBE2CFD50F9507500062CA22CBDEFF22CBDE0050000389D503153C05F0),
    .INIT_2D                   (256'h9603D5029501D60106C0D500156450009C045000E2D762D7DC1550000F50E2CB),
    .INIT_2E                   (256'h06C0D50015640389D6039602D5029504D601960306C0D500950115640389D603),
    .INIT_2F                   (256'hD6031602D5029504D601160306C0D500950115640389D6031603D5029501D601),
    .INIT_30                   (256'h06C0D500950515640389D6031605D5029507D601960506C0D500950515640389),
    .INIT_31                   (256'hD5029507D601960206C0D500950A156450000389D6039605D5029507D6011605),
    .INIT_32                   (256'h06C0D5009508950A15640389D603D5029508D60106C0D500950C15640389D603),
    .INIT_33                   (256'hD6031601D502D60106C0D5009509950C15640389D6039602D5029502D6019602),
    .INIT_34                   (256'hD5009505156450000389D6031605D502D601960406C0D500950A950A15640389),
    .INIT_35                   (256'h0389D603D502950AD601960706C0D50015640389D6039602D502D601960506C0),
    .INIT_36                   (256'hD601160406C0D500953415640389D603D5029504D60106C0D500952815645000),
    .INIT_37                   (256'hD00050000389D603D5029504D601960406C0D500954015640389D603D5029504),
    .INIT_38                   (256'h15605000238BD5019504D504150150002385D5019504D5041501D303D202D101),
    .INIT_39                   (256'h160506C018F123F9C8600760160506C018F0E3F923F9C8600760960A06C0180F),
    .INIT_3A                   (256'h18F423F9C8600760160506C018F323F9C8600760160506C018F223F9C8600760),
    .INIT_3B                   (256'hC8600760160506C018F623F9C8600760160506C018F523F9C8600760160506C0),
    .INIT_3C                   (256'hD55823DAD55923DAD56023DAD56123DAD56223DAD56323DAD564950A05E023F9),
    .INIT_3D                   (256'h08F0160123F9C76007C006F063E423DAD55423DAD55523DAD55623DAD55723DA),
    .INIT_3E                   (256'h9E0150005000C3EFDA059E01500004021C02C3EADA019E0163DC23E4C680183C),
    .INIT_3F                   (256'h037FD8039807D8029807D701D50050009E015000C3F7DA109E015000C3F3DA08),
    .INIT_40                   (256'h00000000000000005000DA0BDB0A1B001A0150001B012407DBFFDB0A50001902),
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
    .INITP_00                  (256'h0080200802008020080200A00802AAD2280280F4A228AAA3D22DDDA888000000),
    .INITP_01                  (256'h0802008020080200802008020080200802008020080200802008020080200802),
    .INITP_02                  (256'hA222A222A2228A228A22A2228A22008020080200802008020080200802008020),
    .INITP_03                  (256'h8A288A2222A2228888A288A2222A222A2228888A288A2222A2228A22A2228A22),
    .INITP_04                  (256'h2008020080200802008020080200802008020080200802008020080200802888),
    .INITP_05                  (256'h99924A662299924A66226F637D2F76A4A9292AA92A9A8A9AF4D0AA8028020080),
    .INITP_06                  (256'hAA9924A9924A9892A99229A492A692529A252999252A624A9924A99924A66492),
    .INITP_07                  (256'hA22A6D6D6B5A75F51D0F777777777753443443443443443443443D102D22D22A),
    .INITP_08                  (256'h0000000000000000000000000000000000000000000000000000000000A86768),
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
