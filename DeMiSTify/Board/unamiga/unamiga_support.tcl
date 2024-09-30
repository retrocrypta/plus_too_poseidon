set_global_assignment -name SDC_FILE ${boardpath}/unamiga/constraints.sdc

set_global_assignment -name VERILOG_MACRO "DEMISTIFY_UNAMIGA=1"
set_global_assignment -name VERILOG_MACRO "I2S_AUDIO=1"
set_global_assignment -name VERILOG_MACRO "USE_CLOCK_50=1"
