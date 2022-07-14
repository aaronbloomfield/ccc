To update the "SAI/DAI price versus ETH price" graph:

- Download the latest data
	- DAI prices, in `dai-usd-max.csv`, from [https://www.coingecko.com/en/coins/dai/historical_data](https://www.coingecko.com/en/coins/dai/historical_data)
	- ETH prices, in `eth-usd-max.csv`, from [https://www.coingecko.com/en/coins/ethereum/historical_data](https://www.coingecko.com/en/coins/ethereum/historical_data)
	- As SAI is no longer used, that CSV does not have to be updated
- In `dai-eth.plot`, set the end date (the second value in the `xrange` variable) to the latest date in the data set
- If necessary, adjust the maximum ETH price (in the `y2range` variable)
- Run `make`
- Recompute and update the Coefficient of Variance value in the slides: `stdev()/average()`
