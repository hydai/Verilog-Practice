VL		= ncverilog
VLFLAG	= +access+r
SRC		= hw1_A_testbench.v
TMPFILE	= *.log \
		  verilog.key \
		  nWaveLog
DBFILE	= *.fsdb \
		  *.vcd \
		  *.bak
RM		= rm -rf

all	:: sim

sim	:
	$(VL) $(SRC) $(VLFLAG)

check :
	$(VL) -c $(SRC)

clean :
	$(RM) $(TMPFILE)

vclean :
	$(RM) $(TMPFILE) $(DBFILE)
