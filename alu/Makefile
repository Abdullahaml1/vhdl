# Module name
MOD := alu_test_bench

# File to be tested
SRC := alu.vhd

# Test File
TEST := alu_test_bench.vhd

# Simulation File name
SIM:= sim.vcd


run:
	ghdl -s $(SRC)
	ghdl -a $(SRC)
	@echo "original module"


	ghdl -s $(TEST)
	@echo "Syntax Correct"

	ghdl -a $(TEST)

	ghdl -e $(MOD)

	ghdl -r $(MOD) --vcd=$(SIM)
	@echo "build run successfully"

sim: run
	gtkwave $(SIM)

