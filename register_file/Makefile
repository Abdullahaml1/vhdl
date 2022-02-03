# Module name
MOD := register_file_test_bench

# File to be tested
SRC := register_file.vhd

# Test File
TEST := register_file_test_bench.vhd

# Simulation File name
SIM:= sim.vcd


compile:
	ghdl -s $(SRC)
	ghdl -a $(SRC)
	@echo "original module"


run: compile


	ghdl -s $(TEST)
	@echo "Syntax Correct"

	ghdl -a $(TEST)

	ghdl -e $(MOD)

	ghdl -r $(MOD) --vcd=$(SIM)
	@echo "build run successfully"

sim: run
	gtkwave $(SIM)

