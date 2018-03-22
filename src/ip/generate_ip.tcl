set xci_file [lindex $argv 0]
set base_name [file rootname [file tail $xci_file]]

set_part xcku15p-ffva1760-2-e
set_property -name "target_language" -value "VHDL" -objects [current_project]
read_ip $xci_file
report_ip_status
set_property GENERATE_SYNTH_CHECKPOINT TRUE [get_files $xci_file] 
synth_ip [get_ips $base_name]
open_checkpoint $base_name.dcp
write_edif $base_name.edf -force
write_vhdl $base_name.vhd -force
