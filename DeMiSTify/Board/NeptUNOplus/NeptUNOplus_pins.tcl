# Pin & Location Assignments
# ==========================
set_location_assignment PIN_A24 -to LED
set_location_assignment PIN_B14 -to CLOCK_50

set_location_assignment PIN_AE19 -to VGA_R[7]
set_location_assignment PIN_AD19 -to VGA_R[6]
set_location_assignment PIN_AC19 -to VGA_R[5]
set_location_assignment PIN_AF18 -to VGA_R[4]
set_location_assignment PIN_AE18 -to VGA_R[3]
set_location_assignment PIN_AC18 -to VGA_R[2]
set_location_assignment PIN_AD16 -to VGA_R[1]
set_location_assignment PIN_AE15 -to VGA_R[0]
set_location_assignment PIN_AF24 -to VGA_B[7]
set_location_assignment PIN_AC21 -to VGA_B[6]
set_location_assignment PIN_AE23 -to VGA_B[5]
set_location_assignment PIN_AE22 -to VGA_B[4]
set_location_assignment PIN_AD20 -to VGA_B[3]
set_location_assignment PIN_AF20 -to VGA_B[2]
set_location_assignment PIN_AF15 -to VGA_B[1]
set_location_assignment PIN_AC16 -to VGA_B[0]
set_location_assignment PIN_AD21 -to VGA_G[7]
set_location_assignment PIN_AF23 -to VGA_G[6]
set_location_assignment PIN_AF22 -to VGA_G[5]
set_location_assignment PIN_AE21 -to VGA_G[4]
set_location_assignment PIN_AF21 -to VGA_G[3]
set_location_assignment PIN_AF19 -to VGA_G[2]
set_location_assignment PIN_AD17 -to VGA_G[1]
set_location_assignment PIN_AF16 -to VGA_G[0]
set_location_assignment PIN_AD18 -to VGA_VS
set_location_assignment PIN_AE17 -to VGA_HS

# deltasigma DAC
set_location_assignment PIN_AF17 -to AUDIO_L
set_location_assignment PIN_AC17 -to AUDIO_R

# mist - miso / mosi
set_location_assignment PIN_AC14 -to SPI_DO
set_location_assignment PIN_AF12 -to SPI_DI
set_location_assignment PIN_AF11 -to SPI_SCK
set_location_assignment PIN_AC10 -to SPI_SS2
set_location_assignment PIN_AD10 -to SPI_SS3
set_location_assignment PIN_AE9 -to SPI_SS4
set_location_assignment PIN_AD14 -to CONF_DATA0

# sdram
set_location_assignment PIN_L25 -to SDRAM_A[0]
set_location_assignment PIN_L26 -to SDRAM_A[1]
set_location_assignment PIN_M25 -to SDRAM_A[2]
set_location_assignment PIN_M26 -to SDRAM_A[3]
set_location_assignment PIN_N22 -to SDRAM_A[4]
set_location_assignment PIN_N23 -to SDRAM_A[5]
set_location_assignment PIN_N24 -to SDRAM_A[6]
set_location_assignment PIN_M22 -to SDRAM_A[7]
set_location_assignment PIN_M24 -to SDRAM_A[8]
set_location_assignment PIN_L23 -to SDRAM_A[9]
set_location_assignment PIN_K26 -to SDRAM_A[10]
set_location_assignment PIN_L24 -to SDRAM_A[11]
set_location_assignment PIN_K23 -to SDRAM_A[12]
set_location_assignment PIN_B25 -to SDRAM_DQ[0]
set_location_assignment PIN_B26 -to SDRAM_DQ[1]
set_location_assignment PIN_C25 -to SDRAM_DQ[2]
set_location_assignment PIN_C26 -to SDRAM_DQ[3]
set_location_assignment PIN_D25 -to SDRAM_DQ[4]
set_location_assignment PIN_D26 -to SDRAM_DQ[5]
set_location_assignment PIN_E25 -to SDRAM_DQ[6]
set_location_assignment PIN_E26 -to SDRAM_DQ[7]
set_location_assignment PIN_H23 -to SDRAM_DQ[8]
set_location_assignment PIN_G24 -to SDRAM_DQ[9]
set_location_assignment PIN_G22 -to SDRAM_DQ[10]
set_location_assignment PIN_F24 -to SDRAM_DQ[11]
set_location_assignment PIN_F23 -to SDRAM_DQ[12]
set_location_assignment PIN_E24 -to SDRAM_DQ[13]
set_location_assignment PIN_D24 -to SDRAM_DQ[14]
set_location_assignment PIN_C24 -to SDRAM_DQ[15]
set_location_assignment PIN_J25 -to SDRAM_BA[0]
set_location_assignment PIN_J26 -to SDRAM_BA[1]
set_location_assignment PIN_G26 -to SDRAM_nCAS
set_location_assignment PIN_E22 -to SDRAM_CLK
set_location_assignment PIN_K24 -to SDRAM_CKE
set_location_assignment PIN_H26 -to SDRAM_nCS
set_location_assignment PIN_G25 -to SDRAM_nWE
set_location_assignment PIN_H25 -to SDRAM_nRAS
set_location_assignment PIN_H24 -to SDRAM_DQMH
set_location_assignment PIN_F26 -to SDRAM_DQML


# i2s out
set_location_assignment PIN_AD15 -to I2S_LRCK
set_location_assignment PIN_AC15 -to I2S_BCK
set_location_assignment PIN_AE14 -to I2S_DATA

# misc
set_location_assignment PIN_C21 -to AUDIO_IN
