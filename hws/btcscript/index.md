Bitcoin Scripting Homework
==========================

[Go up to the CCC HW page](../index.html) ([md](../index.md))

### Overview

In this assignment you will be writing a series of Bitcoin scripts to enact transfers.  You will be using a Bitcoin test network to do so.  While regular Bitcoin uses the abbreviation BTC, we will use the abbreviation 'tBTC' for the Bitcoin on our test network.

There are four separate Bitcoin scripts that you will need to write.  You will need to be familiar with the [Bitcoin slide set](../../slides/bitcoin.html#/).  You will also need to refer to the [Bitcoin Script page](https://en.bitcoin.it/wiki/Script).

### Languages

This assignment uses the [Python bitcoin package](https://pypi.org/project/bitcoin/).  Thus, this assignment must be completed in Python.  You can install the package via `pip install python-bitcoinlib` (you may need to use `pip3` on your system).  This is NOT installed on the VirtualBox image, so you will have to install it there as well.


### Provided files

- [scripts.py](scripts.py.html) ([src](scripts.py)): you will modify this file throughout this assignment.  The progression of items in that file mirrors the progression of the assignment steps in this assignment.  This is the only file that you will submit.  We would expect that you would be able to understand everything this file by the end of the assignment
- [bitcoinctl.py](bitcoinctl.py.html) ([src](bitcoinctl.py)): this is the driver file that will run the various parts of the assignment using the values in the above scripts.py.  You are of course welcome to look at the details, but you are not expected to understand what is in that file.

### Hints

There are a few really important things to remember in this assignment.

1. After each transaction, there is a place to store the transaction hash.  Be diligent about doing this -- it's really easy to lose track of which of a dozen transaction hashs is which.  Keeping them in the stated variables will help with this.
2. Don't modify the variable or function names in the scripts.py file.  Otherwise the provided functions, and our grading routines, will not work.  You can *add* functions and variables, but don't change the ones currently there.
3. For *EACH* transaction, you will need to set the `utxo_index` variable -- there is just one such variable in the scripts.py file.  If you get an error stating that the UTXO index is already spent, it's likely that you forgot to set this variable.
4. Some errors with Bitcoin scripts can be determined prior to broadcasting it on the Bitcoin test network.  This is done by the `VerifyScript()` method, which the provided code base calls for you before any attempted broadcast transaction.  So if you see an error such as, `verifyerror: "bitcoin.core.scripteval.VerifyOpFailedError: EvalScript: OP_EQUALVERIFY failed`, or similar, it means that the Bitcoin library was able to detect that your script would not work, and did not broadcast the transaction.
4. We provide you with a `create_CHECKSIG_signature()` function in the scripts.py file -- use it!  See the comments there for details as to how.
5. To save you the tedious task of having to learn the [Python Bitcoin library](https://pypi.org/project/python-bitcoinlib/) -- which you probably would never use again -- much of the library interaction has been handled for you by the provided code.  But in order for that to work, you have to proceed through this homework in the order written.


### Testnet Setup

As we do not want to have to buy, and possibly lose, real BTC, we are going to use a test network.  Because the coins we are going to be using are not "real" Bitcoins, we will use the abbreviation 'tBTC' instead of 'BTC'.  When using a test network, you get coins for free via a "faucet" -- in the same way that a water faucet provides water once turned on, so does a testnet faucet provide tBTC when requested.  The particular one we are using is [Yet Another Bitcoin Testnet Faucet](https://testnet-faucet.mempool.co/).



1. You will need to generate a tBTC key pair.  Run `./bitcoinctl.py genkey`, and record both the public and private keys.  While these keys are not valid on the main Bitcoin test network -- the have a different value for the [version byte](../../slides/bitcoin.html#/btcaddress) in the invoice address -- you will need them throughout this assignment.
    - Save both the tBTC private key and the tBTC address into the scripts.py file into `private_key_str` and `invoice_address`, respectively
2. Go to the [Testnet Faucet](https://testnet-faucet.mempool.co/) page and enter the tBTC address key provided in the previous step.  You will be provided a transaction ID.  You can then view your transaction at [https://live.blockcypher.com/](https://live.blockcypher.com/) -- put the transaction ID in the search box and be sure to select 'Bitcoin Testnet' for the search.
    - Enter the transaction ID in scripts.py in `txid_initial`
    - Verify that you can view your account information at https://live.blockcypher.com/btc-testnet/address/&lt;address&gt; where &lt;address&gt; is your tBTC address -- the amount that address holds should be the amount that the faucet provided to you (likely 0.001 tBTC)
      - It may take up to 10 minutes or so for the transaction that funded your wallet to be mined into the blockchain
    - Verify that you can view the transaction at https://live.blockcypher.com/btc-testnet/tx/&lt;txid&gt; where &lt;txid&gt; is your transaction id
      - Note that the testnets often perform many transfers in one transaction -- so the total amount transacted may be more than 0.001 tBTC, but the amount paid to your wallet should be 0.001 tBTC
    - You can also get these URLs by running `./bitcoinctl.py geturls`.  As you fill in more transaction hashes throughout this assignment, re-running this will show an increasing list of URLs.
3. That transaction gave only one UTXO, and we would like multiple UTXOs to use -- this way we can use one per question part, and we have a few extra if something ends up not working correctly.
    - Look at the section of scripts.py that deals with splitting coins.  The default values there are probably correct, but check anyway -- see the comments therein for details
      - Check the transaction -- via the URL from above -- that gave you the coins, and make sure you have the right UTXO index (which is stored in the `utxo_index` variable in scripts.py).  If you get an error such as "witness script detected in tx without witness data", then it probably means your UTXO index is wrong.
    - Run `./bitcoinctl.py split` to split your coins.  This uses the values in the splitting coins section of scripts.py.
      - If this works properly, it will present back a Python dictionary that will take up many lines.  If it doesn't work, it will give you an error in just a few lines.
    - Look at the wallet info URL (run `./bitcoinctl.py geturls` to get the URL), and note the transaction hash of the split transaction -- it should be the top transaction listed, and will have 10 different outputs.  The transaction hash itself is also listed in the output from the split transaction -- it's the `hash` field of the dictionary, and is about a half a dozen lines down.  Record that transaction id in scripts.py as `txid_split`

Be careful not to lose the information (keys and TXIDs) that you recorded above.  To prevent abuse, the faucet only allows one transaction per 12 hours for a given IP address or tBTC address.

### Python Bitcoin library

The Bitcoin library for Python handles much of the heavy lifting -- conversion from one type to another, encryption, signing, verification, etc.  If you were to enter actual keys that have real BTC then you could use this library to make real BTC transactions.

While the library can do many things, below is a quick summary of the relevant aspects that you will need to know for this assignment.

- Creating Bitcoin scripts is really just putting everything into a list.  All the opcodes are named the same as on the [Bitcoin Script page](https://en.bitcoin.it/wiki/Script).  Creating a script is just as simple as putting the opcodes in a Python list: `[ OP_RETURN ]` is how you would create the [provably unspendable transaction](../../slides/bitcoin.html#/unspendable) discussed in the lecture slides.  Other things that go into scripts -- signatures and public key hashes -- are also just included in such a list.  Assuming you got the types correct, then the library will create the full script from such a list.
- You will enter your private key into scripts.py as a string.  To convert it to the private key format that the library uses, you pass it to `CBitcoinSecret()`.  The object returned has a `.pub` field, which is the public key (the type of that public key is `CPubKey`).  And that public key can be converted into a Bitcoin address by calling `P2PKHBitcoinAddress.from_pubkey(public_key)`.  In fact, this is almost the exact code used by the provided files to generate keys.  For that we just used random data -- via `os.urandom(32)` -- instead of a pre-defined public key string.  An example:
  ```
private_key = CBitcoinSecret(private_key_str)
public_key = private_key.pub
address = P2PKHBitcoinAddress.from_pubkey(public_key)
```
  - If a public key is to be put into a script, as happens in most of the scripts, then the type of that should be `CPubKey` -- the type of the `.pub` field of the object returned by `CBitcoinSecret()`
- Creating a signature is a bit more involved.
  - Given the following parameters:
    - `txin`: the transaction input from the transaction that created the UTXO that is being redeemed
    - `txout`: the transaction output from the transaction that created the UTXO that is being redeemed
    - `txin_scriptPubKey`: the pubKey script (aka output script) of the UTXO being redeemed
    - `private_key`: the secret key being used to sign this transaction
  - Then we create a signature with the following three lines of code:
    - `tx = CMutableTransaction([txin], [txout])`: 
    - `sighash = SignatureHash(CScript(txin_scriptPubKey), tx, 0, SIGHASH_ALL)`: 
    - `sig = private_key.sign(sighash) + bytes([SIGHASH_ALL])`: 
  - This signature can be put into a list when providing a script
  - We provide a helper function, called `create_CHECKSIG_signature()`, in scripts.py to perform these calls.


### Part 1: Standard P2PKH transaction

The UTXO indices that you created when you split your tBTC are paid to a standard [P2PKH transaction](../../slides/bitcoin.html#/p2pkh).  Your task is to redeem them by writing the appropriate scripts (pubkey and sigscript) to redeem the coins from one of the UTXOs.  It should be paid back to the faucet -- use the `faucet_adress` variable, defined at the top of the `scripts.py` file, as the receiver of this transaction.

To complete this transaction, you need to complete four things:

- The `P2PKH_scriptSig(...)` function provides the sigscript needed to redeem the UTXO being spent.  The UTXO that is being redeemed -- one of the split UTXO indices from above -- requires a P2PKH sigScript to redeem one of the indices.
- The `P2PKH_scriptPubKey(address)` function defines the pubKey script (aka output script).  This was discussed in lecture in the [P2PKH transaction](../../slides/bitcoin.html#/p2pkh) slides.  This script creates a new UTXO, payable to the faucet address, that is also a P2PKH script.  The parameter is of type `P2PKHBitcoinAddress`, which is what the `P2PKHBitcoinAddress.from_pubkey(public_key)` call (shown above) returns; a variable this type can be put directly into a script.
- Set the transaction to be spent via the `txid_utxo` variable; the default is the transaction ID that was split (i.e., the `txid_split`).
- Set the output index to spend via `utxo_index`; it is currently set to 0.  Recall that output indices start from 0, not 1.  Be sure to pick an unspent index!  If you have to run this multiple times, you may have to change this value to an unspent index.

When you have finished the script, you can run it via `./bitcoinctl.py part1`; it will report an error if you get it wrong.  If it works, you will see a JSON dictionary printed to the screen.  Record the transaction ID of that transaction in `txid_p2pkh`.  The TXID is the 'hash' field in the dictionary that is printed to the screen when run.  You can then run `./bitcoinctl.py geturls` to get the URL for the transaction that you just executed.  It may take up to 10 minutes for it to be mined into the blockchain.

You should notice your wallet balance has decreased.


### Part 2: Puzzle script

For this tBTC transaction, you are going to create an algebraic puzzle script -- one that anybody can redeem as long as they complete the numerical puzzle.

You will need to pick two 4-digit base-10 numbers.  You can take your UVA SIS ID and split the digits in half.  You **MUST** make sure that the numbers have the same parity -- both numbers are odd or both numbers are even.  We'll call those numbers $p$ and $q$.  You will need to store those values into `puzzle_txn_p` and `puzzle_txn_q` in scripts.py.

The puzzle transaction will deal with the solution to the following two linear equations:

$$2x+y=p$$
$$x+2y=q$$

You can use an online linear question solver, such as [this one](https://onsolver.com/system-equations.php), to find the solution.  And make sure that the solutions are integer values!  Once you know those values, put them into `puzzle_txn_x` and `puzzle_txn_y` in scripts.py

For this part, you will create a transaction to redeem one of the split UTXO indices that were created, above.  The pubKey (output) script of that newly created transaction will be specified in the `puzzle_scriptPubKey()` function in scripts.py.  Note that because this output script does not depend on the receiver's public key, that is not provided as a parameter to the function.  Also note that the `OP_MUL` opcode has been disabled on the Bitcoin networks, so you can't use that.  This pubKey script should verify that the two values specified by the redeemer fulfill those two equations.  Once this is created, run `./bitcoinctl.py part2a` -- remember to choose an unspent UTXO index first via the `utxo_index` variable.  As above, record the transaction hash into the `txid_puzzle_txn1` variable.

You will also need to create the sigScript that redeems this transaction.  This should **ONLY** contain the two values $x$ and $y$ -- their order is up to you, as long as it works with the script you created above.  That script goes into `puzzle_scriptSig()`.  This also does not depend on any signatures, which is why there are no parameters to that function.  Ensure that the previous transaction has been mined into the blockchain, which may take up to 10 minutes -- if you have entered the previous transaction's URL into the `txid_puzzle_txn1` variable, you can get the URL of that transaction via `./bitcoinctl.py geturls`.  When ready, you can send the redeeming trasnaction to the tBTC network via `./bitcoinctl.py part2b` (remember to choose an unspent UTXO index first).  Record the transaction hash into `txid_puzzle_txn2`.

You will notice that the amount in each UTXO index from the split transaction is 0.0001 tBTC.  For the first half of this puzzle transaction, the amount transacted is slightly less (90% of that, or 0.00009).  The difference -- 0.00001 tBTC -- is the transaction fee.  Even though this is a test network, and no actual money is involved, your transaction will not be mined into the blockchain unless you have a transaction fee.  For the second half of this, we need to lower the amount even further, so the amount transacted is 90% of 0.00009, or 0.000081; this lowering is done automatically by the code base provided.  The difference here -- 0.000009 tBTC -- is the transaction fee.  While the test network requires there be *some* transaction fees, it doesn't seem to care much about how much those fees are, which is different than with the real BTC network.  This automatic lowering of the transaction amount will recur elsewhere in this assignment.


### Part 3: Multi-signature transaction

You are going to create a multi-signature transaction, which must use the [OP_CHECKMULTISIG opcode](../../slides/bitcoin.html#/checkmultisig).

To set this up, you will need to create three more key pairs using `./bitcoinctl.py keygen`.  Save these in the variables for Alice, Bob, and Charlie in part 3 of the `scripts.py` file.  These addresses don't need any tBTC -- we just need the key pairs to perform digital signatures.

The scenario is this: you are taking on the role of a bank.  Three siblings (Alice, Bob, and Charlie) have deposited money into an account, and it can be redeemed if two of the three -- and also the bank! -- agree to it.  Formally, the transaction must be signed by the bank (i.e., you -- via the keys in the `my_private_key_str` variable) and any two of the three siblings (via their private keys).

This will actually require two transactions.  The first redeems one of the split UTXOs and creates a multi-signature pubKey (output) script.  The second redeems that multi-signature script and pays it to the faucet address.  

1. Transaction 1: tBTC funds are taken from one of your split UTXO indices and put into a new UTXO whose output script requires the multiple signatures
    - The sigScript for this will be taken from your part (1), above -- specifically from `P2PKH_scriptSig()`.  So you don't have to write this again.  If your part (1) worked, then this should work as well.
    - The pubKey script for this you will be writing in the `multisig_scriptPubKey()` function.
    - Once successfully executed, record the transaction hash in the `txid_multisig_txn1` variable.
2. Transaction 2: tBTC the funds from the multisig UTXO are redeemed and paid back to the faucet address.
    - The sigScript for this you will be writing in the `multisig_scriptSig()` function.
    - The pubKey script for this will be taken from your part (1) above -- specifically from `P2PKH_scriptPubKey()`.  So you don't have to write this again.  If you part (1) worked, then this should work as well.
    - Once successfully executed, record the transaction hash in the `txid_multisig_txn2` variable.

You only have to write the pubKey (output) script of the first transaction, and the sigScript (input) script of the second transaction.  The other two parts (sigScript of the first and pubKey script of the second) are taken from your code in part (1) -- so if that is not working, then this will not work either.

The first step is to create the transaction that sets up the multi-signature requirement in the pubKey script.  This must use the `OP_CHECKMULTISIG` opcode!  See the description of [OP_CHECKMULTISIG opcode](../../slides/bitcoin.html#/checkmultisig) in the lecture slides.  Fill in the `multisig_scriptPubKey()` function.  Recall that the sigScript will be used from your code for part (1).  We recommend that you write this and the next script -- the redeeming script -- together, and trace its stack execution (on paper or similar).  When you are ready to run it, be sure to set the `utxo_index` variable is set to the UTXO index you want to spend, and run `./bitcoinctl.py part3a`.  Once successful, record the transaction ID in the `txid_multisig_txn1` variable in scripts.py.

The second step is to create a transaction that will redeem it.  You will have to wait until the previous transaction receives at least one confirmation before you can execute this part, which can take up to 10 minutes.  This part requires that the `txid_multisig_txn1` variable, from the first step above, is set properly, as that is the UTXO that is going to redeem.  You will fill in your sigScript into `multisig_scriptSig()`.  Recall that the pubKey script for this transaction will be used from your answer for part (1).  When you are ready to run it, be sure to set the `utxo_index` variable at the top to the UTXO index you want to spend; this is likely 0, since there is only one output from the UTXO from the transaction just above.  You run it via `./bitcoinctl.py part3b`.  Once successful, record the transaction hash in the `txid_multisig_txn2` variable in scripts.py.


### Part 4: Cross-chain transactions

In this part you will create the scripts for a [cross-chain transaction](../../slides/bitcoin.html#/xchain).  Typically this would be for two different cryptocurrencies.  However, since we only have learned Bitcoin Script, we will use that for both parts.  There are many cryptocurrencies that are forks of Bitcoin, and thus have the same scripting language, so the same program could work for them.  Or a completely different cryptocurrency, with a different scripting language, would have an analogous script.  However, to test this we will be using two *different* Bitcoin testing blockchains.  

In addition to the lecture slides, you may want to refer to the [Atomic swap article](https://en.bitcoin.it/wiki/Atomic_swap) in the [Bitcoin wiki](https://en.bitcoin.it/wiki/Main_Page).

So far we have been using tBTC on the Bitcoin Testnet.  For this part we will also be using the BlockCypher Testnet -- this is also a fake Bitcoin network for testing, and it operates just like the Bitcoin Testnet we've been using.  Bitcoin on this other testnet will be abbreviated as BCY (for BlockCYpher testnet).  Note that we have been using [blockcypher.com](https://live.blockcypher.com/) to view all of our transactions, since that site can view both of these Bitcoin test networks.

In this part, you and Bob will be exchanging coins through a cross-chain transaction.  You will need to be familiar with the [cross-chain transaction section of the Bitcoin slide set](../../slides/bitcoin.html#/xchain).  You are going to take on the role of Alice in the lecture slides.

As an overview, this is what is going to happen.

1. You (Alice) are going to create a transaction to send tBTC to Bob.  You will send it from the account you have been using so far (saved in `my_private_key_str` and `my_invoice_address_str` in scripts.py).  Bob will receive it in the account that was created for him in the previous part (`bob_private_key_str` and `bob_invoice_address_str` in scripts.py).  This corresponds to [part 1 of the cross-chain transaction](../../slides/bitcoin.html#/xchainpt1) -- again, you are taking on the role of Alice.  You will only be creating TXN1 from that slide; we are omitting TXN2.
2. Bob will create a transaction to send BCY to you.  Both you and Bob will need to create invoice addresses and public keys for the BCY testnet, which we guide you through below.  This corresponds to [part 2 of the cross-chain transaction](../../slides/bitcoin.html#/xchainpt2) -- again, you are taking on the role of Alice.  You will only be creating TXN3 from that slide; we are omitting TXN4.
3. You (Alice) will redeem TXN3 on the BCY network, exposing the hidden secret.
4. Bob, now knowing the hidden secret, will then redeem TXN1 on the tBTC network.

#### Setup

To set this up, we need to create Bitcoin keypairs for the BlockCypher testnet, and use a faucet to give us some coins.  The process for creating keys and funding the accounts is different for the BCY test network.

1. Create an account at [https://accounts.blockcypher.com/](https://accounts.blockcypher.com/), which will allow you to get an API token.  Your token will be a hex number such as 0123456789abcdef0123456789abcdef.  Save this token somewhere safe!  You are welcome to record it in scripts.py (`blockcypher_api_token` is set aside for that), but that's completely optional.
2. To create keys, you will need to run the following from the command line, putting your token in there instead of `API_TOKEN`.  You should do this twice, one for you and once for Bob.
   ```
curl -X POST 'https://api.blockcypher.com/v1/bcy/test/addrs?token=API_TOKEN'
```
3. Save those tokens in scripts.py; yours go into `my_private_key_bcy_str` and `my_invoice_address_bcy_str`, and Bob's go into `bob_private_key_bcy_str` and `bob_invoice_address_bcy_str`.  Note that the `curl` command returns 4 values, but we only need to save two for each of the accounts.  Also note that the format of the private key is different for this network -- this one is hex encoded, whereas the one for the tBTC network was base-58 encoded.  The provided code base properly handles this difference.
4. Only Bob needs BCY funds.  You can fund his account via the following command, replacing both Bob's address for `BOB_BCY_ADDRESS` and your token for `API_TOKEN`:
   ```
curl -d '{"address": "BOB_BCY_ADDRESS", "amount": 100000}' https://api.blockcypher.com/v1/bcy/test/faucet?token=API_TOKEN
```
5. The above command will return a transaction hash; save that in `txid_bob_bcy_funding`.  If you run `./bitcoinctl.py geturls` it will display the full URL that you can use to view that funding transaction.
6. We will need to split Bob's funds into parts, just like we did in the setup, above.  Make sure that you have Bob's private key and invoice address set in scripts.py (in `bob_private_key_bcy_str` and `bob_invoice_address_bcy_str`), as well as the transaction hash that funded the wallet (in `txid_bob_bcy_funding`).  Lastly, look at the URL for that funding transaction (you can get that via `./bitcoinctl.py geturls`) and determine the UTXO index -- that needs to be set in `utxo_index`.  The run `./bitcoinctl.py splitbcy` -- notice that the command is `splitbcy`, not `split`!  Record the transaction hash returned from that execution run in `txid_bob_bcy_split`.

Whew!  The setup for this part is all done!  Now onto the scripting part....

#### Cross-chain atomic swap

Because we are swapping between two different Bitcoin test networks, the atomic swap code is really the same -- both are in Bitcoin script.  TXN 1 (from [here in the slides](../../slides/bitcoin.html#/xchainpt1)) and TXN 3 (from [here in the slides](../../slides/bitcoin.html#/xchainpt2)) differ only by the public keys:

- TXN 1: Pay *w* BTC to &lt;B's public key&gt; if (*x* for *h(x)* known and signed by B) or (signed by A & B)
- TXN 3: Pay *v* BTC to &lt;A's public key&gt; if (*x* for *h(x)* known and signed by A) or (signed by A & B)

Your script code for this will go into the `atomicswap_scriptPubKey()` function.

To help you with this code, we provide the two redeeming functions:

- `atomcswap_scriptSig_redeem()` is when Alice or Bob, knowing the secret, wants to redeem the transaction.  The `OP_TRUE` is for use in an `OP_IF` statement in the script you have to write.
- `atomcswap_scriptSig_refund()` is used when the transaction times out -- that's when the sender can get a refund on his/her transaction; this has to be signed by both Alice and Bob.  The particular script sent to redeem this would be TXN 2 (from [here](../../slides/bitcoin.html#/xchainpt1)) or TXN 4 (from [here](../../slides/bitcoin.html#/xchainpt2)).  You do not have to implement TXN 2 or TXN 4.

The last thing to do before you write the `atomicswap_scriptPubKey()` function is to determine what the secret is -- pick a number between 1 million and 2 billion, and save that in `atomic_swap_secret`.  (It needs to be in that range to ensure it's encoded as a 4-byte integer).  Keep in mind that this secret is only known to Alice initially; Bob is only given the hash of the secret (the bitcoinctl.py file handles that part for you).

Once you have written the script in the `atomicswap_scriptPubKey()` function, you can perform your cross-chain transaction.  This involves four steps, which are outlined below.  After you perform each step, enter the transaction hash into the variable as specified, and then get the URL via `./bitcoinctl.py geturls`.  You can check that URL to ensure that it works properly.  As with the previous transactions, you have to wait up to 10 minutes for at least one confirmation before you can redeem that UTXO.

1. You (Alice) transmits [TXN 1](../../slides/bitcoin.html#/xchainpt1) to the tBTC network, which was created by the `atomicswap_scriptPubKey()` function.  Be sure to set the `utxo_index` variable in scripts.py to a valid index before running this part!  This is run via `./bitcoinctl.py part4a`.  Save the transaction hash for this in the `txid_atomicswap_alice_send_tbtc` variable.
2. Bob transmits [TXN 3](../../slides/bitcoin.html#/xchainpt2) to the BCY network, which was also created by the `atomicswap_scriptPubKey()` function.  Be sure to set the `utxo_index` variable in scripts.py to a valid index before running this part!  This is run via `./bitcoinctl.py part4b`.  Save the transaction hash for this in the `txid_atomicswap_bob_send_bcy` variable. 
3. Alice (you) can redeem TXN 3 on the BCY network, which reveals the secret.  Be sure to set the `utxo_index` variable in scripts.py to a valid index before running this part!  This is run via `./bitcoinctl.py part4c`.  Save the transaction hash into `txid_atomicswap_alice_redeem_bcy`.
4. Bob can new redeem TXN 1 on the tBTC network, since he knows the secret which Alice just revealed via her redemption above.  Be sure to set the `utxo_index` variable in scripts.py to a valid index before running this part!  This is run via `./bitcoinctl.py part4d`.  Save the transaction hash into `txid_atomicswap_bob_redeem_tbtc`.


### Part 5: Pay back the tBTC faucet address

Once you have completed this assignment, you should pay any unspent tBTC UTXOs back to the faucet address.  You can use the script from part 1 for this -- just change the `utxo_index` value and re-run it until all the UTXO indices are spent.  If you have any other inputs -- perhaps you used the faucet multiple times -- just change the `txid_split` variable (and the `utxo_index` and the `send_amount`), and then call `./bitcoinctl.py part1`.  But be sure to change those values back!!!

When done, there should not be any unspent UTXOs remaining!  We are going to test this by seeing if the amount of tBTC left in your wallet address is zero.

You do not need to do this for the extra BCY in your account(s).

### Submission

The only file you need to submit is scripts.py.  There will be a few sanity checks made when you submit it.  Those checks are:

- Ensure that the `userid` returns a non-zero length string
- Ensure that the three values set during setup (`my_private_key_str`, `my_invoice_address_str`, and `txid_initial`)
- Ensure that all the transaction hashes (all the variables that start with `txid_`) are of the expected length (64 characters)
- Ensure that the split transaction was split into at least 5 different UTXO indices
- Ensure that the four parts verify via `VerifyScript()`.  This does NOT mean they work correctly!  It just means that the `VerifyScript()` function did not detect errors.  For one example, the `VerifyScript()` has no way of knowing the actual signature required on the blockchain.  This is the same function that is run before broadcasting the transactions to the network.  The full grading will check what is on the blockchain itself.
- Ensure that the final balance of the tBTC wallet (from `my_invoice_address_str`) is zero

