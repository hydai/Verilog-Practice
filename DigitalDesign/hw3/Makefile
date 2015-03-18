VL		= ncverilog
VLFLAG	= +access+r -sv
SRC		= -f hw3.f
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

ts1 :
	$(VL) $(SRC) $(VLFLAG) +define+TESTSIZE=44 +DEFINE+PATTERN=pattern1.dat +define+GOLDEN=golden1.dat +define+SNAPSHOT=dump1.dat

ts2 :
	$(VL) $(SRC) $(VLFLAG) +define+TESTSIZE=44 +DEFINE+PATTERN=pattern2.dat +define+GOLDEN=golden2.dat +define+SNAPSHOT=dump2.dat

fib :
	$(VL) $(SRC) $(VLFLAG) +define+TESTSIZE=44 +DEFINE+PATTERN=fib.dat +define+GOLDEN=fib_result.dat +define+SNAPSHOT=dumpfib.dat

my :
	$(VL) $(SRC) $(VLFLAG) +define+TESTSIZE=102 +DEFINE+PATTERN=x2addRiM1.dat +define+GOLDEN=dumpmy.dat +define+SNAPSHOT=dumpmy.dat
check :
	$(VL) -sv -c $(SRC)

clean :
	$(RM) $(TMPFILE)

vclean :
	$(RM) $(TMPFILE) $(DBFILE)
