set_global_assignment -name SDC_FILE ${boardpath}/NeptUNOplus/constraints.sdc
# Audio and Jostick support
set_global_assignment -name VERILOG_FILE ${boardpath}/NeptUNOplus/joydecoder.v


set_global_assignment -name VERILOG_MACRO "DEMISTIFY_NEPTUNOPLUS=1"
set_global_assignment -name VERILOG_MACRO "I2S_AUDIO=1"
set_global_assignment -name VERILOG_MACRO "USE_AUDIO_IN=1"
set_global_assignment -name VERILOG_MACRO "USE_CLOCK_50=1"
set_global_assignment -name VERILOG_MACRO "BIG_OSD=1"
set_global_assignment -name VERILOG_MACRO "VGA_8BIT=1"
