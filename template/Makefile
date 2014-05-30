CC 		= 	iverilog
SRC 	= 	if-else_t.v \
			if-else.v
RUN 	= 	vvp
TARGET 	= 	ifElse

all: sim

sim:
	${CC} -o ${TARGET} ${SRC} 
	${RUN} ${TARGET}

hw2:
	${CC} -o ${TARGET} ${SRC2}
	${RUN} ${TARGET}

clean:
	rm -rf ${TARGET}
