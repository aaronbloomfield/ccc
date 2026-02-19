doc:
	@cd .. && make -s
	dot -Tsvg -O hwflow.dot
	/bin/mv -f hwflow.dot.svg hwflow.svg

tabs:
	@for f in `ls -d */` ; do \
		cd $$f && ../maketabs.py && cd ..; \
	done

all:
	@for f in `ls -d */` ; do \
		cd $$f && make && cd ..; \
	done

sync:
	cd tokens && make sync && cd ..
	cd auction && make sync && cd ..
	cd dex && make sync && cd ..
	cd daoweb3 && make sync && cd ..
