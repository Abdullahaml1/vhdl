# Module name
MOD := bit_latch_bn

# File to be tested
SRC := latch_1.vhd

# Test File
TEST := latch_1_bench.vhd

# Simulation File name
SIM:= sim.vcd


run:
	ghdl -s $(SRC)
	ghdl -s $(TEST)
	@echo "Syntax Correct"

	ghdl -a $(SRC)
	ghdl -a $(TEST)

	ghdl -e $(MOD)

	ghdl -r $(MOD) --vcd=$(SIM)
	@echo "build run successfully"

