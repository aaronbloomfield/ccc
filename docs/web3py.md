Web3.py Introduction
====================

[Go up to the main CCC docs page](index.html) ([md](index.md))

This document is an introduction to using web3 in Python.

#### Version

The functions herein are for web3.py version 6.0.0 and above.  Specifically, all the function names changed from version 5.31.0 and 6.0.0.  Run `pip freeze` to see what version of web3 you have installed.  If it's not 6.0.0 or above, this tutorial is not going to work out well for you.


#### Starting Python

Run Python.  You can put these commands into a script file, or type these commands directly into a Python interpreter.

You will need to install two packages via `pip` or `pip3`: the packages are `web3` and `hexbytes` (note that the former may install the latter on your system).

You should always start with the following import lines:

```
from web3 import Web3
from hexbytes import HexBytes
```

All the code below assumes those two import lines are present.

#### Connect to the blockchain

In Python, you can connect to the blockchain in a few different ways.  The difference is if you are going to connect via the geth.ipc file or through the course server endpoint.

If you are using the geth.ipc file:

```
w3 = Web3(Web3.IPCProvider('/path/to/geth.ipc'))
```

This assumes you have started up a node as per the [Private Ethereum Blockchain assignment](../ethprivate/index.html) ([md]((../ethprivate/index.md))).

In Windows, according to [this post](https://ethereum.stackexchange.com/questions/76036/how-do-i-connect-geth-to-web3-py-using-ipc-on-windows), you do not pass anything in to the function, as shown here: `w3 = Web3(Web3.IPCProvider()`.

To connect via the course server:

```
w3 = Web3(Web3.WebsocketProvider('wss://<your-provider-url>'))
```

The full URL for the course server is on the Collab landing page.

If you are using a proof-of-authority blockchain, you have to execute the following two commands after you initialize the `w3` variable:

```
from web3.middleware import geth_poa_middleware
w3.middleware_onion.inject(geth_poa_middleware, layer=0)
```

To see if you are connected, you can try:

- `w3.is_connected()`, which should return `True`
- `w3.eth.get_block('latest')`, which should return the latest block

#### Calling a `view` or `pure` function on a smart contract

Calling a `view` or `pure` function is much like with geth -- we define an address and an ABI variable, then create the interface and then the contract.  For this example, we'll call a method on our TokenDEX contract.

You'll need to determine the address of your TokenDEX -- you can use the one you submitted to the dex.php listing.  Define the following variables:

```
address='0x0123456789abcdef0123456789abcdef01234567'
abi='[...]'
```

For the `abi` variable, you can copy it from the Collab landing page.  Note that this ABI value is in single quotes, which is unlike how we do it via the geth Javascript terminal.

We can then create the contract instance in one command:

```
contract = w3.eth.contract(address=address, abi=abi)
```

From there, we can call a function on it:

```
contract.functions.k().call()
```

Notice that we have to put parenthesis after both the method name of `k` and after the `call`.  Parameters, if there were any, would go in the parenthesis after the method name, not in the `call()` parentheses.

#### Transactions

In geth, we would unlock our account with our password, and then call `send_transaction()`.  To do this in Python is a bit more complicated.

First, we need the private key in decrypted form.  This was done in the [Private Ethereum Blockchain assignment](ethprivate/index.html) ([md](ethprivate/index.md)) in part 4 -- if you don't have that decrypted private key saved, or if you changed accounts, then re-do that section.  Your private key will be of the form `b'0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef'`.  Save it via:

```
private_key = hexbytes.HexBytes('0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef')
```

You will note that this is a slightly different form than what you got when you decrypted your key -- the hex byte data is the same, it just is in a `hexbytes.HexBytes()` constructor.  In particular, the leading 'b' was removed from the string value (the one before the single quote).

We also need to define our account address that we have the private key for:

```
my_address='0x0123456789abcdef0123456789abcdef01234567';
```

This address has to be in correct check-summed form -- you can run it through [ethsum.netlify.app](https://ethsum.netlify.app/) to get the check-summed version.  You can also use the Web3.py library to checksum and address: `Web3.to_checksum_address(addr)`.

Once we have the private key, we have to take three steps: create the transaction, sign it, and then transmit it to the blockchain.

Let's first create the transaction:

```
transaction = contract.functions.getTokenCCAbbreviation().build_transaction({
    'gas': 70000,
    'gasPrice': w3.to_wei('10', 'gwei'),
    'from': my_address,
    'nonce': w3.eth.get_transaction_count(my_address)
    })
```

Parameters, if there were any, would go in the parenthesis after the method name, not in the `build_transaction()` parentheses.

Other fields could be added as well -- if we wanted to send some wei in with the transaction, such as to a `payable` function, then we would add a `value` key with the (integer) wei amount as the value.

If all we wanted to do was to just pay ETH, and not call a function, we would just create a dictionary:

```
transaction = {
    'nonce': w3.eth.get_transaction_count(my_address),
    'to': '0x0123456789abcdef0123456789abcdef01234567',
    'value': w3.to_wei(1, 'ether'),
    'gas': 21000,
    'gasPrice': web3.to_wei('10', 'gwei')
}
```

We then sign that transaction:

```
signed_txn = w3.eth.account.sign_transaction(transaction, private_key=private_key)
```

Lastly, we send it to the network

```
ret = w3.eth.send_raw_transaction(signed_txn.rawTransaction)
```

That's it!  The transaction was sent to the blockchain.

#### Transaction details

The return value of `send_raw_transaction()` was saved into the `ret` variable.  We can then get that transaction information:

```
w3.eth.wait_for_transaction_receipt(ret)
```

This is the transaction *receipt*, which has slightly different information than the transaction itself.  In particular, it will wait (block) until the transaction is mined into a block.  If the `status` field is 0, then the transaction was not successful for some reason. Those reasons can include: a reversion (such as a failed `require()`, insufficient funds, insufficient gas, etc.

We can also get the raw transaction information itself:

```
w3.eth.get_transaction(ret)
```

This is the same information that you can find in the blockchain explorer.


#### Gas estimation

Web3 can estimate how much gas your transaction will use.  Once you have created your transaction object, you can just call: `gas = w3.eth.estimate_gas(transaction)`.  Note that this is an *estimate*, not a fully accurate count.  In particular, if there is an if/else path, then it can't always know which path it will take.  Although an estimate, it is sufficient for our purposes.  Lastly, note that this is the amount of gas, and once you supply it with a amount of wei per gas, you can convert that into a actual price in ether.


#### Return values and reverts

It turns out it is often (but not always!) possible to get the return value for a transaction or the reason for a reversion.  Note that calls do not need any special code to get the return value, only transactions.  The code below will attempt to do just that (code adapted from [here](https://snakecharmers.ethereum.org/web3py-revert-reason-parsing/)).


```
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
```

This function is provided in the code given with the homework.


#### Read more

The functionality of web3.py is similar to what we know of from geth, but the formatting of the function calls is different.  You can see full API [here](https://web3py.readthedocs.io/en/latest/index.html).
