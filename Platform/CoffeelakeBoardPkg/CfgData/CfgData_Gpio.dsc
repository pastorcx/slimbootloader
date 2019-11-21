## @file
#
#  Copyright (c) 2018, Intel Corporation. All rights reserved.<BR>
#  SPDX-License-Identifier: BSD-2-Clause-Patent
##
  # ---------------------------------------------------------------------------------------
  # !BSF PAGE:{GIO}
  # !BSF SUBT:{CFGHDR_TMPL:GPIO_CFG_DATA:1:0}  //Flags - bit 12 (Reuse config from base platform ID) is set to 1

  # !HDR HEADER:{OFF}
  # !HDR EMBED:{GPIO_CFG_DATA:TAG_400:START}


  # !HDR HEADER:{ON}
  # !HDR EMBED:{GPIO_CFG_HDR:GpioCfgHdr:START}
  gCfgData.GpioHeaderSize         |      * | 0x01  | _LENGTH_GPIO_CFG_HDR_
  gCfgData.GpioBaseTableId        |      * | 0x01  | 0xFF
  gCfgData.GpioItemSize           |      * | 0x02  | 8
  gCfgData.GpioItemCount          |      * | 0x02  | (_LENGTH_GPIO_CFG_DATA_ - _LENGTH_GPIO_CFG_HDR_) / 8

  # Bit start offset within each GPIO entry array to identify a GPIO pin uniquely. EX: GPIO group id + pad id
  # Offset is 2nd DWORD BIT16 = 1 * 32 + 16 = 48
  gCfgData.GpioItemIdBitOff       |      * | 0x01  | 48
  # Bit length within each GPIO entry array to identify a GPIO pin uniquely.
  # Length is 2nd DWORD BIT16 to BIT28 = 13
  gCfgData.GpioItemIdBitLen       |      * | 0x01  | 13
  # Bit offset within each GPIO entry array to indicate SKIP a GPIO programming
  # Offset is 2nd DWORD BIT31 = 63
  gCfgData.GpioItemValidBitOff    |      * | 0x01  | 63
  gCfgData.GpioItemUnused         |      * | 0x01  | 0

  # Need 1 bit per GPIO. So this mask byte length needs to be at least (GpioNumber + 7) / 8
  # Padding can be added to let the whole length aligned at DWORD boundary
  gCfgData.GpioBaseTableBitMask   |      * |   34  | {0}

  gCfgData.GpioTableData          |      * |    0  | 0
  # !HDR EMBED:{GPIO_CFG_HDR:GpioCfgHdr:END}
  # !HDR HEADER:{OFF}

  # GPIO Template:GPIO_TMPL structure

  # Dword1: GpioPADConfig DW0
  # UINT32  PadMode         :  5;      // [4:0]     #GPIO PadMode
  # UINT32  HostSoftPadOwn  :  2;      // [6:5]     #GPIO HostSoftPadOwn
  # UINT32  Direction       :  6;      // [12:7]    #GPIO Direction
  # UINT32  OutputState     :  2;      // [14:13]   #GPIO OutputState
  # UINT32  InterruptConfig :  9;      // [23:15]   #GPIO InterruptConfig
  # UINT32  PowerConfig     :  8;      // [32:24]   #PowerConfig

  # Dword2: GpioPADConfig DW1
  # UINT32  ElectricalConfig:  9;      // [8:0]     #GPIO ElectricalConfig
  # UINT32  LockConfig      :  4;      // [12:9]    #GPIO LockConfig
  # UINT32  Other Settings  :  3;      // [15:13]   #Other Settings
  # UINT32  PadNum          :  8;      // [23:16]   #Pad Number
  # UINT32  GrpIdx          :  5;      // [28:24]   #Group Index
  # UINT32  Rsvd Bits       :  1;      // [29]      #Reserved/Unused
  # UINT32  Hide Bit        :  1;      // [30]      #Reserved/Hide
  # UINT32  GPIOSKip        :  1;      // [31]      #Used by the CfgDataTool to check whether to include or skip GPIO programming
                                                    #Bit 31 is used for GPIOSkip field for CfgMergeTool to indicate to skip/include the GPIO in the final GPIOTbl.

#                               DW0       : DW1      :               Native Function 1                    :                   Native Function 2               :                   Native Function 3               : Native Function 4
# !BSF SUBT:{GPIO_TMPL:GPP_A00: 0x03502381: 0x80002001: RCIN#                                             : PCH_H = N/A   PCH_LP = TIME_SYNC1                 : PCH_H = ESPI_ALERT1#   PCH_LP = N/A               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_A01: 0x03502387: 0x80012019: LAD0                                              : PCH_H = N/A   PCH_LP = ESPI_IO0                   : PCH_H = ESPI_IO0   PCH_LP = N/A                   : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_A02: 0x03502387: 0x80022019: LAD1                                              : PCH_H = N/A   PCH_LP = ESPI_IO1                   : PCH_H = ESPI_IO1   PCH_LP = N/A                   : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_A03: 0x03502387: 0x80032019: LAD2                                              : PCH_H = N/A   PCH_LP = ESPI_IO2                   : PCH_H = ESPI_IO2   PCH_LP = N/A                   : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_A04: 0x03502387: 0x80042019: LAD3                                              : PCH_H = N/A   PCH_LP = ESPI_IO3                   : PCH_H = ESPI_IO3   PCH_LP = N/A                   : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_A05: 0x03502387: 0x80052019: LFRAME#                                           : PCH_H = N/A   PCH_LP = ESPI_CS#                   : PCH_H = ESPI_CS0#   PCH_LP = N/A                  : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_A06: 0x03502381: 0x80062001: SERIRQ                                            : N/A                                               : PCH_H = ESPI_CS1#   PCH_LP = N/A                  : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_A07: 0x03502381: 0x80072001: PIRQA#                                            : PCH_H = N/A   PCH_LP = GSPI0_CS1#                 : PCH_H = ESPI_ALERT0#   PCH_LP = N/A               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_A08: 0x03502381: 0x80082001: CLKRUN#                                           : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_A09: 0x03502387: 0x80092009: CLKOUT_LPC0                                       : PCH_H = N/A   PCH_LP = ESPI_CLK                   : PCH_H = ESPI_CLK   PCH_LP = N/A                   : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_A10: 0x03502381: 0x800A2001: CLKOUT_LPC1                                       : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_A11: 0x03502381: 0x800B2001: PME#                                              : PCH_H = SD_VDD2_PWR_EN#   PCH_LP = GSPI1_CS1#     : PCH_H = N/A   PCH_LP = SD_VDD2_PWR_EN#            : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_A12: 0x03502381: 0x800C2001: BM_BUSY#                                          : ISH_GP6                                           : SX_EX-                                            : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_A13: 0x03502381: 0x800D2001: PCH_H = SUSWARN#   PCH_LP = SUSWARN#/SUSPWRDNACK  : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_A14: 0x03502387: 0x800E2001: SUS_STAT#                                         : PCH_H = N/A   PCH_LP = ESPI_RESET#                : PCH_H = ESPI_RESET#   PCH_LP = N/A                : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_A15: 0x03502381: 0x800F2001: SUSACK#                                           : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_A16: 0x03502381: 0x80102001: PCH_H = CLKOUT_48   PCH_LP = SD_1P8_SEL           : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_A17: 0x03502381: 0x80112001: SD_VDD1_PWR_EN#                                   : ISH_GP7                                           : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_A18: 0x03502381: 0x80122001: ISH_GP0                                           : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_A19: 0x03502381: 0x80132001: ISH_GP1                                           : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_A20: 0x03502381: 0x80142001: ISH_GP2                                           : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_A21: 0x0500E2E1: 0x00150001: ISH_GP3                                           : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_A22: 0x0500E2E1: 0x00160001: ISH_GP4                                           : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_A23: 0x051885E1: 0x00170001: ISH_GP5                                           : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_B00: 0x03502381: 0x81002001: PCH_H = GSPI0_CS1#   PCH_LP = Reserved            : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_B01: 0x03502381: 0x81012001: PCH_H = GSPI1_CS1#   PCH_LP = Reserved            : PCH_H = TIME_SYNC1   PCH_LP = N/A                 : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_B02: 0x05188DE1: 0x01020001: VRALERT#                                          : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_B03: 0x0300E2E1: 0x01031801: CPU_GP2                                           : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_B04: 0x03502381: 0x81042001: CPU_GP3                                           : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_B05: 0x03502381: 0x81052001: SRCCLKREQ0#                                       : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_B06: 0x03502383: 0x81062001: SRCCLKREQ1#                                       : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_B07: 0x03502383: 0x81072001: SRCCLKREQ2#                                       : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_B08: 0x050062E1: 0x01080001: SRCCLKREQ3#                                       : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_B09: 0x03502383: 0x81092001: SRCCLKREQ4#                                       : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_B10: 0x03502381: 0x810A2001: SRCCLKREQ5#                                       : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_B11: 0x03502381: 0x810B2001: PCH_H = I2S_MCLK   PCH_LP = EXT_PWR_GATE#         : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_B12: 0x03502383: 0x810C2001: SLP_S0#                                           : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_B13: 0x03502383: 0x810D2001: PLTRST#                                           : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_B14: 0x03502281: 0x810E2001: SPKR                                              : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_B15: 0x03502381: 0x810F2001: GSPI0_CS0#                                        : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_B16: 0x03502381: 0x81102001: GSPI0_CLK                                         : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_B17: 0x03502381: 0x81112001: GSPI0_MISO                                        : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_B18: 0x03502281: 0x81122001: GSPI0_MOSI                                        : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_B19: 0x03502381: 0x81132001: GSPI1_CS0#                                        : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_B20: 0x03502381: 0x81142001: GSPI1_CLK                                         : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_B21: 0x03502381: 0x81152001: GSPI1_MISO                                        : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_B22: 0x03502281: 0x81162001: GSPI1_MOSI                                        : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_B23: 0x03502281: 0x81172001: SML1ALERT#                                        : PCHHOT#                                           : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_C00: 0x03502383: 0x82002001: SMBCLK                                            : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_C01: 0x03502383: 0x82012001: SMBDATA                                           : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_C02: 0x050062E1: 0x02020001: SMBALERT#                                         : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_C03: 0x03502383: 0x82032001: SML0CLK                                           : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_C04: 0x03502383: 0x82042001: SML0DATA                                          : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_C05: 0x03502281: 0x82052001: SML0ALERT#                                        : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_C06: 0x03502381: 0x82062001: SML1CLK                                           : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_C07: 0x03502381: 0x82072001: SML1DATA                                          : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_C08: 0x03502381: 0x82082001: PCH_H = UART0A_RXD   PCH_LP = UART0_RXD           : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_C09: 0x03502381: 0x82092001: PCH_H = UART0A_TXD   PCH_LP = UART0_TXD           : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_C10: 0x03502381: 0x820A2001: PCH_H = UART0A_RTS#   PCH_LP = UART0_RTS#         : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_C11: 0x03502381: 0x820B2001: PCH_H = UART0A_CTS#   PCH_LP = UART0_CTS#         : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_C12: 0x03502381: 0x820C2001: UART1_RXD                                         : ISH_UART1_RXD                                     : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_C13: 0x03502381: 0x820D2001: UART1_TXD                                         : ISH_UART1_TXD                                     : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_C14: 0x03502381: 0x820E2001: UART1_RTS#                                        : ISH_UART1_RTS#                                    : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_C15: 0x03502381: 0x820F2001: UART1_CTS#                                        : ISH_UART1_CTS#                                    : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_C16: 0x03502383: 0x82102001: I2C0_SDA                                          : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_C17: 0x03502383: 0x82112001: I2C0_SCL                                          : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_C18: 0x03502383: 0x82122001: I2C1_SDA                                          : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_C19: 0x03502383: 0x82132001: I2C1_SCL                                          : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_C20: 0x03502381: 0x82142001: UART2_RXD                                         : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_C21: 0x03502381: 0x82152001: UART2_TXD                                         : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_C22: 0x03502381: 0x82162001: UART2_RTS#                                        : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_C23: 0x03502381: 0x82172001: UART2_CTS#                                        : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_D00: 0x03502381: 0x83002001: SPI1_CS#                                          : PCH_H = N/A   PCH_LP = BK0                        : SBK0                                              : PCH_H = BK0}
# !BSF SUBT:{GPIO_TMPL:GPP_D01: 0x03502381: 0x83012001: SPI1_CLK                                          : PCH_H = N/A   PCH_LP = BK1                        : SBK1                                              : PCH_H = BK1}
# !BSF SUBT:{GPIO_TMPL:GPP_D02: 0x03502381: 0x83022001: SPI1_MISO                                         : PCH_H = N/A   PCH_LP = BK2                        : SBK2                                              : PCH_H = BK2}
# !BSF SUBT:{GPIO_TMPL:GPP_D03: 0x03502381: 0x83032001: SPI1_MOSI                                         : PCH_H = N/A   PCH_LP = BK3                        : SBK3                                              : PCH_H = BK3}
# !BSF SUBT:{GPIO_TMPL:GPP_D04: 0x03502381: 0x83042001: PCH_H = ISH_I2C2_SDA   PCH_LP = IMGCLKOUT0        : PCH_H = I2C3_SDA   PCH_LP = BK4                   : SBK4                                              : PCH_H = BK4}
# !BSF SUBT:{GPIO_TMPL:GPP_D05: 0x03502387: 0x83052001: PCH_H = I2S2_SFRM   PCH_LP = ISH_I2C0_SDA         : N/A                                               : PCH_H = CNV_RF_RESET#   PCH_LP = N/A              : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_D06: 0x03502387: 0x83062001: PCH_H = I2S2_TXD   PCH_LP = ISH_I2C0_SCL          : N/A                                               : PCH_H = MODEM_CLKREQ   PCH_LP = N/A               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_D07: 0x03502381: 0x83072001: PCH_H = I2S2_RXD   PCH_LP = ISH_I2C1_SDA          : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_D08: 0x03502381: 0x83082001: PCH_H = I2S2_SCLK   PCH_LP = ISH_I2C1_SCL         : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_D09: 0x03502381: 0x83092001: ISH_SPI_CS#                                       : N/A                                               : GSPI2_CS0#                                        : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_D10: 0x03502381: 0x830A2001: ISH_SPI_CLK                                       : N/A                                               : GSPI2_CLK                                         : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_D11: 0x03502385: 0x830B2001: ISH_SPI_MISO                                      : PCH_H = GP_BSSB_CLK   PCH_LP = N/A                : GSPI2_MISO                                        : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_D12: 0x03502385: 0x830C2001: ISH_SPI_MOSI                                      : PCH_H = GP_BSSB_DI   PCH_LP = N/A                 : GSPI2_MOSI                                        : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_D13: 0x03502381: 0x830D2001: ISH_UART0_RXD                                     : PCH_H = N/A   PCH_LP = SML0BDATA                  : PCH_H = I2C2_SDA   PCH_LP = I2C4B_SDA             : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_D14: 0x03502381: 0x830E2001: ISH_UART0_TXD                                     : PCH_H = N/A   PCH_LP = SML0BCLK                   : PCH_H = I2C2_SCL   PCH_LP = I2C4B_SCL             : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_D15: 0x03502381: 0x830F2001: ISH_UART0_RTS#                                    : GSPI2_CS1#                                        : N/A                                               : PCH_H = CNV_WFEN}
# !BSF SUBT:{GPIO_TMPL:GPP_D16: 0x03502381: 0x83102001: ISH_UART0_CTS#                                    : PCH_H = N/A   PCH_LP = SML0BALERT#                : N/A                                               : PCH_H = CNV_WCEN}
# !BSF SUBT:{GPIO_TMPL:GPP_D17: 0x03502383: 0x83112001: DMIC_CLK1                                         : SNDW3_CLK                                         : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_D18: 0x03502383: 0x83122001: DMIC_DATA1                                        : SNDW3_DATA                                        : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_D19: 0x03502383: 0x83132001: DMIC_CLK0                                         : SNDW4_CLK                                         : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_D20: 0x03502383: 0x83142001: DMIC_DATA0                                        : SNDW4_DATA                                        : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_D21: 0x03502381: 0x83152001: SPI1_IO2                                          : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_D22: 0x03502381: 0x83162001: SPI1_IO3                                          : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_D23: 0x03502381: 0x83172001: PCH_H = ISH_I2C2_SCL   PCH_LP = I2S_MCLK          : PCH_H = I2C3_SCL   PCH_LP = N/A                   : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_E00: 0x03502383: 0x84002001: SATAXPCIE0                                        : SATAGP0                                           : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_E01: 0x03502383: 0x84012001: SATAXPCIE1                                        : SATAGP1                                           : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_E02: 0x03502383: 0x84022001: SATAXPCIE2                                        : SATAGP2                                           : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_E03: 0x03502381: 0x84032001: CPU_GP0                                           : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_E04: 0x03502381: 0x84042001: SATA_DEVSLP0                                      : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_E05: 0x03502381: 0x84052001: SATA_DEVSLP1                                      : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_E06: 0x03502381: 0x84062001: SATA_DEVSLP2                                      : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_E07: 0x03502381: 0x84072001: CPU_GP1                                           : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_E08: 0x03502381: 0x84082001: SATALED#                                          : PCH_H = N/A   PCH_LP = SPI1_CS1#                  : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_E09: 0x03502383: 0x84092001: USB2_OC0#                                         : PCH_H = N/A   PCH_LP = GP_BSSB_CLK                : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_E10: 0x03502383: 0x840A2001: USB2_OC1#                                         : PCH_H = N/A   PCH_LP = GP_BSSB_DI                 : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_E11: 0x03502383: 0x840B2001: USB2_OC2#                                         : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_E12: 0x03502383: 0x840C2001: USB2_OC3#                                         : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_E13: 0x00000000: 0x840D0000: PCH_LP = DDPB_HPD0                                : PCH_LP = DISP_MISC0                               : PCH_LP = N/A                                      : N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_E14: 0x00000000: 0x840E0000: PCH_LP = DDPC_HPD1                                : PCH_LP = DISP_MISC1                               : PCH_LP = N/A                                      : N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_E15: 0x00000000: 0x840F0000: PCH_LP = DDPD_HPD2                                : PCH_LP = DISP_MISC2                               : PCH_LP = N/A                                      : N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_E16: 0x00000000: 0x84100000: PCH_LP = N/A                                      : PCH_LP = DISP_MISC3                               : PCH_LP = N/A                                      : N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_E17: 0x00000000: 0x84110000: PCH_LP = EDP_HPD                                  : PCH_LP = DISP_MISC4                               : PCH_LP = N/A                                      : N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_E18: 0x00000000: 0x84120000: PCH_LP = DPPB_CTRLCLK                             : PCH_LP = N/A                                      : PCH_LP = CNV_BT_HOST_WAKE#                        : N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_E19: 0x00000000: 0x84130000: PCH_LP = DPPB_CTRLDATA                            : PCH_LP = N/A                                      : PCH_LP = CNV_BT_IF_SELECT                         : N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_E20: 0x00000000: 0x84140000: PCH_LP = DPPC_CTRLCLK                             : PCH_LP = N/A                                      : PCH_LP = N/A                                      : N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_E21: 0x00000000: 0x84150000: PCH_LP = DPPC_CTRLDATA                            : PCH_LP = N/A                                      : PCH_LP = N/A                                      : N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_E22: 0x00000000: 0x84160000: PCH_LP = DPPD_CTRLCLK                             : PCH_LP = N/A                                      : PCH_LP = N/A                                      : N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_E23: 0x00000000: 0x84170000: PCH_LP = DPPD_CTRLDATA                            : PCH_LP = N/A                                      : PCH_LP = N/A                                      : N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_F00: 0x03502383: 0x85002001: PCH_H = SATAXPCIE3   PCH_LP = CNV_PA_BLANKING     : PCH_H = SATAGP3   PCH_LP = N/A                    : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_F01: 0x03502383: 0x85012019: PCH_H = SATAXPCIE4   PCH_LP = N/A                 : PCH_H = SATAGP4   PCH_LP = N/A                    : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_F02: 0x050062E1: 0x05020001: PCH_H = SATAXPCIE5   PCH_LP = N/A                 : PCH_H = SATAGP5   PCH_LP = N/A                    : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_F03: 0x03502383: 0x85032001: PCH_H = SATAXPCIE6   PCH_LP = N/A                 : PCH_H = SATAGP6   PCH_LP = N/A                    : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_F04: 0x03502383: 0x85042001: PCH_H = SATAXPCIE7   PCH_LP = CNV_BRI_DT          : PCH_H = SATAGP7   PCH_LP = UART0_RTS#             : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_F05: 0x051885A1: 0x05050019: PCH_H = SATA_DEVSLP3   PCH_LP = CNV_BRI_RSP       : PCH_H = N/A   PCH_LP = UART0_RXD                  : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_F06: 0x03502381: 0x85062001: PCH_H = SATA_DEVSLP4   PCH_LP = CNV_RGI_DT        : PCH_H = N/A   PCH_LP = UART0_TXD                  : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_F07: 0x050062E1: 0x05070001: PCH_H = SATA_DEVSLP5   PCH_LP = CNV_RGI_RSP       : PCH_H = N/A   PCH_LP = UART0_CTS#                 : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_F08: 0x05506281: 0x85082001: PCH_H = SATA_DEVSLP6   PCH_LP = CNV_MFUART2_RXD   : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_F09: 0x05006DE1: 0x05090001: PCH_H = SATA_DEVSLP7   PCH_LP = CNV_MFUART2_TXD   : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_F10: 0x050005E1: 0x050A0001: PCH_H = SATA_SCLOCK   PCH_LP = N/A                : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_F11: 0x03502381: 0x850B2001: PCH_H = SATA_SLOAD   PCH_LP = EMMC_CMD            : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_F12: 0x050005E1: 0x050C0001: PCH_H = SATA_S-   PCH_LP = EMMC_DATA0             : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_F13: 0x03502381: 0x850D2001: PCH_H = SATA_S-   PCH_LP = EMMC_DATA1             : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_F14: 0x03502385: 0x850E2001: PCH_H = N/A   PCH_LP = EMMC_DATA2                 : PCH_H = PS_ON#   PCH_LP = N/A                     : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_F15: 0x03502383: 0x850F2001: PCH_H = USB2_OC4#   PCH_LP = EMMC_DATA3           : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_F16: 0x03502383: 0x85102001: PCH_H = USB2_OC5#   PCH_LP = EMMC_DATA4           : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_F17: 0x03502383: 0x85112001: PCH_H = USB2_OC6#   PCH_LP = EMMC_DATA5           : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_F18: 0x050062E1: 0x05120001: PCH_H = USB2_OC7#   PCH_LP = EMMC_DATA6           : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_F19: 0x03502383: 0x85132001: PCH_H = eDP_VDDEN   PCH_LP = EMMC_DATA7           : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_F20: 0x03502383: 0x85142001: PCH_H = eDP_BKLTEN   PCH_LP = EMMC_RCLK           : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_F21: 0x03502383: 0x85152001: PCH_H = eDP_BKLTCTL   PCH_LP = EMMC_CLK           : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_F22: 0x05506283: 0x85162001: PCH_H = DDPF_CTRLCLK   PCH_LP = EMMC_RESET#       : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_F23: 0x050062E1: 0x05170001: PCH_H = DDPF_C-   PCH_LP = A4WP_PRESENT           : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_G00: 0x03502381: 0x86002001: SD_CMD                                            : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_G01: 0x03502381: 0x86012001: SD_DATA0                                          : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_G02: 0x03502381: 0x86022001: SD_DATA1                                          : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_G03: 0x03502381: 0x86032001: SD_DATA2                                          : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_G04: 0x03502381: 0x86042001: SD_DATA3                                          : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_G05: 0x03502381: 0x86052001: PCH_H = SD_CD#   PCH_LP = SD3_CD#                 : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_G06: 0x03502381: 0x86062001: PCH_H = SD_CLK   PCH_LP = SD3_CLK                 : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_G07: 0x03502381: 0x86072001: PCH_H = SD_WP   PCH_LP = SD3_WP                   : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_H00: 0x03502383: 0x87002001: PCH_H = SRCCLKREQ6#   PCH_LP = I2S2_SCLK          : PCH_H = N/A   PCH_LP = CNV_BT_I2S_SCLK            : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_H01: 0x03502383: 0x87012001: PCH_H = SRCCLKREQ7#   PCH_LP = I2S2_SFRM          : PCH_H = N/A   PCH_LP = CNV_BT_I2S_BCLK            : PCH_H = N/A   PCH_LP = CNV_RF_RESET#              : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_H02: 0x03502383: 0x87022001: PCH_H = SRCCLKREQ8#   PCH_LP = I2S2_TXD           : PCH_H = N/A   PCH_LP = CNV_BT_I2S_SDI             : PCH_H = N/A   PCH_LP = MODEM_CLKREQ               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_H03: 0x03502381: 0x87032001: PCH_H = SRCCLKREQ9#   PCH_LP = I2S2_RXD           : PCH_H = N/A   PCH_LP = CNV_BT_I2S_SDO             : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_H04: 0x03502383: 0x87042001: PCH_H = SRCCLKREQ10#   PCH_LP = I2C2_SDA          : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_H05: 0x03502381: 0x87052001: PCH_H = SRCCLKREQ11#   PCH_LP = I2C2_SCL          : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_H06: 0x050005E1: 0x07060001: PCH_H = SRCCLKREQ12#   PCH_LP = I2C3_SDA          : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_H07: 0x050062E1: 0x07070001: PCH_H = SRCCLKREQ13#   PCH_LP = I2C3_SCL          : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_H08: 0x03502381: 0x87082001: PCH_H = SRCCLKREQ14#   PCH_LP = I2C4_SDA          : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_H09: 0x03502381: 0x87092001: PCH_H = SRCCLKREQ15#   PCH_LP = I2C4_SCL          : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_H10: 0x0500E2E1: 0x070A0001: PCH_H = SML2CLK   PCH_LP = I2C5_SDA               : PCH_H = N/A   PCH_LP = ISH_I2C2_SDA               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_H11: 0x03502381: 0x870B2001: PCH_H = SML2DATA   PCH_LP = I2C5_SCL              : PCH_H = N/A   PCH_LP = ISH_I2C2_SCL               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_H12: 0x03502281: 0x870C2001: PCH_H = SML2ALERT#   PCH_LP = M2_SKT2_CFG0        : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_H13: 0x03502381: 0x870D2001: PCH_H = SML3CLK   PCH_LP = M2_SKT2_CFG1           : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_H14: 0x03502381: 0x870E2001: PCH_H = SML3DATA   PCH_LP = M2_SKT2_CFG2          : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_H15: 0x03148DA1: 0x070F0601: PCH_H = SML3ALERT#   PCH_LP = M2_SKT2_CFG3        : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_H16: 0x053485A1: 0x07100601: PCH_H = SML4CLK   PCH_LP = N/A                    : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_H17: 0x0500E2E1: 0x07110001: PCH_H = SML4DATA   PCH_LP = N/A                   : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_H18: 0x050005E1: 0x07120001: PCH_H = SML4ALERT#   PCH_LP = CPU_C10_GATE#       : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_H19: 0x03502381: 0x87132001: PCH_H = ISH_I2C0_SDA   PCH_LP = TIME_SYNC0        : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_H20: 0x03502381: 0x87142001: PCH_H = ISH_I2C0_SCL   PCH_LP = IMGCLKOUT1        : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_H21: 0x03502381: 0x87152001: PCH_H = ISH_I2C1_SDA   PCH_LP = N/A               : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_H22: 0x03502381: 0x87162001: PCH_H = ISH_I2C1_SCL   PCH_LP = N/A               : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_H23: 0x050022E1: 0x07170001: PCH_H = TIME_SYNC0   PCH_LP = N/A                 : N/A                                               : N/A                                               : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_I00: 0x03502383: 0x88002001: PCH_H = DDPB_HPD0                                 : PCH_H = DISP_MISC0                                : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_I01: 0x03502383: 0x88012001: PCH_H = DDPC_HPD1                                 : PCH_H = DISP_MISC1                                : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_I02: 0x03502383: 0x88022001: PCH_H = DDPD_HPD2                                 : PCH_H = DISP_MISC2                                : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_I03: 0x053285A1: 0x08030001: PCH_H = DDPF_HPD3                                 : PCH_H = DISP_MISC3                                : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_I04: 0x03502383: 0x88042001: PCH_H = EDP_HPD                                   : PCH_H = DISP_MISC4                                : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_I05: 0x050062E1: 0x08050001: PCH_H = DDPB_CTRLCLK                              : PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_I06: 0x03502281: 0x88062001: PCH_H = DDPB_CTRLDATA                             : PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_I07: 0x03502383: 0x88072001: PCH_H = DDPC_CTRLCLK                              : PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_I08: 0x03502283: 0x88082001: PCH_H = DDPC_CTRLDATA                             : PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_I09: 0x0300E2E1: 0x08091801: PCH_H = DDPD_CTRLCLK                              : PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_I10: 0x05506283: 0x880A2001: PCH_H = DDPD_CTRLDATA                             : PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_I11: 0x03502381: 0x880B2001: PCH_H = M2_SKT2_CFG0                              : PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_I12: 0x05148DA1: 0x080C0601: PCH_H = M2_SKT2_CFG1                              : PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_I13: 0x03502381: 0x880D2001: PCH_H = M2_SKT2_CFG2                              : PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_I14: 0x05148DA1: 0x080E0601: PCH_H = M2_SKT2_CFG3                              : PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_J00: 0x03502381: 0x89002001: PCH_H = CNV_PA_BLANKING                           : PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_J01: 0x03502385: 0x89012001: PCH_H = N/A                                       : PCH_H = CPU_C10_GATE#                             : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_J02: 0x03502381: 0x89022001: PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_J03: 0x03502381: 0x89032001: PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_J04: 0x03502385: 0x89042001: PCH_H = CNV_BRI_DT                                : PCH_H = UART0B_RTS#                               : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_J05: 0x03502385: 0x89052019: PCH_H = CNV_BRI_RSP                               : PCH_H = UART0B_RXD                                : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_J06: 0x03502385: 0x89062001: PCH_H = CNV_RGI_DT                                : PCH_H = UART0B_TXD                                : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_J07: 0x03502385: 0x89072019: PCH_H = CNV_RGI_RSP                               : PCH_H = UART0B_CTS#                               : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_J08: 0x03502381: 0x89082001: PCH_H = CNV_M-                                    : PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_J09: 0x03502281: 0x89092001: PCH_H = CNV_M-                                    : PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_J10: 0x0500E2E1: 0x090A0001: PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_J11: 0x03502383: 0x890B2009: PCH_H = A4WP_PRESENT                              : PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_K00: 0x050005E1: 0x0A000001: PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_K01: 0x03506281: 0x8A012017: PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_K02: 0x050005E1: 0x0A020001: PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_K03: 0x05148DA1: 0x0A030619: PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_K04: 0x050022E1: 0x0A040001: PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_K05: 0x050005E1: 0x0A050001: PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_K06: 0x050005E1: 0x0A060201: PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_K07: 0x050005E1: 0x0A070001: PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_K08: 0x050062E1: 0x0A080001: PCH_H = Reserved                                  : PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_K09: 0x03502383: 0x8A092001: PCH_H = Reserved                                  : PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_K10: 0x03506281: 0x8A0A2001: PCH_H = Reserved                                  : PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_K11: 0x03502383: 0x8A0B2001: PCH_H = Reserved                                  : PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_K12: 0x05348DA1: 0x0A0C0601: PCH_H = GSXDOUT                                   : PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_K13: 0x050062E1: 0x0A0D0001: PCH_H = GSXSLOAD                                  : PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_K14: 0x030022E1: 0x0A0E0001: PCH_H = GSXDIN                                    : PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_K15: 0x030022E1: 0x0A0F0001: PCH_H = GSXSRESET#                                : PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_K16: 0x050022E1: 0x0A100001: PCH_H = GSXCLK                                    : PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_K17: 0x050062E1: 0x0A110001: PCH_H = ADR_COMPLETE                              : PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_K18: 0x050005E1: 0x0A120001: PCH_H = NMI#                                      : PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_K19: 0x03502381: 0x8A132001: PCH_H = SMI#                                      : PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_K20: 0x050005E1: 0x0A140001: PCH_H = Reserved                                  : PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_K21: 0x050005E1: 0x0A150001: PCH_H = Reserved                                  : PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_K22: 0x05506281: 0x8A162001: PCH_H = IMGCLKOUT0                                : PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_K23: 0x050062E1: 0x0A170001: PCH_H = IMGCLKOUT1                                : PCH_H = N/A                                       : PCH_H = N/A                                       : PCH_H = N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_d00: 0x07502383: 0x8B002001: N/A                                               : N/A                                               : N/A                                               : N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_d01: 0x07502383: 0x8B01201F: N/A                                               : N/A                                               : N/A                                               : N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_d02: 0x07502383: 0x8B02201F: N/A                                               : N/A                                               : N/A                                               : N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_d03: 0x07502383: 0x8B032019: N/A                                               : N/A                                               : N/A                                               : N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_d04: 0x07502283: 0x8B042001: N/A                                               : N/A                                               : N/A                                               : N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_d05: 0x07502283: 0x8B052001: N/A                                               : N/A                                               : N/A                                               : N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_d06: 0x07502283: 0x8B062001: N/A                                               : N/A                                               : N/A                                               : N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_d07: 0x07502281: 0x8B072001: N/A                                               : N/A                                               : N/A                                               : N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_d08: 0x07502383: 0x8B082001: N/A                                               : N/A                                               : N/A                                               : N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_d09: 0x07502283: 0x8B092001: N/A                                               : N/A                                               : N/A                                               : N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_d10: 0x07502283: 0x8B0A2001: N/A                                               : N/A                                               : N/A                                               : N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_d11: 0x07502283: 0x8B0B2001: N/A                                               : N/A                                               : N/A                                               : N/A}
# !BSF SUBT:{GPIO_TMPL:GPP_PEC: 0x00000000: 0x8C040009: N/A                                               : N/A                                               : N/A                                               : N/A}

  # !HDR EMBED:{GPIO_CFG_DATA:TAG_400:END}

  # !HDR HEADER:{ON}