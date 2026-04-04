ifeq ($(shell uname),Darwin)
        SED=sed -i .todel
else
        SED=sed -i
endif

doc:
	touch index.md
	cd ../..; make -s
	../maketabs.py
	make source

source:
	custom-source-highlight.sh *.py *.sol
