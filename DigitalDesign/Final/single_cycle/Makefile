## file header here
##

## define the filename of your memory model
RAMMODEL    = RAM2Kx32.v

VLOG        = ncverilog
SRC         = header.v \
              risc_t.v \
              $(RAMMODEL)
SYNSRC      = syn.v \
              header.v \
              risc_t.v \
              $(RAMMODEL) \
			  /theda21_2/CBDK_IC_Contest/CBDK_IC_Contest_v2.1/Verilog/tsmc13.v

VLOGARG     = +access+r 
#              +nospecify +notimingchecks

TMPFILE     = *.log \
              verilog.key \
              nWaveLog \
			  INCA_libs

DBFILE      = *.bak

RM          = -rm -rf

all :: sim

sim :
	$(VLOG) $(SRC) $(VLOGARG)

check :
	$(VLOG) -c $(SRC) $(VLOGARG)

syn :
	$(VLOG) $(SYNSRC) $(VLOGARG)

veryclean :
	$(RM) $(DBFILE) $(TMPFILE)
