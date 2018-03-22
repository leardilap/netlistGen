onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group in_fifo /tb_top/uut_top/in_fifo/clk
add wave -noupdate -expand -group in_fifo /tb_top/uut_top/in_fifo/srst
add wave -noupdate -expand -group in_fifo /tb_top/uut_top/in_fifo/din
add wave -noupdate -expand -group in_fifo /tb_top/uut_top/in_fifo/wr_en
add wave -noupdate -expand -group in_fifo /tb_top/uut_top/in_fifo/rd_en
add wave -noupdate -expand -group in_fifo /tb_top/uut_top/in_fifo/dout
add wave -noupdate -expand -group in_fifo /tb_top/uut_top/in_fifo/full
add wave -noupdate -expand -group in_fifo /tb_top/uut_top/in_fifo/empty
add wave -noupdate -expand -group in_fifo /tb_top/uut_top/in_fifo/valid
add wave -noupdate -expand -group in_fifo /tb_top/uut_top/in_fifo/wr_rst_busy
add wave -noupdate -expand -group in_fifo /tb_top/uut_top/in_fifo/rd_rst_busy
add wave -noupdate -expand -group kernel /tb_top/uut_top/kernel_inst/clk
add wave -noupdate -expand -group kernel /tb_top/uut_top/kernel_inst/srst
add wave -noupdate -expand -group kernel /tb_top/uut_top/kernel_inst/din
add wave -noupdate -expand -group kernel /tb_top/uut_top/kernel_inst/din_valid
add wave -noupdate -expand -group kernel /tb_top/uut_top/kernel_inst/dout
add wave -noupdate -expand -group kernel /tb_top/uut_top/kernel_inst/dout_valid
add wave -noupdate -expand -group kernel -expand /tb_top/uut_top/kernel_inst/din_pipe
add wave -noupdate -expand -group kernel /tb_top/uut_top/kernel_inst/valid_pipe
add wave -noupdate -expand -group kernel -radix hexadecimal /tb_top/uut_top/kernel_inst/result
add wave -noupdate -expand -group kernel /tb_top/uut_top/kernel_inst/result_shift
add wave -noupdate -expand -group kernel /tb_top/uut_top/kernel_inst/a
add wave -noupdate -expand -group kernel /tb_top/uut_top/kernel_inst/b
add wave -noupdate -expand -group kernel /tb_top/uut_top/kernel_inst/latency
add wave -noupdate -expand -group kernel /tb_top/uut_top/kernel_inst/c_real
add wave -noupdate -expand -group kernel /tb_top/uut_top/kernel_inst/c
add wave -noupdate -expand -group kernel /tb_top/uut_top/kernel_inst/op_mult_inst/CLK
add wave -noupdate -expand -group kernel /tb_top/uut_top/kernel_inst/op_mult_inst/A
add wave -noupdate -expand -group kernel /tb_top/uut_top/kernel_inst/op_mult_inst/B
add wave -noupdate -expand -group kernel /tb_top/uut_top/kernel_inst/op_mult_inst/C
add wave -noupdate -expand -group kernel /tb_top/uut_top/kernel_inst/op_mult_inst/P
add wave -noupdate -expand -group out_fifo /tb_top/uut_top/out_fifo/clk
add wave -noupdate -expand -group out_fifo /tb_top/uut_top/out_fifo/srst
add wave -noupdate -expand -group out_fifo /tb_top/uut_top/out_fifo/din
add wave -noupdate -expand -group out_fifo /tb_top/uut_top/out_fifo/wr_en
add wave -noupdate -expand -group out_fifo /tb_top/uut_top/out_fifo/rd_en
add wave -noupdate -expand -group out_fifo /tb_top/uut_top/out_fifo/dout
add wave -noupdate -expand -group out_fifo /tb_top/uut_top/out_fifo/full
add wave -noupdate -expand -group out_fifo /tb_top/uut_top/out_fifo/empty
add wave -noupdate -expand -group out_fifo /tb_top/uut_top/out_fifo/valid
add wave -noupdate -expand -group out_fifo /tb_top/uut_top/out_fifo/wr_rst_busy
add wave -noupdate -expand -group out_fifo /tb_top/uut_top/out_fifo/rd_rst_busy
add wave -noupdate /tb_top/a
add wave -noupdate /tb_top/b
add wave -noupdate /tb_top/result_kernel
add wave -noupdate -expand /tb_top/res
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {215988068 fs} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 203
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {199240987 fs} {259465282 fs}
