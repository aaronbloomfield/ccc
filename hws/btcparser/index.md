Bitcoin Blockchain Parser
=========================

[Go up to the CCC HW page](../index.html) ([md](../index.md))

### Overview

In this assignment you will read in, validate, and then output the Bitcoin blockchain.

Your program will take in a file that contains one or more blocks from the Bitcoin blockchain; these blocks are in binary format.  Your program must read these blocks in, check the blockchain for errors, and then output the result in JSON format.

Your program will provide exactly one line of output to the standard output: either "no errors X blocks" (case sensitive!) or the specific error number ("error 5 block 17") -- we describe the error numbers below.  In addition, it will create a JSON file if there were no errors -- if the input file name was blk00000.blk, then it will create a JSON file named blk00000.blk.json.  If there are errors, it is fine to create the JSON file or not -- it will not be checked.  The format of this file is described below.

The Bitcoin block format that is being parsed for this assignment is the format of the first many blocks -- specifically before any BIPs were proposed and enacted.  Thus, the blocks will not contain fields such as the height number.  Furthermore, the blocks use regular Merkle Trees and not Fast Merkle Trees (which were proposed later).


### Changelog

Any changes to this page will be put here for easy reference.  Typo fixes and minor clarifications are not listed here.  So far there aren't any significant changes to report.


### Languages

In theory, this can be implemented in any language.  In practice, though, it needs to be a language that the auto-graders can compile and run, and that the skeleton code is written for.  Four languages that can currently be used: C (using `gcc`), C++ (using `g++`), Java (using OpenJDK 11), and Python (using Python 3.6.x).  If you want to use a different language, let's have a chat about it, as it will take some time to ensure that the grading system can handle it.

This assignment specifically is intended for you to use the default packages that come with the given programming language.  In particular, you may NOT use any cryptocurrency specific libraries (such as the Bitcoin libraries).  However, you are welcome to -- and probably should -- use any JSON libraries.

### Provided files

We have a number of files of the blockchain itself.  Blockchain block counting is indexed from 0 (the genesis block), so a file that contains the first 10 blocks will contain blocks 0-9.

- Files with multiple blocks
    - [blk00000-f10.blk](blk00000-f10.blk) (2.3 Kb) contains the first 10 blocks
    - [blk00000-f100.blk](blk00000-f100.blk) (24 Kb) contains the first 100 blocks
    - blk00000.blk (125 Mb) contains the first 119,341 Bitcoin blocks.  Due to this file's size, it is not kept in this repository, but can be found on Collab in the Resources tool
- Files with single blocks
    - [blk00000-b0.blk](blk00000-b0.blk) is block 0, the genesis block
    - [blk00000-b29664.blk](blk00000-b29664.blk) is block 29,664, the first block with a compactSize unsigned integer that takes up more than one byte -- this may help you ensure you are reading those values in properly; see below for details on where that value is in the block
    - A number of individual block files to help you ensure that the Merkle tree hashes are computed properly; see below for their purpose.  Those block files are blocks [170](blk00000-b170.blk), [546](blk00000-b546.blk), [586](blk00000-b586.blk), [26,816](blk00000-b26816.blk), [2812](blk00000-b2812.blk), [49,820](blk00000-b49820.blk), and [53,066](blk00000-b53066.blk)
- Helper programs
    - [check_genesis_json.py](check_genesis_json.py.html) ([src](check_genesis_json.py)) will help you ensure that your JSON output is correct -- see the comments in the file for a description of how to use it
    - [change_byte.py](change_byte.py.html) ([src](change_byte.py)) will help with checking for blockchain errors -- see below for how to use it

### Part 1: Reading in the blockchain

Your program will take in exactly one command-line parameter: the file to read in.  You can assume that there will always be one command line parameter provided, and that that file will exist.  Sample files are provided above -- both large and small.


#### Block group file format

The blocks to be verified are grouped together in a file -- this file is from the Bitcoin system, and if you were to download that and have it sync, you would have those files on your machine as well.  The file provided contains block 0 (the genesis block) through block 119,341.

To see the contents of a binary file, run it through `hexdump -C`.  This will print a LOT of text, so we will pipe it through `head`, as shown below.  Each block is preceded by 8 bytes of data.  The first 4 bytes are the magic number, and the second four bytes are the block size.  Both are in little-Endian format in the file.  The first 13 lines of this file, when run through `hexdump -C`, are:

```
$ hexdump -C blk00000.blk | head -10
00000000  f9 be b4 d9 1d 01 00 00  01 00 00 00 00 00 00 00  |................|
00000010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
00000020  00 00 00 00 00 00 00 00  00 00 00 00 3b a3 ed fd  |............;...|
00000030  7a 7b 12 b2 7a c7 2c 3e  67 76 8f 61 7f c8 1b c3  |z{..z.,>gv.a....|
00000040  88 8a 51 32 3a 9f b8 aa  4b 1e 5e 4a 29 ab 5f 49  |..Q2:...K.^J)._I|
00000050  ff ff 00 1d 1d ac 2b 7c  01 01 00 00 00 01 00 00  |......+|........|
00000060  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
00000070  00 00 00 00 00 00 00 00  00 00 00 00 00 00 ff ff  |................|
00000080  ff ff 4d 04 ff ff 00 1d  01 04 45 54 68 65 20 54  |..M.......EThe T|
00000090  69 6d 65 73 20 30 33 2f  4a 61 6e 2f 32 30 30 39  |imes 03/Jan/2009|
000000a0  20 43 68 61 6e 63 65 6c  6c 6f 72 20 6f 6e 20 62  | Chancellor on b|
000000b0  72 69 6e 6b 20 6f 66 20  73 65 63 6f 6e 64 20 62  |rink of second b|
000000c0  61 69 6c 6f 75 74 20 66  6f 72 20 62 61 6e 6b 73  |ailout for banks|
$
```

Each line displays 16 bytes from the file.  The columns in hexdump shows the address of the first byte in the row (in hex), the hex values of the 16 bytes, and an ASCII representation of those 16 bytes (if they are printable characters).  You can see, at the bottom of the hexdump display above, the text included in the genesis block for Bitcoin.  You may want to save the hexdump output to a file (`hexdump -C blk00000.blk > blk00000.blk.txt`), but be warned, as this will be a very large file (631 Mb).  You can also use the smaller block files as well.

The first four bytes (`f9 be b4 d9`) is the so-called "magic number" which identifies the start of a block.  The value is 0xd9b4bef9, or 0xf9beb4d9 in little-Endian.  The next four bytes (1d 01 00 00) are the size.  That's in little-Endian, so converted to big-Endian it's 0x0000011d = 285.  The next 285 bytes are the contents of block 0 (the genesis block).  Block 1 thus starts at byte 285+8=293 (0x125 in hex) in the file.  You can see this later in the hexdump output:

```
00000110  5c 38 4d f7 ba 0b 8d 57  8a 4c 70 2b 6b f1 1d 5f  |\8M....W.Lp+k.._|
00000120  ac 00 00 00 00 f9 be b4  d9 d7 00 00 00 01 00 00  |................|
00000130  00 6f e2 8c 0a b6 f1 b3  72 c1 a6 a2 46 ae 63 f7  |.o......r...F.c.|
```

On the second line, the magic number of the second block (block index 1) starts on the 6th byte.

#### Reading in the blockchain

Your task is to read in the blockchain.  The format for the blockchain can be found in the [Bitcoin lecture slides](../../slides/bitcoin.html#/), specifically starting [here](../../slides/bitcoin.html#/blockchain).  You will need to read in the file in binary format.

You will likely want to print out the data read in (and the associated fields).  This will be changed to a different output format in part 3, below.  As you are printing out the values, you can see what they should be [here](https://www.blockchain.com/btc/block/0) for block 0; the output is also shown below.  That site prints the values in big-Endian, which is how we will be printing them in this assignment. However, we are going to print out the nBits field in hex; that size prints it out in decimal.

Some useful hints:

- There really are only five different types in the bitcoin blockchain: 4-byte unsigned integers, 8-byte unsigned integers, compactSize unsigned integers, 32-byte hashes, and variable-length scripts.  That's it.  All of the blockchain is one of these five types -- so you can reuse your code from reading in one type to read in another.
  - While there are only 5 types, we will be outputting them in different ways -- but each programming language can easily print a number in hex or decimal.
- Make sure you have a method that reads in compactSize unsigned integers properly, as this will cause your program to crash otherwise.  In particular, remember that if the variable is more than one byte, then all the bytes *other* than the first are in little-Endian format.  HOWEVER, some routines that read in the values will swap them for you, and some will not.  This is explicitly why we provide [block 29,664](blk00000-b29664.blk) for you -- that is the first block that has such a value that is more than one byte (the txn_in_count for the second transaction is 320); you can see more information about that transaction [here](https://blockchair.com/bitcoin/block/29664).

If you can read in all of the input files -- especially the large one -- without any errors, then you've successfully completed this part.  Note that you may want to redirect your output to a file, since that's a lot of text to be output to the screen.


#### Shell script

As we do not know what language your program will be written in, nor what you will name your executable, you will need to submit a `parse.sh` shell script for us to call.  Such a file for C or C++ might look like:

```
#!/bin/bash
./a.out $@
```

The first line must be there exactly as shown (pound sign, then exclamation point, then `/bin/bash`).  For the second line, replace `./a.out` with how to run your (compiled) program: `java BTCBlockChain` or `python3 btc-parse.py` (use `python3`, not `python`).  Be sure to put the `$@` on that line as well.

Once created, you will have to ensure it can be executed: `chmod 755 parse.sh`.  You should then be able to run your program via: `./parse.sh blk00000.blk`.

The following might be what it would look like for Python:

```
#!/bin/bash
python3 btc-parse.py $@
```

And for Java:

```
#!/bin/bash
java BTCParse $@
```

### Part 2: Validating the blockchain

Now that you can read in valid blockchain, your program should be extended to check for errors in the blockchain.  Once an error is encountered, the program should output the error number and stop.  The errors below are what should be checked for -- note that these are not all the possible errors, but a selection of errors to check for on this assignment.

1. Invalid magic number
2. Invalid header version (we only are allowing version 1 for this assignment)
3. Invalid previous header hash (this is not checked for the first block in the file, since we don't know the previous block)
4. Invalid timestamp (it needs to be no earlier than 2 hours before that of the previous block (this is a simplification of the [actual requirements](https://en.bitcoin.it/wiki/Block_timestamp)); this is not checked for the first block in the file)
5. Invalid transaction version (we are only allowing version 1 for this assignment)
6. The Merkle tree hash in the header is incorrect (implement this last -- see below)

If an error is found, the output should only be `error 5 block 17` with the appropriate error number and block number (remember that blocks start counting at 0, not 1).  If no errors are found, then the output should only be "no errors X blocks", where 'X' is an integer.  (We are going to use the plural "blocks" even when there is only 1 block).

If there are multiple errors, you should report the one found in the earlier block.  For example, if there is a modification to the Merkle hash in block 10, then both block 10 will have an error (#6 -- bad Merkle hash) as well as block 11 (#3 -- bad previous header hash).  In this case, the error in block 10 should be reported.

If there are multiple errors in a single block, you can report any of them.  Because this makes it very difficult to grade, we are going to avoid this possibility when grading your assignment.

Test this well!  We are going to provide all sorts of messed-up files to your program as input.  The file provided to your program may not even be a valid blockchain file!  You are guaranteed that the following will be true:

- The file name specified as the command-line parameter will exist, will be readable, and will be non-zero in size
- The blocks -- if they exist -- will be consecutive in the file
  - This means that the block order will be 0,1,2,3,4,... -- not, for example 0,2,1,4,3,...
  - Formally, this means that the previous header hash for a given block will be for the block immediately preceding it in the file (obviously this doesn't apply for the first block in the file)
  - Note that the actual Bitcoin block chain files downloaded by the BTC client do not assure they are in order!
- There will be no 'orphan' blocks -- each block will be the successor to the block immediately before it
  - Obviously that doesn't apply to the first block in the file

Note that if you are printing out the blockchain data to standard output from the previous section, it's fine to just terminate the program with the "no errors X blocks" or "error 5 block 17" line -- we'll get rid of the other output in the next section.

#### Testing

To test each error, you should try to change one byte in the file -- specifically, a byte in the particular field you are checking for errors.  For example, if you want to modify the magic number, you would change one of the first 4 bytes; bytes are indexed from zero, that's bytes 0, 1, 2, or 3. To do that, you can use the following Python program, which you can save as `change_byte.py`:

```
#!/usr/bin/python3
import sys
assert (len(sys.argv)==3)
data = bytearray(sys.stdin.buffer.read())
data[int(sys.argv[1])] = int(sys.argv[2])
sys.stdout.buffer.write(bytes(data))
```

This can also be downloaded via [change_byte.py](change_byte.py.html) ([src](change_byte.py)).  Yes, this program could be compacted more, but then it would be even more unreadable.  This program will read in binary data from standard input, change one byte, and write the resulting data to standard output.  It takes in two command-line parameters: the byte number to change, and the value to change it to; both are decimal numbers.  There is no error checking in this program!  You would use it as such:

```
$ cat blk00000-f10.blk | ./change_byte.py 2 0 > test.blk
$ ./parse.sh test.blk
error 1 block 0
$
```

The first line may be different on your machine (especially if you use Windows), and it may be invoked slightly differently than what is shown below.  Here are a few more execution runs to show you both successful execution runs and runs with some errors.  You should test it beyond these!  We are certainly going to when we grade your assignment...

```
$ ./parse.sh ~/Dropbox/git/ccc/hws/btcparser/blk00000-b0.blk 
no errors 1 blocks
$ ./parse.sh ~/Dropbox/git/ccc/hws/btcparser/blk00000-f10.blk 
no errors 10 blocks
$ ./parse.sh ~/Dropbox/git/ccc/hws/btcparser/blk00000-f100.blk 
no errors 100 blocks
$ ./parse.sh blk00000.blk 
no errors 119341 blocks
$ cat blk00000-f10.blk | ./change_byte.py 2 0 > test.blk
$ ./parse.sh test.blk 
error 1 block 0
$ cat blk00000-f10.blk | ./change_byte.py 10 7 > test.blk
$ ./parse.sh test.blk 
error 2 block 0
$ cat blk00000-f10.blk | ./change_byte.py 14 3 > test.blk
$ ./parse.sh test.blk 
error 3 block 1
$ cat blk00000-f10.blk | ./change_byte.py 310 23 > test.blk
$ ./parse.sh test.blk 
error 3 block 1
$ cat blk00000-f10.blk | ./change_byte.py 372 0 > test.blk
$ ./parse.sh test.blk 
error 4 block 1
$ cat blk00000-f10.blk | ./change_byte.py 89 17 > test.blk
$ ./parse.sh test.blk 
error 5 block 0
$ cat blk00000-f10.blk | ./change_byte.py 46 3 > test.blk
$ ./parse.sh test.blk 
error 6 block 0
$
```

These test are by no means comprehensive!  But some of these tests will be used for the visible tests when you submit the file to Gradescope.  The hidden tests, which your grade will be based on similar tests different than the ones shown above.

#### Merkle Tree hashes

This is likely the hardest part of the assignment.  Work on this last, as you can still get a lot of partial credit if this part is not implemented.  In particular, you may want to ensure that the JSON output, below, is working first before you complete this part.

The computation of the Merkle tree root hash is [discussed in the lecture slides](../../slides/bitcoin.html#/merkle).  You will need to be familiar with that before proceeding.  It is expected that you will use the SHA-256 hashing programs that come with your programming language; use of these is discussed in the last few slides of the [hashing section of the Encryption slide set](../../slides/encryption.html#/hashing).

Some important notes to remember:

- The hashes for the children nodes are concatenated, and then the hash of that concatenation is used in the level above
- If there is an odd number of hashes in a given level, then the last one is concatenated to itself, and the hash of that is used in the level above
- The hashes need to be in binary little-Endian form; the binary form is 32 bytes long
- Bitcoin uses a double hashing, so each hash is really the sha256 hash of the sha256 hash of the data itself
- This program is *NOT* using Fast Merkle trees

For testing the Merkle tree hashes, we provide a few particular blocks that have a given number of transactions:

- Block 170 ([blk00000-b170.blk](blk00000-b170.blk)) is the first block with 2 transactions
- Block 586 ([blk00000-b586.blk](blk00000-b586.blk)) is the first block with 3 transactions
- Block 546 ([blk00000-b546.blk](blk00000-b546.blk)) is the first block with 4 transactions
- Block 26,816 ([blk00000-b26816.blk](blk00000-b26816.blk)) is the first block with 5 transactions
- Block 2,812 ([blk00000-b2812.blk](blk00000-b2812.blk)) is the first block with 6 transactions
- Block 49,820 ([blk00000-b49820.blk](blk00000-b49820.blk)) is the first block with 7 transactions
- Block 53,066 ([blk00000-b53066.blk](blk00000-b53066.blk)) is the first block with 8 transactions

#### Merkle tree example

To help you ensure that you are computing the Merkle tree hash properly, here is a worked-out example.  This is the data from the genesis block:

```
$ hexdump -C blk00000-b0.blk
00000000  f9 be b4 d9 1d 01 00 00  01 00 00 00 00 00 00 00  |................| 
00000010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................| 
00000020  00 00 00 00 00 00 00 00  00 00 00 00 3b a3 ed fd  |............;...| 
00000030  7a 7b 12 b2 7a c7 2c 3e  67 76 8f 61 7f c8 1b c3  |z{..z.,>gv.a....| 
00000040  88 8a 51 32 3a 9f b8 aa  4b 1e 5e 4a 29 ab 5f 49  |..Q2:...K.^J)._I| 
00000050  ff ff 00 1d 1d ac 2b 7c  01 01 00 00 00 01 00 00  |......+|........| 
00000060  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................| 
00000070  00 00 00 00 00 00 00 00  00 00 00 00 00 00 ff ff  |................| 
00000080  ff ff 4d 04 ff ff 00 1d  01 04 45 54 68 65 20 54  |..M.......EThe T| 
00000090  69 6d 65 73 20 30 33 2f  4a 61 6e 2f 32 30 30 39  |imes 03/Jan/2009| 
000000a0  20 43 68 61 6e 63 65 6c  6c 6f 72 20 6f 6e 20 62  | Chancellor on b| 
000000b0  72 69 6e 6b 20 6f 66 20  73 65 63 6f 6e 64 20 62  |rink of second b| 
000000c0  61 69 6c 6f 75 74 20 66  6f 72 20 62 61 6e 6b 73  |ailout for banks| 
000000d0  ff ff ff ff 01 00 f2 05  2a 01 00 00 00 43 41 04  |........*....CA.| 
000000e0  67 8a fd b0 fe 55 48 27  19 67 f1 a6 71 30 b7 10  |g....UH'.g..q0..| 
000000f0  5c d6 a8 28 e0 39 09 a6  79 62 e0 ea 1f 61 de b6  |\..(.9..yb...a..| 
00000100  49 f6 bc 3f 4c ef 38 c4  f3 55 04 e5 1e c1 12 de  |I..?L.8..U......| 
00000110  5c 38 4d f7 ba 0b 8d 57  8a 4c 70 2b 6b f1 1d 5f  |\8M....W.Lp+k.._| 
00000120  ac 00 00 00 00                                    |.....| 
00000125
$
```

There is only one transaction in this block.  With a preamble of 8 bytes, a header of 80 bytes, and a transaction count of 1 byte (since it's a compactSize unsigned integer with value of 1), the transaction has to start at byte 89 (0x59).  This is the row with address 00000050, and the start of the transaction is the last 7 bytes on that line ("01 00 00 00 01 00 00"), and continues until the end of the block.

Putting all those bytes together gives us the (ASCII) hex of the transaction, which is stored in a `txn` variable:

```
txn="01000000010000000000000000000000000000000000000000000000000000000000000000ffffffff4d04ffff001d0104455468652054696d65732030332f4a616e2f32303039204368616e63656c6c6f72206f6e206272696e6b206f66207365636f6e64206261696c6f757420666f722062616e6b73ffffffff0100f2052a01000000434104678afdb0fe5548271967f1a67130b7105cd6a828e03909a67962e0ea1f61deb649f6bc3f4cef38c4f35504e51ec112de5c384df7ba0b8d578a4c702b6bf11d5fac00000000"
```

Because there is only one transaction, the hash of the hash of that transaction is also the Merkle tree root.  So we get the sha256(sha256()) hash of that data, which we have to convert to binary form first:

```
$ python3
>>> # enter txn = ... as above
>>> from hashlib import sha256 
>>> txn_data = bytes.fromhex(txn) 
>>> hash1 = sha256(txn_data).digest() 
>>> hash2 = sha256(hash1).hexdigest() 
>>> hash2 
'3ba3edfd7a7b12b27ac72c3e67768f617fc81bc3888a51323a9fb8aa4b1e5e4a' 
>>>
```

This is the Merkle tree root in the [genesis block](https://en.bitcoin.it/wiki/Genesis_block), although our Endian-ness is reversed.  So we can un-reverse (?) it (note that we are recomputing `hash2` here with a slightly different value):

```
>>> hash2 = sha256(hash1).digest() 
>>> hash2ba = bytearray(hash2) 
>>> hash2ba.reverse() 
>>> hash = ''.join(format(x, '02x') for x in hash2ba)       
>>> hash 
'4a5e1e4baab89f3a32518a88c31bc87f618f76673e2cc77ab2127b7afdeda33b' 
>>>
```

Now the hex of the hash exactly matches what is listed in the [genesis block](https://en.bitcoin.it/wiki/Genesis_block).

And then we can get all fancy and do all that in one line:

```
>>> # enter txn = ... as above
>>> from hashlib import sha256 
>>> ''.join(format(x, '02x') for x in reversed(bytearray(sha256(sha256(bytes.fromhex(txn)).digest()).digest())))
'4a5e1e4baab89f3a32518a88c31bc87f618f76673e2cc77ab2127b7afdeda33b' 
>>>
```


### Part 3: Outputting the blockchain

Lastly, your program must output the blockchain in JSON format.  You can read about [JSON on Wikipedia](https://en.wikipedia.org/wiki/JSON).  The format must be as described below, but your whitespace doesn't matter.  We are going to check it via a JSON parser.  Your output should look like the following:

```
{
    "blocks": [
        {
            "height": 0,
            "file_position": 0,
            "version": 1,
            "previous_hash": "0000000000000000000000000000000000000000000000000000000000000000",
            "merkle_hash": "4a5e1e4baab89f3a32518a88c31bc87f618f76673e2cc77ab2127b7afdeda33b",
            "timestamp": 1231006505,
            "timestamp_readable": "2009-01-03 13:15:05",
            "nbits": "1d00ffff",
            "nonce": 2083236893,
            "txn_count": 1,
            "transactions": [
                {
                    "version": 1,
                    "txn_in_count": 1,
                    "txn_inputs": [
                        {
                            "utxo_hash": "0000000000000000000000000000000000000000000000000000000000000000",
                            "index": 4294967295,
                            "input_script_size": 77,
                            "input_script_bytes": "04ffff001d0104455468652054696d65732030332f4a616e2f32303039204368616e63656c6c6f72206f6e206272696e6b206f66207365636f6e64206261696c6f757420666f722062616e6b73",
                            "sequence": 4294967295
                        }
                    ],
                    "txn_out_count": 1,
                    "txn_outputs": [
                        {
                            "satoshis": 5000000000,
                            "output_script_size": 67,
                            "output_script_bytes": "4104678afdb0fe5548271967f1a67130b7105cd6a828e03909a67962e0ea1f61deb649f6bc3f4cef38c4f35504e51ec112de5c384df7ba0b8d578a4c702b6bf11d5fac"
                        }
                    ],
                    "lock_time": 0
                }
            ]
        }
    ],
    "height": 1
}
```

A bunch of notes:

- We don't need to list the magic number in the JSON file -- it's always the same, and was verified when the blockchain was read in
- Likewise, we don't need to include the block size, since that's not as important in JSON
- You can put in additional fields if you would like -- it's just that the fields shown above must be there.  In the output above, both 'timestamp_readable' and 'file_position' are NOT required fields
- All hexadecimal values should NOT have a leading '0x'
- Integer values should not have quotes around them (that's a JSON feature), but all other values should be enclosed in double quotes
- If you have a list if items in an array, JSON is not happy with a comma after the last one; you can see this after the 'lock_time' value -- there is no comma after its value 0.
- You'll notice that the 'height' field is at the end -- you won't know, when starting to read the file, how many blocks are therein.  So we put that at the end.  This is just the total number of blocks in the file.
- For the numerical values, the only ones that are in hex (again, without the leading '0x') are the hashes (previous header, merkle, and utxo), the scripts (input and output), and nbits.  All other numerical values, including the two times (timestamp and locktime) should be base-10.
- All hash values should be printed in big-Endian.  Note that they are stored in the file in little-Endian!
- The height of the first block in the file should be displayed as 0, even if it is not the genesis block; the height increments from there.
- The script data itself should be output in the exact order that it occurs in the file.  You can see what that data is for the genesis block [here](https://en.bitcoin.it/wiki/Genesis_block).

In particular, this output need to be written to a file, NOT to standard output.  So all of the output lines from part 1 (other than reporting the presence of, or lack of, errors) should now be output to a file.  The file name will just append ".json" to the input file name.  If you are writing this file as you go, and you encounter an error, it's fine if you have a partially written JSON file -- we aren't going to check it in that case.

You can verify that it works by running it through JSON's lint: `jsonlint-php blk00000-first10.blk.json`.  This program is installed on the Linux VirtualBox image.  If you not using VirtualBox, you can install it yourself, or use online sites such as [these](https://jsonlint.com/).  You can also use a one-line Python command to test it:

```
$ cat blk00000-b0.blk.json | python3 -c "import json,sys; json.load(sys.stdin)"
$
```

If there is no output (specifically, no error output), then it was parsed correctly.

Make sure you test it with multiple blocks!  However, the online site will probably not like you trying to upload a huge JSON file.

You should also use the [check_genesis_json.py](check_genesis_json.py.html) ([src](check_genesis_json.py)) program to ensure that your JSON is in the right format.  This is intended to ensure that you have the right fields for when we grade the assignment.  It just has a bunch of `assert()` calls to ensure that the format is what is shown above.  Remember that white space doesn't matter, so you are welcome to use any spacing that you want.  This program will also be used as one of the visible submission tests in Gradescope.

### Deliverables

You must submit a minimum of three files; more is fine.

- `Makefile`: if your program needs compilation, then running `make` will perform that compilation.  If it does not need compiling, then just have something such as `echo "hello world"` as the action for the default target.
- `parse.sh`: a bash script that will execute your (compiled) program with any provided command-line options.  An example of these are shown above.
- Your code files: submit as many as you need to submit -- it's fine if you have things in multiple files
