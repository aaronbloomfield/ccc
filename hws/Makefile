ifeq ($(shell uname),Darwin)
        SED=sed -i .todel
else
        SED=sed -i
endif

doc:
	@cd .. && make -s
	dot -Tsvg -O hwflow.dot
	/bin/mv -f hwflow.dot.svg hwflow.svg

tabs:
	@for f in `ls -d */` ; do \
		cd $$f && ../maketabs.py && cd ..; \
	done

all:
	for f in `/bin/ls -F | grep /` ; do \
		echo "cd $$f && make && cd .."; \
	done
	$(SED) s/"<html>"/"<html lang='en'>"/g */*.html
	/bin/rm -f */*.todel

sync:
	cd tokens && make sync && cd ..
	cd auction && make sync && cd ..
	cd dex && make sync && cd ..
	cd daoweb3 && make sync && cd ..
