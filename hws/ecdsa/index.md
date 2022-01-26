P2: ECDSA Implementation
========================

[Go up to the CCC HW page](../index.html) ([md](../index.md))

### Overview

In this homework you will implement the ECDSA algorithm.

The sizes of the numbers we are using will be small -- all 1,000 (base 10) or less.  While we are not particularly interested in efficiency, your program does have to run in a reasonable amount of time (say, a second or less).  In particular, your elliptic curve multiplication must be a logarithmic time algorithm (relative to $k$), not a linear time algorithm.

This assignment to be written in Python, and called ecdsa.py.  You may use the standard libraries that come with Python, but nothing that is installed via pip.  In particular, you may NOT use any libraries that have cryptographic or hashing functions -- this includes hashlib.  We expect you will only need to use the `sys` and `random` packages.  We realize that Python's standard `random` package is not a cryptographically secure random number generator, but that's fine for this assignment.

If you want to use a differnt language, please speak to me first.

In this homework, it is critical to carefully test each stage of the assignment.  Each part requires that the previous part works properly -- and, if it does not, then it will be exceedingly difficult to debug your program.  If you get stuck, the best way to figure out where the bug is is to print out the values at each step, and verify them by hand (or via online calculators, linked to below).

### Background

You will need to be familiar with the [Encryption slide set](../../slides/encryption.html#/), specifically the three sections that deal with the content in this assignment: [elliptic curves](../../slides/encryption.html#/elliptic), [finite fields](../../slides/encryption.html#/fields), and [ECDSA](../../slides/encryption.html#/ecdsa).  What this assignment is asking for will make no sense if you are not familiar with that material.


### Step 1: Finite Field functions

The first step is to ensure that you have all the finite field arithmetic functions that are necessary.  Some of these are easy -- addition and multiplication, for example.  Others are a bit more challenging, such as division.  You will likely want to reference the [finite field section of the lecture slides](../../slides/encryption.html#/fields).  In addition to the four standard arithmetic operations, you will likely also need exponentiation, obtaining the additive inverse, and obtaining the multiplicative inverse.  Some functions will likely use others -- division of $a$ by $x$ is just multiplying $a$ by the multiplicative inverse of $x$, for example.

The field size should be a parameter to the functions, or a global variable, as that will change with different execution runs.

Test these well to ensure that they work!!!

### Step 2: Elliptic Curve point operations

There are three elliptic curve point operations that will be needed:

- Elliptic curve addition of a point to itself: $P = Q \oplus Q$
- Elliptic curve addition of two different points to each other: $P=Q \oplus R$
- Elliptic curve multiplication of a point by a scalar value: $P = k \otimes Q$.  Really this is adding that point $k$ times, but we can't do that many additions (that's a linear time operation relative to $k$) -- instead, this needs to be a logarithmic operation, as discussed in lecture.

 Some references from the lecture slides:

 - The [elliptic curve section](../../slides/encryption.html#/elliptic) of the encryption slide set shows how these operations work visually (albeit in the real numbers)
 - The last few slides in the [finite field section](../../slides/encryption.html#/fields) discusses how to perform this arithmetic in a field.  *Remember not to reflect the point in the field!*

You can test your functions by using two websites: one that does [elliptic curve addition in a field](https://andrea.corbellini.name/ecc/interactive/modk-add.html) and one that does [elliptic curve multiplication in a field](https://andrea.corbellini.name/ecc/interactive/modk-mul.html).  The curve we are using is secp256k1, which sets $a=0$ and $b=7$.  For testing purposes, we recommend setting the prime modules $p$ to 43; this will give an curve order ($n$) value of 31.

### Step 3: Signature creation and validation

Lastly, you can proceed to generate the signature and then validate it; this is discussed in the [ECDSA section](../../slides/encryption.html#/ecdsa) of the encryption slide set.

We recommend reading through the next section, on input and output, before starting the work on this section.

Your program will need to be able to perform three primary functions:

- Key generation: choose a random value $d$, the private key, such that $1 \le d \le n-1$, and use that to determine the public key, point $Q$, such that $Q = d \otimes G$.  The values needed for these computations ($p$, $n$, and $G$) will be provided.
- Signing a message: Given the curve parameters ($p$, $n$, and $G$), the key pair ($d$ and $Q$), and the hash ($h$) of the message to be signed, you should generate the $(r,s)$ ECDSA signature.
- Verifying a message: Given the curve parameters ($p$, $n$, and $G$), the public key $Q$, the signature $(r,s)$, and the hash $h$, you should verify that the signature is (or is not) valid.

We will only be using the secp256k1 curve, so you can always assume that $a=0$ and $b=7$.


### Step 4: Ensure correct input and output

Your program will take in a number of command line parameters.  You can always assume that the number and format of command line parameters will be correct, as specified below -- you do not need to error check the parameters (neither the number nor the format).  You may also assume that any points provided (such as $G$ or $Q$) will lie on the curve.  Your program will only use the secp256k1 curve for all execution runs, so you can globally set $a=0$ and $b=7$; these values will not be passed to the program.

Each execution run of the program will take in a string as the first command-line parameter; this is the so-called mode.  After that will be a series of integer command-line parameters.  In most of the modes, the first four integer parameters will be, in this order: the prime modulus $p$, the curve order $n$, and the $x$ and $y$ values for the base point $G$.  All numerical values provided will be non-negative integers not greater than 1,000.  All numbers provided as input parameters, or output by the program, are base-10 numbers.

The four required modes of the program are:

- `userid` will just print your userid.  All lower-case, no quotes, and no extra spaces.  There will not be any other command-line parameters.  Below is an execution run.  Needless to say, it should print out *your* userid, not 'mst3k'.
  ```
$ ./ecdsa.py userid
mst3k
$
```
- `genkey` will generate a (random) primary key $d$ such that $1 \le d \le n-1$, and use that to compute the public key, point $Q$.  The numerical command-line parameters are just the four described above ($p$, $n$, $G_x$, and $G_y$).  The output should be three integers, one on each line: $d$, $Q_x$, and $Q_y$.  You can verify [here](https://andrea.corbellini.name/ecc/interactive/modk-mul.html) that the values returned are correct (specifically that $Q=d \otimes G$). Below is a sample execution run, which sets $p=43$, $n=31$, and $G=(25,25)$.  Since this output is based on a random number that is generated (specifically, $d$), one would expect that your output would be different on each execution run.
  ```
$ ./ecdsa.py genkey 43 31 25 25
22
2
12
$
```
- `sign` will sign a message.  In addition to the four standard numerical parameters ($p$, $n$, $G_x$, and $G_y$), there will be four more provided: $d$, $Q_x$, $Q_y$, and $h$.  The first three of these ($d$, $Q_x$, $Q_y$) are what was output from the `genkey` mode, above.  The last one, $h$, is meant to represent the hash of the message that is being signed -- it will be in the range $1 \le h \le n-1$.  To simplify this assignment, we are not providing the message $m$ that you are to take the hash of -- we are just providing the hash value itself.  To be clear, the eight numerical parameters are, in order: ($p$, $n$, $G_x$, $G_y$, $d$, $Q_x$, $Q_y$, and $h$).  The output should be two integers, one on each line: the $r$ and $s$ values of the signature.  Note that the generated random $k$ value is *not* part of the output, as would be expected with a typical ECDSA implementation.  And if $r$ or $s$ is zero, your program should re-generate $k$ and try again -- there should be no apparent difference in the output.  Below is a sample execution run, which sets $p=43$, $n=31$, $G=(25,25)$, $d=22$, $Q=(2,12)$, and $h=30$.  Since this output is based on a random number that is generated (speficially, $k$), one would expect that your output would be different on each execution run.
  ```
$ ./ecdsa.py sign 43 31 25 25 22 2 12 30
21
7
$
```
- `verify` will verify a message.  In addition to the four standard numerical parameters ($p$, $n$, $G_x$, and $G_y$), there will be five more provided.  The next two are the public key: $Q_x$ and $Q_y$ (the verifier does not know the private key!).  Following that are the parts of the signature, $r$ and $s$.  Lastly will be the (computed) hash of the message that is being verified.  To be clear, the nine numerical parameters are, in order: ($p$, $n$, $G_x$, $G_y$, $Q_x$, $Q_y$, $r$, $s$, and $h$).  The output should just be 'True' if the signature matches, and 'False' if it does not.  Below are two sample execution runs, which set $p=43$, $n=31$, $G=(25,25)$, $Q=(2,12)$, $r=21$, $s=7$, and ($h=30$ or $h=31$).  This output is not based on a random number, so your program should have the same output for these two execution runs.
  ```
$ ./ecdsa.py verify 43 31 25 25 2 12 21 7 30
True
$ ./ecdsa.py verify 43 31 25 25 2 12 21 7 31
False
$
```

Note: please do not print out any other output for those modes, else your program will be marked incorrect by the auto-grader!  You are welcome to add additional modes that you use for debugging, or that perform those functions with verbose output.  But the four required modes -- `userid`, `genkey`, `sign`, and `verify` -- should only produce the output shown above.  

## Submission

There is only one file to submit: ecdsa.py.
