VL			= ncverilog
VLFLAG		= +access+r -sv
DPSRC		= -f hw3.f
DPSYNSRC 	= syn.v \
		  	datapath_syn.v \
		  	hw3_t.v \
		  	-v /theda21_2/CBDK_IC_Contest/cur/Verilog/tsmc13.v \
		  	+nospecify +notimingchecks
RAMMODEL    = RAM32x8.v
FIFOSRC 	= header.v \
			fifo_t.v \
			fifo.v \
			fifo_ctr.v \
			$(RAMMODEL)
FIFOSYNSRC 	= syn.v \
            header.v \
			fifo_ctr_syn.v \
			fifo.v \
			fifo_t.v \
			-v /theda21_2/CBDK_IC_Contest/cur/Verilog/tsmc13.v \
			$(RAMMODEL)
TMPFILE		= *.log \
		  	verilog.key \
		  	nWaveLog
DBFILE		= *.fsdb \
		  	*.vcd \
		  	*.bak
RM			= rm -rf

all	:: sim

dpsim :
	$(VL) $(DPSRC) $(VLFLAG)

dpsyn :
	$(VL) $(DPSYNSRC) $(VLFLAG)

fifosim :
	$(VL) $(FIFOSRC) $(VLFLAG)

fifosyn :
	$(VL) $(FIFOSYNSRC) $(VLFLAG)

ts1 :
	$(VL) $(DPSRC) $(VLFLAG) +define+TESTSIZE=44 +DEFINE+PATTERN=pattern1.dat +define+GOLDEN=golden1.dat +define+SNAPSHOT=dump1.dat

ts2 :
	$(VL) $(DPSRC) $(VLFLAG) +define+TESTSIZE=44 +DEFINE+PATTERN=pattern2.dat +define+GOLDEN=golden2.dat +define+SNAPSHOT=dump2.dat

ts1syn :
	$(VL) $(DPSYNSRC) $(VLFLAG) +define+TESTSIZE=44 +DEFINE+PATTERN=pattern1.dat +define+GOLDEN=golden1.dat +define+SNAPSHOT=dump1.dat

ts2syn :
	$(VL) $(DPSYNSRC) $(VLFLAG) +define+TESTSIZE=44 +DEFINE+PATTERN=pattern2.dat +define+GOLDEN=golden2.dat +define+SNAPSHOT=dump2.dat

clean :
	$(RM) $(TMPFILE) $(DBFILE)
