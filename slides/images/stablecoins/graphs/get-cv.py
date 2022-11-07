#!/usr/bin/python3

import os, csv, statistics

l = []

# the key is the start of the file name, likely what coingecko names the file
# the first part of the value is the full name of the coin
# the second part of the value is the relevant part of the URL on coinmarketcap.com
coins = {
	'dai': ("Dai","multi-collateral-dai"),
	'eth': ("Ether","ethereum"),
	'sai': ("Sai","single-collateral-dai"),
	'usdc': ("USD Coin","usd-coin"),
	'usdt': ("Tether","tether"),
	'xpd': ("PetroDollar","petrodollar"),
	'fei': ("Fei","fei-usd"),
	'lunc': ("Luna Classic", "terra-luna"),
}

print("coin\tnum\tCV")
print("----\t---\t--")
for entry in os.scandir():
	if entry.name[-4:] == '.csv':
		name = entry.name.split("-")[0]
		data = []
		with open(entry.name) as fcsv:
			csvreader = csv.reader(fcsv)
			for line in csvreader:
				try:
					data.append(float(line[1]))
				except:
					pass
		cv = statistics.stdev(data) / statistics.mean(data)
		print("%s\t%d\t%.2f%%" % (name, len(data), 100.0*cv) )
		l.append( (name,100.0*cv) )

print()
for (name,cv) in sorted(l):
	filename = name + '-coin-symbol.svg'
	if name == 'lunc':
		filename = 'lunac-coin-symbol.svg'
	print ('- [![' + name.lower() + ' logo](../slides/images/logos/' + filename + ')](https://coinmarketcap.com/currencies/' + \
		coins[name][1] + '/) ' + coins[name][0] + ' (' + name.upper() + '): %.2f%%' % cv)
		