# based off lab01 makefile
# -Wall turns on all warnings
# -g2012 selects the 2012 version of iVerilog
IVERILOG=iverilog -Wall -g2012 -y ./ -I ./
VVP=vvp
VIVADO=vivado -mode batch -source

# Look up .PHONY rules for Makefiles
.PHONY: clean submission

MUX=mux32.sv muxN.sv
ADD=add32.sv full_adder.sv

test_mux: test_mux.sv $(MUX)
	${IVERILOG} $^ -o test_mux.bin && ${VVP} test_mux.bin

test_add: test_add.sv $(ADD)
	${IVERILOG} $^ -o test_add.bin && ${VVP} test_add.bin

# Call this to clean up all your generated files
clean:
	rm -f *.bin *.vcd vivado*.log vivado*.jou vivado*.str

# Call this to generate your submission zip file.
submission:
	zip submission.zip *.sv *.pdf README.md Makefile
