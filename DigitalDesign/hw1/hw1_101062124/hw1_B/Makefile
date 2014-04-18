VL		= ncverilog
VLFLAG	= +access+r
SRCA	= hw1_B_testbench_A_testcase.v
SRCB	= hw1_B_testbench.v
TMPFILE	= *.log \
		  verilog.key \
		  nWaveLog
DBFILE	= *.fsdb \
		  *.vcd \
		  *.bak
RM		= rm -rf

all	:: sim

sim	:
	$(VL) $(SRCB) $(VLFLAG)

testcaseA :
	$(VL) $(SRCA) $(VLFLAG)

check :
	$(VL) -c $(SRC)

clean :
	$(RM) $(TMPFILE)

vclean :
	$(RM) $(TMPFILE) $(DBFILE)
