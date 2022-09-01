doc:
	@cd .. && make -s

tabs:
	@for f in `ls -d */` ; do \
		cd $$f && ../maketabs.py && cd ..; \
	done

all:
	@for f in `ls -d */` ; do \
		cd $$f && make && cd ..; \
	done
