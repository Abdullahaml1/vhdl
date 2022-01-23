ghdl -s latch_1.vhd
ghdl -s latch_1_bench.vhd


ghdl -a latch_1.vhd
ghdl -a latch_1_bench.vhd

ghdl -e bit_latch_bn

ghdl -r bit_latch_bn --vcd=sim.vcd
