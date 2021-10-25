# based off lab01 makefile
# -Wall turns on all warnings
# -g2012 selects the 2012 version of iVerilog
IVERILOG=iverilog -Wall -g2012 -y ./ -I ./
VVP=vvp
VIVADO=vivado -mode batch -source

# Look up .PHONY rules for Makefiles
.PHONY: clean submission

SLT=adder_1.sv adder_n.sv slt.sv

test_slt: test_slt.sv $(SLT)
	${IVERILOG} $^ -o test_slt.bin && ${VVP} test_slt.bin

# Call this to clean up all your generated files
clean:
	rm -f *.bin *.vcd vivado*.log vivado*.jou vivado*.str

# Call this to generate your submission zip file.
submission:
	zip submission.zip *.sv *.pdf README.md Makefile
