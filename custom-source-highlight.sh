#!/bin/bash

for file in "$@"
do
	SED="sed -i"
	if [ x`uname` == x"Darwin" ]; then
		SED="sed -i .todel"
	fi
	extension=${file: -4}
	if [ x$extension == x.sol ]; then
		source-highlight -d -s cpp $file
	else
		source-highlight -d $file
	fi
	$SED s/"<html>"/"<html lang='en'>"/ $file.html
	$SED s/"<pre>"/"<main><pre>"/ $file.html
	$SED s_"</pre>"_"</pre></main>"_ $file.html
	/bin/rm -f *.todel
done
