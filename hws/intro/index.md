Cryptocurrency Introduction
===========================

[Go up to the CCC HW page](../index.html) ([md](../index.md))


### Overview

You must design and implement your own cryptocurrency!  Your implementation must be secure enough that you could actually use it.

Your cryptocurrency should have a name -- ideally, think of a neat name, but make sure it is [not already taken](https://coinmarketcap.com/). It will have to use public/private key encryption to generate the wallets.  You do not have to use symmetric encryption (such as AES) to protect the private key in the wallet.  You will need to use a good hashing algorithm.  In practice, SHA-256 would be the minimum, but you can use a shorter SHA hash for this assignment.

The intent is not for you to write the hashing or encryption / decryption routines -- use existing libraries for that.  In particular, both Java and Python can do that for you.  Be careful about requiring an uncommon Python module or Java library, as it still has to run on the submission server. 


### Changelog

Any changes to this page will be put here for easy reference.  Typo fixes and minor clarifications are not listed here.  

- Clarified on 9/2: For `validate`: the blockchain is considered valid if only the genesis block exists; we will never call this function if the genesis block has not been created.  Because of this, you don't have to actually check if the genesis block exists, as we will never call validate on it if it does not exist.  Likewise, you don't have to do any checks on the genesis block file itself.


### Background

This homework is based on the material covered in the [Cryptocurrency Overview](../../slides/overview.html#/) slide set.


### Languages

You may use any programming language for this, but if you want to use a language other than Java or Python, please check with us first so that we can enable it on the submission server.  (If you are using another language, you have to let us know at least two days before the assignment is due so we have time to configure it.)

For Java and Python, we provide you with the code to convert a hex
string to an array of bytes, to convert an array of bytes to a hex
string, getting the SHA-256 hash of a file, and to read and write RSA
keys.  For Java, that is in the form of methods that you can use.  For
Python, it is links to the library functions that performs that task.

**Python:** you have to use Python 3 for this.  We will install the
[rsa](https://pypi.org/project/rsa/) package; the documentation for
that library, including code examples, is
[here](https://stuvel.eu/rsa).  Some of these functions will require
you to encode your message as ASCII (it gives 'Unicode-objects must be
encoded before hashing' message otherwise) -- just call
`.encode('ascii')` on the string first.  Encoding from a byte array to
a string is done via the
[binascii](https://docs.python.org/3/library/binascii.html) library.
Hashes in Python are in
[hashlib](https://docs.python.org/3/library/hashlib.html), which is
part of the Python installation.  To take the SHA-256 hash of a file,
see [this code on stack
overflow](https://stackoverflow.com/a/44873382).  You can see some
example code in the [sample.py](sample.py)
([html](sample.py.html)) file we have provided for you to use.  You can see [here](https://www.tutorialspoint.com/python/python_command_line_arguments.htm) for how to use command-line arguments.


**Java:** RSA and SHA are already in the standard Java library; you
can look [here](https://www.devglan.com/java8/rsa-encryption-decryption-java)
for how to handle RSA in Java, and see the [MessageDigest
class](https://docs.oracle.com/javase/8/docs/api/java/security/MessageDigest.html)
for SHA (and the example
[here](https://www.baeldung.com/sha-256-hashing-java)).  An example
about how to sign a message can be found
[here](https://niels.nu/blog/2016/java-rsa.html).  You may use any of
the code on those pages for your program.  Note that the Java version
on the submission server is OpenJDK 1.11.  We provide some methods in the
[Sample.java](Sample.java)
([html](Sample.java.html)) file we have provided for you to use.

<!-- **C/C++:** Boost is installed, as well as the openssl library.  There are many great things about C and C++, but be careful if you pursue this langage -- we think this will give you a real headache if you try to implement it in C or C++.  The compiler is `gcc` or `g++`. -->


### File format

**Blockchain**

The blockchain will be in files named `block_0.txt`, `block_1.txt`,
etc.  The zeroth block (`block_0.txt`) will be the genesis block, and
will not have any actual transactions in it.  Each successive block
after the genesis block will be of the following format:

- Line 1 will be the hash of the previous block
- Lines 2 to $n$-1 will each hold a transaction record (which is *not*
  the same as a transaction statement), one per line; these will be of
  the form `S transferred x to D on w`, where S is the source wallet,
  D is the destination wallet, x is the integer amount to
  transfer, and w is the date.  The date can be any format you would
  like, as long as it has the date and time (with seconds), but it must be human readable (so no unix timestamps).  In Java, 
  `new Date()` will achieve this; in Python 3, `str(datetime.now())`
  will do the same.
- The last line will have the nonce, which is determined when the
  block is mined


When generating the next block, you can assume that the previous block
file exists.  This means that we will generate the genesis block
`block_0.txt` from the `genesis` command (below) before validating the
first block.

Below is a sample block.  Note that we put blank lines between the
parts -- that's fine if you want to do that as well.

```
81d5d3bf8c93ac07d4b4654b9e7f06dee3285444a57de4191650eacf1b105a2e

bigfoot transferred 100 to a3e47443b0f3bc76 on Tue Apr 02 23:09:13 EDT 2019
bigfoot transferred 100 to 48adadf4fb921fca on Tue Apr 02 23:09:14 EDT 2019
a3e47443b0f3bc76 transferred 12 to 48adadf4fb921fca on Tue Apr 02 23:09:14 EDT 2019
48adadf4fb921fca transferred 2 to a3e47443b0f3bc76 on Tue Apr 02 23:09:15 EDT 2019

nonce: 120
```

The details about each line, as well as the 'bigfoot' concept, are
explained below.

**Mempool**

The blocks described above represent transactions that have been
completed.  Pending transaction records are to be placed in the
mempool, which we will appropriately call `mempool.txt`.  One of the
functionalities that you have to implement is the transfer of the
transaction records in the mempool into a block in the block chain
through mining.

Each line will have the same one-line format described above (`S
transferred x to D on w`).  You are welcome to use present tense as
well (transfers instead of transferred).  You can have a reasonable amount of additional
information after the required text, but it must all be on the same
line.  This is important -- each transaction record in the mempool must
be exactly one line!

Below is an example of a line from the mempool.  This line is a
*transaction record*, which is described next.

```
a3e47443b0f3bc76 transferred 12 to 48adadf4fb921fca on Tue Apr 02 23:09:14 EDT 2019
```

Note that this is the second-to-last line in the block shown above.


**Transaction statement versus transaction record**

A transaction *statement* is a multi-line text file that contains the
sender, the recipient, the amount, and ends with a digital signature.
Each transaction statement will be in its own file; one is shown below.

A transaction *record* is a single line in a mempool (and, later, in a
block in the blockchain) that contains similar information, but on a
single line.  The one-line example above, in the mempool section, is a
transaction record.

Another of the functionalities that you will have to implement is the
verification of a transaction statement (checking it's signature and
that there is enough funds), which will then insert a single
transaction record for that transaction into the mempool.

As an example, below is one of the transaction statements that was
generated from the script provided (specifically the `./cryptomoney.sh
transfer alice.wallet.txt $bob 12 03-alice-to-bob.txt` line).  Note
that you don't have to have the same format!  This is just what we
used.  However, it must contain the same five pieces of information:
from, to, amount, date, and the signature.  The one-line entry from
the mempool, above, is the corresponding transaction record for this
transaction statement.

```
From: a3e47443b0f3bc76
To: 48adadf4fb921fca
Amount: 12
Date: Tue Apr 02 23:09:13 EDT 2019

5b7e1fcbde4edee8b940d820ea807558fc4b3a94108df254267c578077c03dd5d30ca62550376aabaa24f42a11f667d6b191230a50fd9de08bcd37a75dfcc3774735057d84a6aa8abe297f9ff379a02d1976006584cf4fc34ef53a92f973e58d452d0b2c48342f89ebc7cee668511c696b78c36712d2aed9ef2681977bb5a93c
```

The signature is done of the first four lines of information (or
however many lines contain your information).  This is done when
taking the signature, and the program will need to do the same when
checking the signature.

Note that the result of a `fund` command, which comes from "bigfoot"
(or whatever you call your source of funds in your cryptocurrency),
then there will likely not be a signature line at the bottom of the
transaction record.

**Wallet address versus wallet file**

A wallet is a public / private key set.  When signing a transaction,
or checking a signature, then the full wallet file will be needed.  A
wallet address is a shortened version of the public key.  For our
purposes, we should take the SHA-256 hash of the public key, and use
that.  However, that's a bit long, so we can use only the first 16
characters of that hash for brevity.


### Requirements

Since this can be done in any programming language, you will have to
write a shell script (described below) so that we can call your code.
While the shell script is described below, the particular function -- called the mode -- to
be implemented is `shown like this` in the requirements below.  That
function will be the first command line parameter provided to the
program, and any additional command line parameters are specified
below.  For example, to generate a wallet, you would call `java CMoney generate wallet.txt` or `python3 cmoney.py generate wallet.txt`.  We are going to be using the same command-line parameters (here, `generate wallet.txt`) to both your source code and the shell script.

**Output:** Each command below should print out EXACTLY ONE LINE to
standard output indicating the success (or failure) of the command.

The requirements are:

1. Print the name of the cryptocurrency (`name`).  This is the name
   from the Overview section, above.  There are no additional command
   line parameters to this function.
2. Create the genesis block (`genesis`): this is the initial block in
   the block chain, and the block should always be the same.  Come up
   with a fun quote!  It should always be written to a `block_0.txt`
   file. There are no additional command line parameters to this
   function.
3. Generate a wallet (`generate`): this will create RSA public/private
   key set (1024 bit keys is appropriate for this assignment).  The
   resulting wallet file MUST BE TEXT -- you will have to convert any
   binary data to text to save it (and convert it in the other
   direction when loading).  You can see the provided helper
   functions, above, to help with this.  The file name to save the
   wallet to will be provided as an additional command line parameter.
4. Get wallet tag (`address`): this will print out the tag of the public
   key for a given wallet, which is likely the hash of the public key.
   Note that it *only* prints out that tag (no other output).  When
   the other commands talk about naming a wallet, this is what it
   actually means.  You are welcome to use the first 16 characters of
   the hash of the public key for this assignment; you don't need to
   use the entire hash.  The file name of the wallet file will be
   provided as an additional command line parameter.
5. Fund wallets (`fund`): this allows us to add as much money as we
   want to a wallet.  While this is obviously not practical in the
   real world, it will allow us to test your program.  (Although there
   still needs to be a way to fund wallets in the real world also.)
   Create a special case ID ('bigfoot', 'daddy_warbucks', 'lotto', or
   whatever) that your program knows to use as the source for a fund
   request, and also knows not to verify when handling verification,
   below.  This means that 'bigfoot' (or whatever) will appear
   alongside the hash of the public keys as the source of funds.  This
   function will be provided with three additional command line
   parameters: the destination wallet address, the amount to transfer,
   and the file name to save the transaction statement to.  All funded amounts are integers; we are not using floating-point numbers in this assignment at all.
6. Transfer funds (`transfer`): this is how we pay with our
   cryptocurrency.  It will be provided with four additional command
   line parameters: the source wallet file name (not the address!),
   the destination wallet address (not the file name!), the amount to
   transfer, and the file name to save the transaction statement to.
   Any reasonable format for the transaction statement is fine for
   this, as long as the transaction statement is text and thus
   readable by a human.  Recall that it must have five pieces of
   information, described above in the "Transaction statement versus
   transaction record" section.  Note that this command does *NOT* add
   anything to the mempool.  All transferred amounts are integers; we are not using floating-point numbers in this assignment at all.
7. Check a balance (`balance`): based on the transactions in the block
   chain AND ALSO in the mempool, compute the balance for the provided
   wallet.  This does not look at transaction *statements*, only the
   transaction *records* in the blocks and the mempool.  The wallet
   address to compute the balance for is provided as an additional
   command line parameter.
   - **NOTE:** this should ONLY print the balance as a number, as an integer, and nothing else!
8. Verify a transaction (`verify`): verify that a given transaction
   statement is valid, which will require checking the signature
   **and** the availability of funds.  Once verified, it should be
   added to the mempool as a transaction record.  This is the only way
   that items are added to the mempool.  The wallet file name
   (whichever wallet created the transaction) and the transaction
   statement being verified are the additional command line
   parameters.
9. Create, mine, and sign block (`mine`): this will form another block
   in the blockchain.  The mempool will be emptied of transaction
   records, as they will all go into the current block being computed.
   A nonce will have to be computed to ensure the hash is below a
   given value.  Recall that the first line in any block is the
   SHA-256 of the last block file.  The difficulty for the mining will
   be the additional parameter to this command.  For simplicity, the
   difficulty will be the number of leading zeros to have in the hash
   value -- so a value of 3 would imply that the hash must start with
   three leading zeros.  We will be using very small difficulties
   here, so a brute-force method for finding the nonce is sufficient.
   The nonce must be a single unsigned 32 bit (or 64 bit) integer.
10. Validate the blockchain (`validate`): this should go through the
    entire block chain, validating each one.  This means that starting
    with block 1 (the block *after* the genesis block), ensure that
    the hash listed in that file, which is the hash for the *previous*
    block file, is correct.  For `validate`: the blockchain is considered valid if only the genesis block exists; we will never call this function if the genesis block has not been created.  Because of this, you don't have to actually check if the genesis block exists, as we will never call validate on it if it does not exist.  Likewise, you don't have to do any checks on the genesis block file itself.  There are no additional command-line
    parameters for this function.
    - **NOTE:** this should ONLY print either 'True' or 'False' (if it's valid
       or not), and nothing else!  Case matters here.


### Other files

#### Shell script

Since different programming languages can be used, and you may name your file differently, we are going to have you submit a shell script called `cryptomoney.sh` that we will use to test your code.  All it does is pass the command-line parameters on to your program.  If you are using Python, then your shell script would look like the following:

```
#!/bin/bash
python3 cmoney.py $@
```

If you are using Java, then your shell script would look like the following:

```
#!/bin/bash
java CMoney $@
```

Save the two lines above to a text file called `cryptomoney.sh`; change the name of the file as appropriate to your code.  Then run `chmod 755 cryptomoney.sh`.  You should then be able to run your program through the shell script.

#### Makefile

Separately from the shell script, you will also need a Makefile.  This will allow your program to be compiled prior to execution (if your program needs compilation).  For languages that do not need compilation (such as Python), just put in a single `echo` statement so that `make` still runs properly.

If you are using Python, your Makefile will look like the following:

```
main:
     echo hello world
```

Note that the indentation is a tab, not spaces!  Makefiles are very strict on that.  And change the file name as appropriate for your source code.

If you are using Java, your Makefile will look like the following:

```
main:
     javac CMoney.java
```

Note that the indentation is a tab, not spaces!  Makefiles are very strict on that.  And change the file name as appropriate for your source code.


### Sample execution

This is just meant to show the syntax -- it is not meant to be a full
fledged testing suite of your homework.  However, it does call each of
the commands listed above. Note that the lines with the equals signs
are setting variables to be used later on.  The commands used here are
in the [basic-test.sh](basic-test.sh)
([html](basic-test.sh.html)) script.  Note that you
will have to run `chmod 755 basic-test.sh` before you can run the
shell script.  Also note that this shell script takes the SHA-256 sum
of one of the block files via the `sha256sum` command -- if you don't
have this command on your computer, you can remove that line.

In this execution run, when a wallet is generated, a signature of the
public key is used to identify the wallet (or perhaps it's the public
key itself -- how this is done is up to you).  It is this value that
is returned by the `address` call, and is indicated below in the
output (`New wallet generated in 'alice.wallet.txt' with signature
abdfa7a347c40443`).  You can -- and likely should, as this program
does -- use only the first 16 (or so) digits of that wallet signature
rather than the full SHA-256 hash of this signature.

```
$ ./cryptomoney.sh name
AaronDollar(TM)
$ ./cryptomoney.sh genesis
Genesis block created in 'block_0.txt'
$ ./cryptomoney.sh generate alice.wallet.txt
New wallet generated in 'alice.wallet.txt' with signature e1f3ec14abcb45da
$ export alice=`./cryptomoney.sh address alice.wallet.txt`
$ echo alice.wallet.txt wallet signature: $alice
alice.wallet.txt wallet signature: e1f3ec14abcb45da
$ ./cryptomoney.sh fund $alice 100 01-alice-funding.txt
Funded wallet e1f3ec14abcb45da with 100 AaronDollars on Tue Apr 02 23:08:59 EDT 2019
$ ./cryptomoney.sh generate bob.wallet.txt
New wallet generated in 'bob.wallet.txt' with signature d96b71971fbeec39
$ export bob=`./cryptomoney.sh address bob.wallet.txt`
$ echo bob.wallet.txt wallet signature: $bob
bob.wallet.txt wallet signature: d96b71971fbeec39
$ ./cryptomoney.sh fund $bob 100 02-bob-funding.txt
Funded wallet d96b71971fbeec39 with 100 AaronDollars on Tue Apr 02 23:09:00 EDT 2019
$ ./cryptomoney.sh transfer alice.wallet.txt $bob 12 03-alice-to-bob.txt
Transferred 12 from alice.wallet.txt to d96b71971fbeec39 and the statement to '03-alice-to-bob.txt' on Tue Apr 02 23:09:00 EDT 2019
$ ./cryptomoney.sh transfer bob.wallet.txt $alice 2 04-bob-to-alice.txt
Transferred 2 from bob.wallet.txt to e1f3ec14abcb45da and the statement to '04-bob-to-alice.txt' on Tue Apr 02 23:09:01 EDT 2019
$ ./cryptomoney.sh verify alice.wallet.txt 01-alice-funding.txt
Any funding request (i.e., from bigfoot) is considered valid; written to the mempool
$ ./cryptomoney.sh verify bob.wallet.txt 02-bob-funding.txt
Any funding request (i.e., from bigfoot) is considered valid; written to the mempool
$ ./cryptomoney.sh verify alice.wallet.txt 03-alice-to-bob.txt
The transaction in file '03-alice-to-bob.txt' with wallet 'alice.wallet.txt' is valid, and was written to the mempool
$ ./cryptomoney.sh verify bob.wallet.txt 04-bob-to-alice.txt
The transaction in file '04-bob-to-alice.txt' with wallet 'bob.wallet.txt' is valid, and was written to the mempool
$ cat mempool.txt
bigfoot transferred 100 to e1f3ec14abcb45da on Tue Apr 02 23:09:01 EDT 2019
bigfoot transferred 100 to d96b71971fbeec39 on Tue Apr 02 23:09:01 EDT 2019
e1f3ec14abcb45da transferred 12 to d96b71971fbeec39 on Tue Apr 02 23:09:02 EDT 2019
d96b71971fbeec39 transferred 2 to e1f3ec14abcb45da on Tue Apr 02 23:09:02 EDT 2019
$ ./cryptomoney.sh balance $alice
90
$ ./cryptomoney.sh balance $bob
110
$ ./cryptomoney.sh mine 2
Mempool transactions moved to block_1.txt and mined with difficulty 2 and nonce 1029
$ sha256sum block_1.txt
00cc159f08e9e833d2cc85e8dce788020603346829e86f623e6f3c7e36e34b6c  block_1.txt
$ ./cryptomoney.sh validate
True
$
```


### Notes

There are a number of assumptions you can make for your code:

- We will always provide the proper parameters to the shell script --
  both the number, order, and validity of the parameters can be
  assumed to be correct.
- The block_?.txt files will be consecutive -- so there won't be a
  block_3.txt missing when there is a block_4.txt.
- The block_0.txt file will exist before any calls to verify,
  validate, or balance; however, the mempool.txt file may not yet
  exist.
- All numerical values provided for the cryptocurrency amounts -- this is for the `balance` and `fund` modes -- will only be integers; floating point numbers are not being used in this assignment.


### Submission

You will submit exactly three files for this assignment:

1. Your source code file.  All your code must be in a single source code file.  We realize that a Java file may compile to multiple .class files, which is fine.  As mentioned above, if you want to use a language other than C, C++, Java, or Python, please check with us first.
2. `cryptomoney.sh`: the shell script, described above.  We are going to call that script to test your entire code, so make sure it's named properly!
3. `Makefile`: as described above
