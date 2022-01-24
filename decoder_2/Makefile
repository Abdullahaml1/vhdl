# Module name
MOD := decoder_2_bench

# File to be tested
SRC := decoder_2.vhd

# Test File
TEST := decoder_2_bench.vhd

# Simulation File name
SIM:= sim.vcd


run:
	ghdl -s $(SRC)
	ghdl -a $(SRC)
	@echo "original modules"

	ghdl -s $(TEST)
	@echo "Syntax Correct"

	ghdl -a $(TEST)

	ghdl -e $(MOD)

	ghdl -r $(MOD) --vcd=$(SIM)
	@echo "build run successfully"

