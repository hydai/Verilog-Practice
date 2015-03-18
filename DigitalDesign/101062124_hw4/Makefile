## You may put the file header here
##   A template of Makefile
##

## define the filename of your memory model
RAMMODEL    = RAM32x8.v

VLOG        = ncverilog
SRC         = header.v \
              fifo_t.v \
              fifo.v \
              fifo_ctr.v \
              $(RAMMODEL)
MSRC 		= header.v \
              my_t.v \
              fifo.v \
              fifo_ctr.v \
              $(RAMMODEL)
SRC64 		= header.v \
              fifo_64x16_t.v \
              fifo_64x16.v \
              fifo_64x16_ctr.v \
              $(RAMMODEL)
MSRC64 		= header.v \
              my_64x16_t.v \
              fifo_64x16.v \
              fifo_64x16_ctr.v \
              $(RAMMODEL)
SYNSRC      = syn.v \
              header.v \
              fifo_t.v \
              syn.v \
              $(RAMMODEL)
VLOGARG     = +access+r

TMPFILE     = *.log \
              verilog.key \
              nWaveLog

DBFILE      = *.fsdb *.vcd *.bak

RM          = -rm -rf

all :: sim

sim :
	$(VLOG) $(SRC) $(VLOGARG)

syn :
	$(VLOG) $(SYNSRC) $(VLOGARG)

my_t :
	$(VLOG) $(MSRC) $(VLOGARG) +define+TESTSIZE=78 +DEFINE+PATTERN=pattern1.dat

sim64 :
	$(VLOG) $(SRC64) $(VLOGARG)

my_t_64 :
	$(VLOG) $(MSRC64) $(VLOGARG) +define+TESTSIZE=78 +DEFINE+PATTERN=pattern1.dat

clean:
	$(RM) $(TMPFILE) $(DBFILE)
