CC 		= 	iverilog
YSRC 	= 	mealy_t.v \
			mealy.v
PYSRC 	= 	mealy_t.v \
			tmp_mealy.v
ESRC 	= 	moore_t.v \
			moore.v
RUN 	= 	vvp
TARGET 	= 	fsm

moore:
	${CC} -o ${TARGET} ${ESRC} 
	${RUN} ${TARGET}

mealy:
	${CC} -o ${TARGET} ${YSRC}
	${RUN} ${TARGET}

pm:
	${CC} -o ${TARGET} ${PYSRC}
	${RUN} ${TARGET}
clean:
	rm -rf ${TARGET}
