main:
	dot -Tsvg -Kneato -O 2gen-comm.dot
	/bin/mv -f 2gen-comm.dot.svg 2gen-comm.dot.1.svg
	for file in `ls 2gen-comm.dot.*.svg`; do \
		../../embedsvg.py $$file > 2gen_tmp.svg  ; \
		/bin/mv -f 2gen_tmp.svg $$file ; \
	done