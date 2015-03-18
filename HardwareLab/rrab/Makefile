CC 		= 	iverilog
SRC 	= 	rrab_t.v \
			rrab.v
RUN 	= 	vvp
TARGET 	= 	rrab

all: sim

sim:
	${CC} -o ${TARGET} ${SRC} 
	${RUN} ${TARGET}

hw2:
	${CC} -o ${TARGET} ${SRC2}
	${RUN} ${TARGET}

clean:
	rm -rf ${TARGET}
