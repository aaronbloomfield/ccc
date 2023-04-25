# This is the config file for the Arbitrage homework
# https://aaronbloomfield.github.io/ccc/hws/arbitrage/

import hexbytes

# The configuration options to connect to the blockchain and the DEXes
config = {
    # you will have to change these values for it to work
    'account_address': '0x123456789ABcdEf0123456789aBCDeF123456789',
    'account_private_key': hexbytes.HexBytes('0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef'),
    'connection_uri': '/path/to/geth.ipc',
    'connection_is_ipc': True, # set to false if it's a ws:// connection
    # once set, these should only be changed as necessary as you are testing your code
    'price_eth': 100.00,
    'price_tc': 10.0,
    'max_eth_to_trade': 10.0,
    'max_tc_to_trade': 100.0,
    'gas_price': 10, # in gwei
    'dex_fees': 0.005, # that's 1/2 of a percernt
    # once set, you should not have to change these
    'dex_addrs': [
                  '0x123456789abcdef0123456789abcdef123456789', 
                  '0x123456789abcdef0123456789abcdef123456789', 
                  '0x123456789abcdef0123456789abcdef123456789', 
                  '0x123456789abcdef0123456789abcdef123456789',
                  '0x123456789abcdef0123456789abcdef123456789',
                  '0x123456789abcdef0123456789abcdef123456789'
                  ],
    'tokencc_addr': '0x123456789abcdef0123456789abcdef123456789',
    'chainId': 12345678,
}


# This will print the output into the format required by the homework.  It
# should not be changed.  Whichever of ethAmt or tcAmt is sent should be
# negative, and whichever one is received should be positive.  Both of those
# values should be divided by 10**decimals (for tcAmt) or 10**18(for ethAmt).
# fees and holdings should be in USD
def output(ethAmt, tcAmt, fees, holdings_after):
    if ethAmt == 0 and tcAmt == 0:
        print("No profitable arbitrage trades available")
        return
    assert ethAmt * tcAmt < 0, "Exactly one of ethAmt and tcAmt should be negative, the other positive"
    if ethAmt < 0:
        print("Exchanged %.4f ETH for %.4f TC; fees: %.2f USD; prices: ETH %.2f USD, TC: %.2f USD; holdings: %.2f USD" %
              (ethAmt, tcAmt, fees, config['price_eth'], config['price_tc'], holdings_after))
    else:
        print("Exchanged %.4f TC for %.4f ETH; fees: %.2f USD; prices: ETH %.2f USD, TC: %.2f USD; holdings: %.2f USD" %
              (tcAmt, ethAmt, fees, config['price_eth'], config['price_tc'], holdings_after))


# This is the ABI for IDEX.sol (this includes the functions inherited from IERC165 and IERC20Receiver)
idex_abi = '[{"anonymous":false,"inputs":[],"name":"liquidityChangeEvent","type":"event"},{"inputs":[],"name":"addLiquidity","outputs":[],"stateMutability":"payable","type":"function"},{"inputs":[{"internalType":"uint256","name":"_tokenAmount","type":"uint256"},{"internalType":"uint256","name":"_feeNumerator","type":"uint256"},{"internalType":"uint256","name":"_feeDenominator","type":"uint256"},{"internalType":"address","name":"_erc20token","type":"address"},{"internalType":"address","name":"_etherPricer","type":"address"}],"name":"createPool","outputs":[],"stateMutability":"payable","type":"function"},{"inputs":[],"name":"decimals","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"erc20Address","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"who","type":"address"}],"name":"etherLiquidityForAddress","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"etherPricer","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"feeDenominator","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"feeNumerator","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"feesEther","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"feesToken","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getDEXinfo","outputs":[{"internalType":"address","name":"","type":"address"},{"internalType":"string","name":"","type":"string"},{"internalType":"string","name":"","type":"string"},{"internalType":"address","name":"","type":"address"},{"internalType":"uint256","name":"","type":"uint256"},{"internalType":"uint256","name":"","type":"uint256"},{"internalType":"uint256","name":"","type":"uint256"},{"internalType":"uint256","name":"","type":"uint256"},{"internalType":"uint256","name":"","type":"uint256"},{"internalType":"uint256","name":"","type":"uint256"},{"internalType":"uint256","name":"","type":"uint256"},{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getEtherPrice","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getPoolLiquidityInUSDCents","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getTokenPrice","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"k","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"from","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"},{"internalType":"address","name":"erc20","type":"address"}],"name":"onERC20Received","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"amountEther","type":"uint256"}],"name":"removeLiquidity","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"reset","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"p","type":"address"}],"name":"setEtherPricer","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"bytes4","name":"interfaceId","type":"bytes4"}],"name":"supportsInterface","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"symbol","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"who","type":"address"}],"name":"tokenLiquidityForAddress","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"x","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"y","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"stateMutability":"payable","type":"receive"}]';

# This is the ABI for ITokenCC.sol (this includes the functions inherited from IERC20Metadata, IERC20, and IERC165)
itokencc_abi = '[{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"owner","type":"address"},{"indexed":true,"internalType":"address","name":"spender","type":"address"},{"indexed":false,"internalType":"uint256","name":"value","type":"uint256"}],"name":"Approval","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"from","type":"address"},{"indexed":true,"internalType":"address","name":"to","type":"address"},{"indexed":false,"internalType":"uint256","name":"value","type":"uint256"}],"name":"Transfer","type":"event"},{"inputs":[{"internalType":"address","name":"owner","type":"address"},{"internalType":"address","name":"spender","type":"address"}],"name":"allowance","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"spender","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"}],"name":"approve","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"account","type":"address"}],"name":"balanceOf","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"decimals","outputs":[{"internalType":"uint8","name":"","type":"uint8"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"name","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"requestFunds","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"bytes4","name":"interfaceId","type":"bytes4"}],"name":"supportsInterface","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"symbol","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"totalSupply","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"to","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"}],"name":"transfer","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"from","type":"address"},{"internalType":"address","name":"to","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"}],"name":"transferFrom","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"nonpayable","type":"function"}]';


# This function will attempt to determine a return value or why a transaction
# reverted.  It will return one of three values:
# - None when it encounters an error (not when it encounters a revert)
# - (True,<ret>) if the TXN returned a value; the value is <ret>
# - (False,<str>) if the TXN reverted; the revert reason is <str>
def getTXNResult(w3,txhash):
    try:
        tx = w3.eth.get_transaction(txhash)
    except Exception as e:
        print("Error getting transaction:",e)
        return None
    replay_tx = {
        'to': tx['to'],
        'from': tx['from'],
        'value': tx['value'],
        'data': tx['input'],
        'gas': tx['gas'],
    }
    # replay the transaction locally:
    try:
        ret = w3.eth.call(replay_tx, tx.blockNumber - 1)
        return (True,ret)
    except Exception as e: 
        return (False,str(e))
