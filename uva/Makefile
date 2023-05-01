main:
	@cd .. && make -s

stats:
	grep BTC-USD daily-announcements.html  | sed s_['/)`;']_"\ "_g | sed s/,//g | awk '{print " "$$8" "$$15" "$$21" "$$25}'

graph:
	gnuplot prices.graph
