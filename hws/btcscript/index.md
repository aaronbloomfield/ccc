Bitcoin Scripting
=================

[Go up to the CCC HW page](../index.html) ([md](../index.md))

### Overview

In this assignment you will be writing a series of Bitcoin scripts to enact transfers.  You will be using a Bitcoin test network to do so.  While regular Bitcoin uses the abbreviation BTC, we will use the abbreviation 'tBTC' (for test-BTC) for the Bitcoin on our test network.

There are four separate Bitcoin scripts that you will need to write.  You will need to be familiar with the [Bitcoin slide set](../../slides/bitcoin.html#/), specifically the [Bitcoin Script](../../slides/bitcoin.html#/script) and [Cross-Chain Transactions](../../slides/bitcoin.html#/xchain) sections.  You will also likely need to refer to the [Bitcoin Script wiki page](https://en.bitcoin.it/wiki/Script).

You will be submitting an edited version of [scripts.py](scripts.py.html) ([src](scripts.py)).


### Changelog

Any changes to this page will be put here for easy reference.  Typo fixes and minor clarifications are not listed here.  So far there aren't any significant changes to report.


### Languages

This assignment uses the [python-bitcoinlib package](https://pypi.org/project/python-bitcoinlib/) (documentation is [here](https://python-bitcoinlib.readthedocs.io/en/latest/), if you are interested, but you probably won't need it).  Thus, this assignment must be completed in Python.  You can install the Python package via `pip install python-bitcoinlib` (you may need to use `pip3` on your system).  Note that bitcoinlib, python-bitcoinlib, and bitcoin are all different libraries!  We are specifically using python-bitcoinlib.

You also will have to install the `requests` library: `pip install requests`, as one of the provided files, below, uses that library.

We provide you with a few files to use:

- [scripts.py](scripts.py.html) ([src](scripts.py)): you will modify this file throughout this assignment.  The progression of items in that file mirrors the progression of the assignment steps herein.  This is the only file that you will submit.  We would expect that you would be able to understand everything in this file by the end of the assignment
- [bitcoinctl.py](bitcoinctl.py.html) ([src](bitcoinctl.py)): this is the driver file that will run the various parts of the assignment using the values in the above scripts.py.  You are of course welcome to look at the details, but you are not expected to understand the code that is in that file.

### Hints

This can be a tricky assignment, and there are a lot of ways to run into problems.  We include a number of hints here to try to head that off -- please read through all of these!

#### Development Tips

- You will often have to wait until a previous transaction has been confirmed before you can run a successive transaction.  If you look at the page for the wallet or the transaction (both described below), you need at least one confirmation (not 6, like with real BTC).  Many of the follow-on transactions will not work properly if the funding UTXO transaction has not been confirmed.
  - Confirmation can take some time -- 10-20 minutes is not unreasonable.  Start early and plan to work on other things while it's bouncing around the mempool waiting to be confirmed.
- You can, and should, use a site such as [https://siminchen.github.io/bitcoinIDE/build/editor.html](https://siminchen.github.io/bitcoinIDE/build/editor.html) to test your code.  Note that this site is, by necessity, limited in what it can do.  It will try to execute the scripts, but it doesn't always know if there is enough balance, if the corresponding UTXO script matches, etc.  So use that site to get started, but be sure to test your scripts via the means specified in this assignment.



#### General Hints

1. **UTXO indices:** each transaction has one more more UTXO indices -- each transaction output creates a separate UTXO index.  To find out what UTXO index you need to use, *view the transaction on the blockcypher.com website* (the URL for that will be discussed shortly).  All UTXO indices start from 0, like arrays.  In particular, for your funding transaction, your UTXO index will probably not be 0.  You need to set the UTXO variable for **EACH** transaction to the correct UTXO index.  The preferred way to do this is via the second command line parameter, but can also be set via the `utxo_index` value in scripts.py.  Note that the command-line parameter will override the `utxo_index` value.
2. After each transaction, there is a place to store the transaction hash.  Be diligent about doing this -- it's really easy to lose track of which of a dozen transaction hashes is which.  Keeping them in the stated variables will help with this.  You are welcome to store values in additional variables, as long as they are different names than the ones currently in scripts.py.
3. Don't modify the variable or function names in the scripts.py file.  Otherwise the provided functions, and our grading routines, will not work.  You can *add* functions and variables with different names, but don't change the ones currently there.
4. For *EACH* transaction, you will need to set the UTXO.  If you get an error stating that the UTXO index is already spent, it's likely that you forgot to set this variable.  If it sounds like we are repeating this, it is because this is, by far, the most common mistake made in this assignment.
5. Some errors with the Bitcoin scripts can be determined prior to broadcasting it on the Bitcoin test network.  This is done by the `VerifyScript()` method, which the provided code base calls for you before any attempted broadcast transaction.  So if you see an error such as, `verifyerror: "bitcoin.core.scripteval.VerifyOpFailedError: EvalScript: OP_EQUALVERIFY failed`, or similar, it means that the Bitcoin library was able to detect that your script would not work, and did not broadcast the transaction.
6. We provide you with a `create_CHECKSIG_signature()` function in the scripts.py file -- use it!  See the comments in that file for details as to how.  We also describe its usage below (the end of the Python Library section).
7. To save you the tedious task of having to learn the [Python Bitcoin library](https://pypi.org/project/python-bitcoinlib/) (documentation is [here](https://python-bitcoinlib.readthedocs.io/en/latest/), if you are interested) -- which you probably will never need to use again -- much of the library interaction has been handled for you by the provided code in [bitcoinctl.py](bitcoinctl.py.html) ([src](bitcoinctl.py)).  But in order for that to work, you have to proceed through this homework in the order written.
8. If you want to put the number 2 onto the stack, you can't just use the integer value 2.  Instead, you have to use the `OP_2` opcode.  In fact, `OP_2` happens to have integer value 82, and the integer value 2 has a different meaning.

#### Common Errors

We will add to this list as more errors (and their solutions) are reported to us.

- "Error validating transaction: Transaction ... referenced by input 0 has lesser than 3 outputs" means the UTXO index you provided is wrong (probably too high)
- "Error validating transaction: Transaction ... referenced by input 0 has already been spent" means the UTXO index you provided is wrong (probably too low)
- "Error validating transaction: Error running script for input 0 referencing ... at 0: Script was NOT verified successfully" is when the scripts don't work together
- A "409 Conflict {}" error occurs when you attempt to spend a UTXO that's already been spent; this usually happens when you forget to set the UTXO to an unspent index
- "witness script detected in tx without witness data": your UTXO is wrong
- "unsupported hash type ripemd160": see [here](https://stackoverflow.com/questions/72409563/unsupported-hash-type-ripemd160-with-hashlib-in-python) for how to fix this

#### Mac OS X issues

If you have a M1 Mac, there are a few issues you should be aware of.

Installing OpenSSL via homebrew has caused errors in past semesters.  These errors report a problem with the "libeay32" library.  Here are some possible solutions that have helped in the past:

- Installing OpenSSL as per [https://www.davidseek.com/ruby-on-m1/](https://www.davidseek.com/ruby-on-m1/)
- You can replace the OpenSSL library that python-bitcoinlib calls.  In the bitcoin package, in `/Library/Frameworks/Python.framework/Versions/3.9/lib/python3.9/site-packages/bitcoin` (that may differ on your machine), in `core/key.py`, replace `_ssl = ctypes.cdll.LoadLibrary(ctypes.util.find_library('ssl.35')` or `ctypes.util.find_library('ssl')` or `ctypes.util.find_library('libeay32')` with `_ssl = ctypes.cdll.LoadLibrary(ctypes.util.find_library('ssl.35')` or `ctypes.util.find_library('ssl'))`.

We cannot vouch for any of these solutions; we just collected a bunch of Piazza responses from previous semesters.


### Testnet

As we do not want to have to buy, and likely lose, real BTC, we are going to use a Bitcoin test network.  Because the coins we are going to be using are not "real" Bitcoins, we will use the abbreviation 'tBTC' (for testnet-BTC) instead of 'BTC'.  When using a test network, you get coins for free via a *faucet* -- in the same way that a water faucet provides water once turned on, so does a testnet faucet provide free tBTC when requested.

You will need around 0.001 ($10^{-3}$) tBTC for this assignment.  You can obtain this all at once, or as needed throughout the assignment.  You will likely have to use multiple faucets, or use the same faucet multiple times (there is a multiple-hour wait between requests to a given faucet) to obtain this amount.

1. You will need to generate a tBTC key pair.  Run `python3 bitcoinctl.py genkey`, and note both the public and private keys.  While these keys are not valid on the main Bitcoin test network -- the have a different value for the [version byte](../../slides/bitcoin.html#/btcaddress) in the invoice address -- you will need them throughout this assignment.
    - Save both the tBTC private key and the tBTC address into the scripts.py file into the `private_key_str` and `invoice_address` fields
2. Using multiple faucets, or multiple requests to the same faucet, you need to obtain around 0.001 ($10^{-3}$) tBTC.  This can be done all at once or as needed throughout the assignment.  A list of faucets is below, but read the through the next step herein before using them.  For each of the faucets below, you will be provided a transaction hash -- save that hash!  You may have to search down the web page for the specific transaction hash that pays to your tBTC address.  And see the next step, below, for how to find your current balance.
   - The only faucet that currently (spring 2025) seems to work: faucet at [coinfaucet.eu](https://coinfaucet.eu/en/btc-testnet/): pays about 1/6,000th of a tBTC
   - Other possible faucets:
     - https://cryptopump.info
     - https://tbtc.bitaps.com 
3. Each faucet will provide you with a transaction hash where it gave you the tBTC.
    - Enter each faucet funding transaction hash in scripts.py in `txid_funding_list`; each one is just a separate string in that list
    - Verify that you can view your account information at https://live.blockcypher.com/btc-testnet/address/&lt;address&gt; where &lt;address&gt; is your tBTC address -- the amount that address holds should be the sum of the amounts that the faucet provided to you.
      - You can also go to [https://live.blockcypher.com](https://live.blockcypher.com) and enter the wallet address in the search box -- just be sure to select "Bitcoin Testnet" in the blue drop-down box
      - It may take a few minutes or so for a transaction that funded your wallet to be mined into the blockchain
    - You can also view individual transactions at [https://live.blockcypher.com/](https://live.blockcypher.com/) -- put the transaction hash in the search box and be sure to select 'Bitcoin Testnet' for the search.  Verify that you can view the transaction at `https://live.blockcypher.com/btc-testnet/tx/<txid>` where `<txid>` is your transaction hash
      - Note that the testnets often perform many transfers in one transaction -- so the total amount transacted may be more than 0.0001 ($10^{-3}$) or so tBTC, but the rest was paid back to the faucet
    - You can also get these URLs by running `python3 bitcoinctl.py urls`.  As you fill in more transaction hashes throughout this assignment, re-running this command will show an increasing list of URLs.
4. Each faucet transaction paid to the invoice address via only one UTXO, and we would like multiple UTXO indices to use -- this way we can use one per question part, and we have a few extra if something ends up not working correctly.
    - We are going to split the incoming UTXO into multiple smaller UTXOs.  Each of the smaller UTXOs will need to about 1/10th of the tBTC received from the faucet.
    - Look at the section of scripts.py that deals with splitting coins.  The default values there will need to be changed
      - The `txid_split` is the particular transaction hash that you are splitting, which should be in the `txid_funding_list` list -- you may have to run this multiple times to split multiple faucet funding UTXOs, each with a different transaction hash from the faucet
      - The `split_amount_to_split` is how much is in the incoming UTXO; look this up on [https://live.blockcypher.com](https://live.blockcypher.com) to get the correct amount
      - The `split_amount_after_split` is how much you want in each UTXO after the split -- it should not be less than 0.00001 BTC ($10^{-5}$)
      - The `split_into_n` attempts to determine how many UTXOs to split it into, and you should not need to change it
      - Do NOT change `utxo_index` -- the UTXO index is set via a command-line parameter, described below
      - **DETERMINE YOUR UTXO INDEX**: this is done via the second command-line parameter, and you must set it for the particular UTXO index for the transaction where that you are splitting.  Most faucets pay themselves in UTXO index 0, and then pay out the requested invoice address in index 1.
      - Check the transaction -- via the URL from above -- that gave you the coins, and make sure you have the right UTXO index (via the second command-line parameter).  If you get an error such as "witness script detected in tx without witness data", then it probably means your UTXO index is wrong.
    - Run `python3 bitcoinctl.py split <utxo>` to split your coins.  The `<utxo>` field is the integer UTXO index, which is indexed from 0.  This uses the values in the splitting coins section of scripts.py that were just discussed.
      - If this works properly, it will present back a Python dictionary that will take up many lines.  If it doesn't work, it will give you an error in just a few lines.
    - You need to put the hash of that transaction in the `txid_split_list` list -- there are two ways to determine that hash:
        - It's the 5th (or so) line printed in the [JSON](https://en.wikipedia.org/wiki/JSON) output when you called the split command, above -- it's the `hash` line.  Note that there may be up to 4 lines of output before the JSON output starts.
        - Look at the *wallet* info URL (run `python3 bitcoinctl.py urls` to get the URL), and note the transaction hash of the split transaction -- it should be the top transaction listed, and will have 9 or 10 different outputs.  The transaction hash itself is also listed in the output from the split transaction -- it's the `hash` field of the dictionary, and is about a half a dozen lines down.  Record that transaction hash in scripts.py in `txid_split_list`

Be careful not to lose the information (keys and TXIDs) that you recorded above.  To prevent abuse, the faucets only allows one request every so often (1 hour to 1 day, depending on the faucet) for a given IP address or tBTC address.  If you need more during that window, or you are running into 'exceeded limit' issues, you can try requesting it through a different faucet or through your cell phone.  If you put it on cellular (meaning disconnect from UVA's network), it will report a different IP address to the faucet.

### Python library

The `python-bitcoinlib` library for Python handles much of the heavy lifting -- conversion from one type to another, encryption, signing, verification, etc.  If you were to enter actual keys that have real BTC then you could use this library to make real BTC transactions.

While the library can do many things, below is a quick summary of the relevant aspects that you will need to know for this assignment.

- Creating Bitcoin scripts is really just putting everything into a list.  All the opcodes are named the same as on the [Bitcoin Script page](https://en.bitcoin.it/wiki/Script).  For example, here is the the [provably unspendable transaction](../../slides/bitcoin.html#/unspendable) discussed in the lecture slides: `[ OP_RETURN ]`.  Other things that go into scripts -- signatures and public key hashes -- are also just included in such a list.  Assuming you got the types correct, then the library will create the full script from such a list.
- You will enter your private key into scripts.py as a string.  To convert it to the private key format that the library uses, you pass it to `CBitcoinSecret()`.  The object returned has a `.pub` field, which is the public key (the type of that public key is `CPubKey`).  And that public key can be converted into a Bitcoin address by calling `P2PKHBitcoinAddress.from_pubkey(public_key)`.  In fact, this is almost the exact code used by the [bitcoinctl.py](bitcoinctl.py.html) ([src](bitcoinctl.py)) file to generate keys (although for that it just used random data -- via `os.urandom(32)` -- instead of a pre-defined public key string).  Here is an example as to how to convert your keys:
  ```
my_private_key_str="..." # fill this in
from bitcoin.wallet import CBitcoinSecret, P2PKHBitcoinAddress
from bitcoin import SelectParams
SelectParams('testnet')
private_key = CBitcoinSecret(my_private_key_str)
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


### Part 1: P2PKH

The UTXO indices that you created when you split your tBTC are paid to a standard [P2PKH transaction](../../slides/bitcoin.html#/p2pkh).  Your task is to redeem them by writing the appropriate scripts (pubkey and sigscript) to redeem the coins from one of the UTXOs.  It should be paid back to the designated return address -- use the `tbtc_return_address` variable, defined at the top of the `scripts.py` file, as the receiver of this transaction.

To complete this transaction, you need to complete four things:

- The `P2PKH_scriptSig(...)` function provides the sigscript needed to redeem the UTXO being spent.  The UTXO that is being redeemed -- one of the split UTXO indices from above -- requires a P2PKH sigScript to redeem one of the indices.
- The `P2PKH_scriptPubKey(address)` function defines the pubKey script (aka output script).  This was discussed in lecture in the [P2PKH transaction](../../slides/bitcoin.html#/p2pkh) slides.  This script creates a new UTXO, payable to the tBTC return address, that is also a P2PKH script.  The parameter is of type `P2PKHBitcoinAddress`, which is what the `P2PKHBitcoinAddress.from_pubkey(public_key)` call (shown above) returns; a variable this type can be put directly into a script.
- Set the output index to spend via the second command line parameter.  Recall that output indices start from 0, not 1.  Be sure to pick an unspent index!  If you have to run this multiple times, you may have to change this value to an unspent index.

**IMPORTANT NOTE:** For the sigScript, the public key used in the P2PKH script must come from the `private_key` parameter to the `P2PKH_scriptSig()` (it's `private_key.pub`).  If you use your global public key, it will work for this part, but it will fail for successive parts of this assignment.

When you have finished the script, you can run it via `python3 bitcoinctl.py part1 <utxo>`, where `<utxo>` is the particular UTXO index from the split transaction that you are using to fund this one; it will report an error if you get it wrong.  The `<utxo>` field is the integer UTXO index, which is indexed from 0.  Some common errors at this point are:

- "Error validating transaction: Transaction ... referenced by input 0 has lesser than 3 outputs" means the UTXO index you provided is wrong (probably too high)
- "Error validating transaction: Transaction ... referenced by input 0 has already been spent" means the UTXO index you provided is wrong (probably too low)
- "unsupported hash type ripemd160": see [here](https://stackoverflow.com/questions/72409563/unsupported-hash-type-ripemd160-with-hashlib-in-python) for how to fix this

If it works, you will see a JSON dictionary printed to the screen.  Record the transaction hash of that transaction in `txid_p2pkh`.  The TXID is the 'hash' field in the dictionary that is printed to the screen when run.  You can then run `python3 bitcoinctl.py urls` to get the URL for the transaction that you just executed.  It may take up to 10 minutes for it to be mined into the blockchain.

You should notice your wallet balance has decreased.


### Part 2: Puzzle

For this tBTC transaction, you are going to create an algebraic puzzle script -- one that anybody can redeem as long as they complete the numerical puzzle.

You will first need to pick two 4-digit base-10 numbers (meaning between 1,000 and 10,000 in value) for the values of $p$ and $q$ in the equations below.  You can take your UVA SIS ID and split the digits in half.  These will be the solutions to the linear equations below.  You will likely need to tweak these numbers in a moment.  You will need to store those values into `puzzle_txn_p` and `puzzle_txn_q` in scripts.py.

The puzzle transaction will deal with the solution to the following two linear equations:

$$2x+y=p$$
$$x+y=q$$

<!-- spring 2022: 2x+y / x+2y -->
<!-- fall 2022: 3x+y / x+3y -->
<!-- spring 2023: x+y / x+2y -->
<!-- fall 2023: 2x+y / x+y -->

You can use an online linear question solver, such as [this one](https://onsolver.com/system-equations.php), to find the solution.  And ***make sure*** that the solutions are positive integer values!  If not, then tweak one (or both) of your solutions ($p$ and/or $q$) until you have integer solutions.  You can also change which of the equations has the higher of $p$ and $q$ to see if that will help as well.  Once you know those values, put them into `puzzle_txn_p` and `puzzle_txn_q` in scripts.py.  You will also want to $x$ and $y$ solutions to these equations into `puzzle_txn_x` and `puzzle_txn_y`.

#### Send the puzzle transaction

For this part, you will create a transaction to redeem one of the split UTXO indices that were created, above.  The pubKey (output) script of that newly created transaction will be specified in the `puzzle_scriptPubKey()` function in scripts.py.  Note that because this output script does not depend on the receiver's public key, that is not provided as a parameter to the function.  Also note that the `OP_MUL` opcode has been disabled on the Bitcoin networks, so you can't use that.  This pubKey script should verify that the two values specified by the redeemer fulfill those two equations.  Once this is created, run `python3 bitcoinctl.py part2a <utxo>` -- remember to choose an unspent UTXO index first via the second command line parameter.  That `<utxo>` field is the integer UTXO index from the split transaction, which is indexed from 0.  As above, record the transaction hash into the `txid_puzzle_txn1` variable.

#### Redeem the puzzle transaction

You will also need to create the sigScript that redeems this transaction.  This should **ONLY** contain the two values $x$ and $y$ -- their order is up to you, as long as it works with the script you created above.  That script goes into `puzzle_scriptSig()`.  

**IMPORTANT:** Your your pubKey script should actually do the math to test that the two values (that will be provided in the sigScript) do, in fact, fulfill those linear equations.  Just testing for equality to your pre-specified $x$ and $y$ is not the point of this portion of the assignment.  This is something we explicitly check for when grading the assignment.

This also does not depend on any signatures, which is why there are no parameters to that function.  Ensure that the previous transaction has been mined into the blockchain, which may take up to 10 minutes -- if you have entered the previous transaction's URL into the `txid_puzzle_txn1` variable, you can get the URL of that transaction via `python3 bitcoinctl.py urls`.  When ready, you can send the redeeming trasnaction to the tBTC network via `python3 bitcoinctl.py part2b <utxo>` (remember to choose an unspent UTXO index first).  The `<utxo>` field is the integer UTXO index, which is indexed from 0.  As this UTXO is from the above transaction, and that transaction only created one UTXO index, the `<utxo>` value should be 0.

Record the transaction hash into `txid_puzzle_txn2`.

#### Notes

WARNING: There are occasionally people who redeeming all of our puzzle transactions (part 2a) on the Bitcoin test network -- they are parsing the output script, computing the answers, and redeeming the transaction. Because this script does not have a signature, anybody can redeem it. If you keep getting oddball errors, and you have set your transaction hash and UTXO index correctly, check the transaction page itself to see if it's already spent.  When running `part2b` it might also report that the UTXO has been spent.  For the puzzle transactions, blockcyper.com just says “unknown script type”, and does not indicate if it's spent or not, but 
[https://blockstream.info](https://blockstream.info) does; search for the transaction from part 2a, and in the lower-right of that page where it lists the output, click on the "Details +" link -- it will list the hash of the spending transaction.  You should include that transaction hash in your scripts.py, even though you were not the entity that redeemed it.  When grading it, we will look at (1) if the transaction from part 2a was broadcast, (2) whether it was redeemed (by you or somebody else), and (3) whether the two scripts verify with each other. Thus, it does not have to be *your* transaction that redeems part 2a in part 2b, but your part 2b script does have to verify with your part 2a script.

You will notice that the amount in each UTXO index from the split transaction is 0.001 tBTC.  For the first half of this puzzle transaction, the amount transacted is slightly less (90% of that, or 0.0009).  The difference -- 0.0001 tBTC -- is the transaction fee.  Even though this is a test network, and no actual money is involved, your transaction will not be mined into the blockchain unless you have a sufficient transaction fee.  For the second half of this, we need to lower the amount even further, so the amount transacted is 90% of 0.0009, or 0.00081; this lowering is done automatically by the code base provided.  The difference here -- 0.00009 tBTC -- is the transaction fee.  This automatic lowering of the transaction amount will recur elsewhere in this assignment.


### Part 3: Multisig

You are going to create a multi-signature transaction, which must use the [OP_CHECKMULTISIG opcode](../../slides/bitcoin.html#/checkmultisig) (or the [OP_CHECKMULTISIGVERIFY opcode](../../slides/bitcoin.html#/checkmultisig)).

To set this up, you will need to create three more key pairs using `python3 bitcoinctl.py keygen`.  Save these in the variables for Alice, Bob, and Charlie in part 3 of the `scripts.py` file.  These addresses don't need any tBTC -- we just need the key pairs to perform digital signatures.

The scenario is this: you are taking on the role of a bank.  Three siblings (Alice, Bob, and Charlie) have deposited money into an account, and it can be redeemed if two of the three -- and also the bank! -- agree to it.  Formally, the transaction must be signed by the bank (i.e., you -- via the keys in the `my_private_key_str` variable) and any two of the three siblings (via their private keys).

This will actually require two transactions.  The first redeems one of the split UTXOs and creates a multi-signature pubKey (output) script.  The second redeems that multi-signature script and pays it to the tBTC return address.  

1. Transaction 1: tBTC funds are taken from one of your split UTXO indices and put into a new UTXO whose output script requires the multiple signatures
    - The sigScript for this will be taken from your part 1 (P2PKH), above -- specifically from `P2PKH_scriptSig()`.  So you don't have to write this again.  If your part 1 (P2PKH) worked, then this should work as well.
    - The pubKey script for this you will be writing in the `multisig_scriptPubKey()` function.
    - Once successfully executed, record the transaction hash in the `txid_multisig_txn1` variable.
2. Transaction 2: tBTC the funds from the multisig UTXO are redeemed and paid back to the tBTC return address.
    - The sigScript for this you will be writing in the `multisig_scriptSig()` function.
    - The pubKey script for this will be taken from your part 1 (P2PKH) above -- specifically from `P2PKH_scriptPubKey()`.  So you don't have to write this again.  If you part 1 (P2PKH) worked, then this should work as well.
    - Once successfully executed, record the transaction hash in the `txid_multisig_txn2` variable.

You only have to write the pubKey (output) script of the first transaction, and the sigScript (input) script of the second transaction.  The other two parts (sigScript of the first and pubKey script of the second) are taken from your code in part 1 (P2PKH) -- so if that is not working, then this will not work either.

The first step is to create the transaction that sets up the multi-signature requirement in the pubKey script.  This must use either the `OP_CHECKMULTISIG` or `OP_CHECKMULTISIGVERIFY`opcode!  See the [description of these opcodes](../../slides/bitcoin.html#/checkmultisig) in the lecture slides.  The task, then, is to fill in the `multisig_scriptPubKey()` function.  Recall that the sigScript will be used from your code for part 1 (P2PKH).  We recommend that you write this and the next script -- the redeeming script -- together, and trace its stack execution (on paper or similar).  When you are ready to run it, run `python3 bitcoinctl.py part3a <utxo>`.  The `<utxo>` field is the integer UTXO index, which is indexed from 0.  Once successful, record the transaction hash in the `txid_multisig_txn1` variable in scripts.py.

The second step is to create a transaction that will redeem it.  You will have to wait until the previous transaction receives at least one confirmation before you can execute this part, which can take up to 10 minutes.  This part requires that the `txid_multisig_txn1` variable, from the first step above, is set properly, as that is the UTXO that is going to redeem.  You will fill in your sigScript into `multisig_scriptSig()`.  Recall that the pubKey script for this transaction will be used from your answer for part 1 (P2PKH).  When you are ready to run it, run `python3 bitcoinctl.py part3b <utxo>`.  The `<utxo>` field is the integer UTXO index, which is indexed from 0; it is likely 0, since there is only one output from the UTXO from the transaction from part 3a. Once successful, record the transaction hash in the `txid_multisig_txn2` variable in scripts.py.

IMPORTANT NOTE: For the `OP_CHECKMULTISIG` (or `OP_CHECKMULTISIGVERIFY`), it should have ONLY the keys/signatures of Alice, Bob, and Charlie; the bank signature should not be in there. Instead, the bank signature should be separate and verified with an `OP_CHECKSIG` (or `OP_CHECKSIGVERIFY`). The reason is that if everything is in the `OP_CHECKMULTISIG`, then an empty set of signatures and keys will verify correctly. This is relevant because there is some user on the Bitcoin test network who is trying to redeem your UTXOs.  In particular, it has been observed when the UTXO was only verified with a single `OP_CHECKMULTISIG`.

### Part 4: Cross-chain

In this part you will create the scripts for a [cross-chain transaction](../../slides/bitcoin.html#/xchain).  Typically this would be for two different cryptocurrencies.  However, since we have only learned Bitcoin Script, we will use that for both parts.  There are many cryptocurrencies that are forks of Bitcoin, and thus have the same scripting language, so the same program could work for any of them.  A completely different cryptocurrency, with a different scripting language, would have an analogous script.  However, to test this we will be using two *different* Bitcoin testing blockchains.

Below you will be obtaining a Bitcoin key pair and funds on a separate Bitcoin blockchain.  There will be *three* script producing functions in scripts.py, although you only have to create one.  The first one, `atomicswap_scriptPubKey()`, will create the [TXN 1 and TXN 3 from the slides](../../slides/bitcoin.html#/xchainpt1); this is the one that you have to create.  This script will be used for BOTH of these transactions (with different parameters, of course) on the two different blockchains by the provided code in [bitcoinctl.py](bitcoinctl.py.html) ([src](bitcoinctl.py)).  The second function, `atomcswap_scriptSig_redeem()`, will be when Alice or Bob knows the secret value and is redeeming the BTC; we provide this function for you in scripts.py.  This is used in steps 5 and 6 on [cross-chain atomic swap procedure slide](../../slides/bitcoin.html#/atomicsteps).  The third function, `atomcswap_scriptSig_refund()`, will create the time-out redeeming script, which is [TXN 2 and TXN 4 from the slides](../../slides/bitcoin.html#/xchainpt1); we also provide this function for you in scripts.py.  Again, this will be used on both blockchains by the provided code.  There are some requirements for what has to be in these scripts, described below (in "Notes and hints").

In addition to the lecture slides, you may want to refer to the [Atomic swap article](https://en.bitcoin.it/wiki/Atomic_swap) in the [Bitcoin wiki](https://en.bitcoin.it/wiki/Main_Page).

So far we have been using tBTC on the Bitcoin Testnet.  For this part we will also be using the BlockCypher Testnet -- this is also a Bitcoin network for testing, and it operates just like the Bitcoin Testnet we've been using.  Bitcoin on this other testnet will be abbreviated as BCY (for BlockCYpher testnet).  Note that we have been using [blockcypher.com](https://live.blockcypher.com/) to view all of our transactions, since that site can display transactions and invoice addresses on both of these Bitcoin test networks.

In this part, you (Alice) and Bob will be exchanging coins through a cross-chain transaction.  You will need to be familiar with the [cross-chain transaction section of the Bitcoin slide set](../../slides/bitcoin.html#/xchain).  You are going to take on the role of Alice in the lecture slides.

As an overview, this is what is going to happen.

1. You (Alice) are going to create a transaction to send tBTC to Bob.  You will send it from the account you have been using so far (saved in `my_private_key_str` and `my_invoice_address_str` in scripts.py).  Bob will receive it in the account that was created for him above (`bob_private_key_str` and `bob_invoice_address_str` in scripts.py).  This corresponds to [part 1 of the cross-chain transaction](../../slides/bitcoin.html#/xchainpt1) -- again, you are taking on the role of Alice.  You will only be creating TXN1 from that slide; we are omitting TXN2.
2. Bob will create a transaction to send BCY to you.  Both you and Bob will need to create invoice addresses and public keys for the BCY testnet, which we guide you through below.  This corresponds to [part 2 of the cross-chain transaction](../../slides/bitcoin.html#/xchainpt2) -- again, you are taking on the role of Alice.  You will only be creating TXN3 from that slide; we are omitting TXN4.
3. You (Alice) will redeem TXN3 on the BCY network, exposing the hidden secret.
4. Bob, now knowing the hidden secret, will then redeem TXN1 on the tBTC network.

Note that you are only creating one function, called `atomicswap_scriptPubKey()`.  This is going to be used for both of the steps 1 (where you (Alice) send tBTC to Bob) and 2 (where Bob send BCY to you (Alice), above.

#### BCY Setup

To set this up, we need to create Bitcoin keypairs for the BlockCypher testnet, and use a faucet to give us some coins.  The process for creating keys and funding the accounts is different for the BCY test network.  The BCY blockchain uses a different [version byte](../../slides/bitcoin.html#/btcaddress) in the invoice address, so we cannot re-use the invoice addresses generated above for the BCY blockchain.

1. Create an account at [https://accounts.blockcypher.com/](https://accounts.blockcypher.com/), which will allow you to get an API token.  Your token will be a hex number such as 0123456789abcdef0123456789abcdef.  Save this token somewhere safe!  You are welcome to record it in scripts.py (`blockcypher_api_token` is set aside for that), but that's completely optional.
2. To create keys, you will need to run the following from the command line: `python3 bitcoinctl.py bcy_key`.  You have to fill in the `blockcypher_api_token` field first, in the previous step, in scripts.py for this to work.  You should do this twice, one for you and once for Bob.
3. Save those tokens in scripts.py; yours go into `my_private_key_bcy_str` and `my_invoice_address_bcy_str` -- you only need the `private` and `address` values from the `bcy_key` command (you are welcome to save the others, if you would like -- just name the variables appropriately, or put them into comments).  Also note that the format of the private key is different for this network -- this one is hex encoded, whereas the one for the tBTC network was base-58 encoded.  The provided assignment code properly handles this difference.
4. Run that command again for Bob's keys, and save them into `bob_private_key_bcy_str` and `bob_invoice_address_bcy_str`.  Again, we only need to save the private key and the address, but you are welcome to save the other two parts as well.
5. Only Bob needs BCY funds.  You can fund his account via: `python3 bitcoinctl.py fund_bob`.
6. The above command will return a transaction hash; save that in `txid_bob_bcy_funding`.  If you run `python3 bitcoinctl.py urls` it will display the full URL that you can use to view that funding transaction.
7. We will need to split Bob's funds into parts, just like we did in the setup, above.  Make sure that you have Bob's private key and invoice address set in scripts.py (in `bob_private_key_bcy_str` and `bob_invoice_address_bcy_str`), as well as the transaction hash that funded the wallet (in `txid_bob_bcy_funding`).  Lastly, look at the URL for that funding transaction (you can get that via `python3 bitcoinctl.py urls`) and determine the UTXO index -- that needs to be set in the second command line parameter.  You will also need to change `split_amount_to_split` (likely to 0.001, but see your funding TXN) and `split_amount_after_split` (likely 0.0001, or 1/10th of the funding TXN amount).  But save your original values!  We will need to restore them in part4b, below.  Then run `python3 bitcoinctl.py splitbcy <utxo>` -- notice that the command is `splitbcy`, not `split`!  The `<utxo>` field is the integer UTXO index, which is indexed from 0.  Record the transaction hash returned from that execution run in `txid_bob_bcy_split`.

Whew!  The setup for this part is all done!  Now onto the scripting part....

#### Cross-chain atomic swap

Because we are swapping between two different Bitcoin test networks, the atomic swap code is the same -- both are in Bitcoin script.  TXN 1 (from [here in the slides](../../slides/bitcoin.html#/xchainpt1)) and TXN 3 (from [here in the slides](../../slides/bitcoin.html#/xchainpt2)) differ only by the public keys:

- TXN 1: Pay *w* BTC if either (*x* for *h(x)* known and signed by B) or (signed by A & B)
- TXN 3: Pay *v* BTC if either (*x* for *h(x)* known and signed by A) or (signed by A & B)

Your script code for this will go into the `atomicswap_scriptPubKey()` function.

**NOTE:** the hash that is used in this part is RIPEMD-160, *not* SHA-256. So be sure to use the `OP_HASH160` opcode to get the hash, and not the `OP_SHA256` opcode.

To help you with this code, we provide the two redeeming functions:

- `atomcswap_scriptSig_redeem()` is when Alice or Bob, knowing the secret, wants to redeem the transaction.  The `OP_TRUE` is for use in an `OP_IF` statement in the script you have to write.
- `atomcswap_scriptSig_refund()` is used when the transaction times out -- that's when the sender can get a refund on his/her transaction; this has to be signed by both Alice and Bob.  The particular script sent to redeem this would be TXN 2 (from [here](../../slides/bitcoin.html#/xchainpt1)) or TXN 4 (from [here](../../slides/bitcoin.html#/xchainpt2)).  You do not have to implement TXN 2 or TXN 4.  In practice, this would be time-locked in the future -- it would include a timestamp and call `OP_CHECKLOCKTIMEVERIFY`.  Because the time can not be known when the assignment is written, and as it will vary for each student, that part is omitted from the script.

The last thing to do before you write the `atomicswap_scriptPubKey()` function is to determine what the secret is -- **pick a number between 17 million and 2 billion**, and save that in `atomic_swap_secret`.  (It needs to be in that range to ensure it's encoded as a 4-byte integer).  Keep in mind that this secret is only known to Alice initially; Bob is only given the hash of the secret (the bitcoinctl.py file handles that part for you).

Once you have written the script in the `atomicswap_scriptPubKey()` function, you can perform your cross-chain transaction.  This involves four steps, which are outlined below.  After you perform each step, enter the transaction hash into the variable as specified, and then get the URL via `python3 bitcoinctl.py urls`.  You can check that URL to ensure that it works properly.  As with the previous transactions, you have to wait up to 10 minutes for at least one confirmation before you can redeem that UTXO.

1. You (Alice) transmits [TXN 1](../../slides/bitcoin.html#/xchainpt1) to the tBTC network, which was created by the `atomicswap_scriptPubKey()` function.  Be sure to set the correct UTXO before running this part!  This is sending tBTC, so the UTXO index is from the very first split of tBTC.  This is run via `python3 bitcoinctl.py part4a <utxo>`.  The `<utxo>` field is the integer UTXO index, which is indexed from 0. Save the transaction hash for this in the `txid_atomicswap_alice_send_tbtc` variable.
2. Bob transmits [TXN 3](../../slides/bitcoin.html#/xchainpt2) to the BCY network, which was also created by the `atomicswap_scriptPubKey()` function.  Be sure to set the correct UTXO before running this part!  This is sending BCY, so it's the split that was done earlier in this section.  This is run via `python3 bitcoinctl.py part4b <utxo>`.  The `<utxo>` field is the integer UTXO index, which is indexed from 0. Save the transaction hash for this in the `txid_atomicswap_bob_send_bcy` variable.  If you get an error such as "Error validating transaction: Sum of inputs 1007 lesser than outputs 9000" or Your split_amount_to_split is less than or equal to split_amount_after_split", you need to restore the original tBTC values for 1split_amount_to_split` and `split_amount_after_split` (see step 7 in the cross-chain setup, above).
3. Alice (you) can redeem TXN 3 on the BCY network, which reveals the secret.  Be sure to set the correct UTXO before running this part!  This is run via `python3 bitcoinctl.py part4c <utxo>`.  The `<utxo>` field is the integer UTXO index, which is indexed from 0. As this is from TXN 2 above, the UTXO index is probably 0.  Save the transaction hash into `txid_atomicswap_alice_redeem_bcy`.
4. Bob can new redeem TXN 1 on the tBTC network, since he knows the secret which Alice just revealed via her redemption above.  Be sure to set the correct UTXO before running this part!  As this is from TXN 1 above, the UTXO index is probably 0.  This is run via `python3 bitcoinctl.py part4d <utxo>`.  The `<utxo>` field is the integer UTXO index, which is indexed from 0. Save the transaction hash into `txid_atomicswap_bob_redeem_tbtc`.

#### Hints and notes

- The `atomicswap_scriptPubKey()` function will create [TXN 1 and TXN 3 from the slides](../../slides/bitcoin.html#/xchainpt1); because this has to check for two cases, it has to have an if/else structure
  - The first case (providing the hash) has to check the hash of the passed secret and also verify that it's signed by B (for TXN 1) or A (for TXN 2)
  - The second case (timeout) has to check that it's signed by A and B (multi-sig!)
- The `atomcswap_scriptSig_redeem()`, used in steps 5 and 6 on [cross-chain atomic swap procedure slide](../../slides/bitcoin.html#/atomicsteps), just provides the hash and signature; this is provided to you in scripts.py.  You should design your function above to work with this as the redeeming script.
- The `atomcswap_scriptSig_refund()`, which is [TXN 2 and TXN 2 from the slides](../../slides/bitcoin.html#/xchainpt1), is also provided to you.  You should design your function above to work with this as the refund script.


### Part 5: Return tBTC

Once you have completed this assignment, you should pay any unspent tBTC UTXOs back to the tBTC return address, which is in the the `tbtc_return_address` variable in scripts.py.  You can use the script from part 1 (P2PKH) for this, as it already pays the tBTC return address -- just change the UTXO value and re-run it; repeat until all the UTXO indices from the tBTC split transaction are spent.  If you have any other inputs -- perhaps you used the faucet multiple times -- just change the `txid_split` variable (and the UTXO and the `send_amount`), and then call `python3 bitcoinctl.py part1 <utxo>`.  The `<utxo>` field is the integer UTXO index, which is indexed from 0. But be sure to change those values back!!!

You do not need to save the hashes from these transactions -- we are going to verify it by checking the wallet's balance.

When done, there should not be any unspent UTXOs remaining!  We are going to test this by seeing if the amount of tBTC left in your wallet address is zero.

You do not need to do this for the extra BCY in your account(s).

### Submission

**NOTE:** Make sure all the transactions are mined into the blockchain BEFORE you submit them.  If you go to the URL for that particular transaction, as long as it has at least one confirmation, it is considered mined into the blockchain.

The only file you need to submit to Gradescope is scripts.py.  There will be a few sanity checks made when you submit it.  Those checks are:

- Ensure that the `userid` returns a non-zero length string
- Ensure that the three values set during setup (`my_private_key_str`, `my_invoice_address_str`, and `txid_initial`)
- Ensure that all the transaction hashes (all the variables that start with `txid_`) are of the expected length (64 characters)
- Ensure that the split transaction was split into at least 5 different UTXO indices
- Ensure that the four parts verify via `VerifyScript()`.  This does NOT mean they work correctly!  It just means that the `VerifyScript()` function did not detect errors.  For one example, the `VerifyScript()` has no way of knowing the actual signature required on the blockchain.  This is the same function that is run before broadcasting the transactions to the network.  The full grading will check what is on the blockchain itself.
- Ensure that the final balance of the tBTC wallet (from `my_invoice_address_str`) is zero

**Rate Limiter:** The various aspects of this program are verified by checking via blockcyper.com's API to obtain the wallet, transaction, balance, etc.  As with most websites, there is a rate limiter, and if there are too many requests in too little a time period, then it will block requests to that IP address for some period.  If everybody submits the assignment around the same time, this rate limiter will kick in, and the auto-grader will reports lots of errors.  We will re-run the auto-grader at a later point to ensure that it is evaluated properly, but you will not see useful results when you submit your assignment.  We have set up a proxy to help this issue (it caches previously made requests).  However, if there are still too many requests, it will still run into the rate limiter.  Unfortunately, there is nothing more we can do about this.

**Autograder notes:** As we know, a transaction is not considered valid until it is mined into the blockchain.  It may be that your transaction has not yet been mined, which means it will report as not having happened.  This means some of the visible tests when you submit your assignment could fail.  As long as you submitted the transaction, you do not need to worry about it -- we will re-run the auto-grader a day or two later to catch all these cases.
