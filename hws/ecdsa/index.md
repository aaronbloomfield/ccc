ECDSA Implementation
====================

[Go up to the CCC HW page](../index.html) ([md](../index.md))

### Overview

In this homework you will implement the ECDSA algorithm.

The sizes of the numbers we are using will be small -- all 1,000 (base 10) or less.  While we are not particularly interested in efficiency, your program does have to run in a reasonable amount of time (say, a second or less).  In particular, your elliptic curve multiplication must be a logarithmic time algorithm (relative to $k$), not a linear time algorithm.

In this homework, it is critical to carefully test each stage of the assignment.  Each part requires that the previous part works properly -- and, if it does not, then it will be exceedingly difficult to debug your program.  If you get stuck, the best way to figure out where the bug is is to print out the values at each step, and verify them by hand or via online calculators (linked to below).  A full work-up of a sample calculation is provided later in this document.

You will need to be familiar with the [Encryption slide set](../../slides/encryption.html#/), specifically the three sections that deal with the content in this assignment: [elliptic curves](../../slides/encryption.html#/elliptic), [finite fields](../../slides/encryption.html#/fields), and [ECDSA](../../slides/encryption.html#/ecdsa).  What this assignment is asking for will make no sense if you are not familiar with that material.


### Changelog

Any changes to this page will be put here for easy reference.  Typo fixes and minor clarifications are not listed here. <!--  So far there aren't any significant changes to report. -->

- Sat, Feb 4: added the "Corner cases and EC multiplication" part of the "Testing" section.

### Languages

You can write this assignment in Java or Python.  If you want to use a different language, please speak to me first.  The intent is for you to write all this code yourself -- you can NOT use any libraries that do field arithmetic, elliptic curve arithmetic, etc.  This includes any hashing functions (such as hashlib in Python); note that you never have to take a hash in this assignment.  We expect you to only need the most common standard libraries as a result.

We realize that the default random number generators in most (all?) programming languages are not cryptographically secure random number generators, but that's fine for this assignment.


### Other files

We are going to call your program by calling an `ecdsa.sh` shell script.  Any parameters passed to the shell script will be passed as-is to your program.  This is what your ecdsa.sh script should look like if you are using Python:

```
#!/bin/bash
python3 ecdsa.py $@
```

If you are using Java, it would look like this:

```
#!/bin/bash
java ECDSA $@
```

Be sure to call `python3`, not `python` in your shell script!  Otherwise it will not work. 

Of course, you should change the second line to match the file/class names that you choose.

You will also have to submit a `Makefile` that will be used to compile your program, if needed.  For languages that do not need compilation (such as Python), just put in a single `echo` statement so that `make` still runs properly.  This is the same as in the [last assignment](../intro/index.html) ([md](../intro/index.md)).


### Step 1: Finite Fields

The first step is to ensure that you have all the finite field arithmetic functions that are necessary.  Some of these are easy -- addition and multiplication, for example.  Others are a bit more challenging, such as division.  You will likely want to reference the [finite field section of the lecture slides](../../slides/encryption.html#/fields).  In addition to the four standard arithmetic operations, you will likely also need exponentiation, obtaining the additive inverse, and obtaining the multiplicative inverse.  Some functions will likely use others -- division of $a$ by $x$ is just multiplying $a$ by the multiplicative inverse of $x$, for example.

For ease of the development of later steps, the field size should be a parameter to the functions.

Test these well to ensure that they work!  You can test your operations by using the arithmetic identities: if $x$ is the multiplicative inverse of $y$, then $x \ast y = 1$, for example.

### Step 2: EC operations

There are three elliptic curve point operations that will be needed:

- Elliptic curve addition of a point to itself: $Q = P \oplus P$.  For this operation you will need to determine the slope of the secp256k1 curve $y^2=x^3+7$; that derivative is $dy/dx = 3x^2/2y$; this is discussed on [this slide](../../slides/encryption.html#/secp256k1derivative) of the [encryption slide set](../../slides/encryption.html#/).
- Elliptic curve addition of two different points: $P=Q \oplus R$
- Elliptic curve multiplication of a point by a scalar value: $P = k \otimes Q$.  Really this is performing elliptic curve addition of that point $k$ times, but we can't do that many additions (that's a linear time operation relative to $k$) -- instead, this needs to be a logarithmic operation, as discussed in lecture (specifically, [here](../../slides/encryption.html#/computingkg)).

 Some references from the lecture slides:

 - The [elliptic curve section](../../slides/encryption.html#/elliptic) of the encryption slide set shows how these operations work visually (albeit in the real numbers)
 - The last few slides in the [finite field section](../../slides/encryption.html#/fields) discusses how to perform this arithmetic in a field.

You can test your functions by using two websites: one that does [elliptic curve addition in a field](https://andrea.corbellini.name/ecc/interactive/modk-add.html?a=0&b=7&p=43) and one that does [elliptic curve multiplication in a field](https://andrea.corbellini.name/ecc/interactive/modk-mul.html?a=0&b=7&p=43).  The curve we are using is secp256k1, which sets $a=0$ and $b=7$.  For testing purposes, we recommend setting the prime modulus $p$ to 43; this will give an curve order ($o$) value of 31.  Other valid field sizes (aka $p$ values) are listed in the "Testing" section of this assignment.

There are some corner cases to test as well.  Given $P=(x,y)$, it's reflection is $P'=(x,-y)$.  Within the field $Z_p$, that reflection is $P'=(x,p-y)$.  Adding a point and its reflection together gets $O$ (or $0$), the point at infinity, which is also the identity element.  Your code should be able to compute $P \oplus P' = O$, for however you represent $O$.  It should also be able to compute $O+P=P$.  You can see that [here in the slides](../../slides/encryption.html#/pointo).

### Step 3: Signatures

One the previous two steps are completed (and tested!), you can proceed to generate the signature and then validate it; this is discussed in the [ECDSA section](../../slides/encryption.html#/ecdsa) of the encryption slide set.

We recommend reading through the next section of this assignment, on input and output, before starting to work on this section.

Your program will need to be able to perform three primary functions, listed below.  We will only be using the secp256k1 curve, so you can always assume that $a=0$ and $b=7$.

- Key generation: Given the curve parameters ($p$, $o$, and $G$), choose a random value $d$, the private key, such that $1 \le d \le o-1$.  Use that to determine the public key, point $Q$, such that $Q = d \otimes G$.  Key generation is discussed in the slides [here](../../slides/encryption.html#/ecdsakeygen).
- Signing a message: Given the curve parameters ($p$, $o$, and $G$), the private key ($d$), and the hash ($h$) of the message to be signed, you should generate the $(r,s)$ ECDSA signature.  Signing is discussed in the slides [here](../../slides/encryption.html#/ecdsasign).  Formally you need to compute:
  - A random one-time pad $k$ and $k^{-1}$, which is its multiplicative inverse in $Z_o$ (not $Z_p$!)
  - $R=k \otimes G$, and let $r$ be the $x$-coordinate of $R$
  - $s=k^{-1}(h+r*d) \mod o$
  - The signature is $(r,s)$
- Verifying a message: Given the curve parameters ($p$, $o$, and $G$), the public key $Q$, the signature $(r,s)$, and the hash $h$, you should verify that the signature is (or is not) valid. Verification is discussed in the slides [here](../../slides/encryption.html#/ecdsaverifystart).  Formally you need to compute:
  - $s^{-1}$, which is the multiplicative inverse of $s$ in $Z_o$ (not $Z_p$!)
  - $R = s^{-1} \ast h \otimes G \oplus s^{-1} \ast r \otimes Q$
  - Assure that the $r$ from the signature matches the $x$-coordinate of $R$


### Step 4: Correct I/O

Your program will take in a number of command line parameters.  You can always assume that the number and format of command line parameters will be correct, as specified below -- you do not need to error check the parameters (neither the number nor the format).  You may also assume that any points provided (such as $G$ or $Q$) will always lie on the curve.  Your program will only use the secp256k1 curve for all execution runs, so you can globally set $a=0$ and $b=7$; these two values will not be passed to the program.

Each execution run of the program will take in a string as the first command-line parameter; this is the so-called *mode*.  After the mode will be a series of command-line parameters, all of which will be integers.  Other than the `userid` mode, the first four integer parameters will always be, in this order: the prime modulus $p$, the curve order $o$, and the $x$ and $y$ coordinates for the base point $G$.  All numerical values provided will be non-negative integers not greater than 1,000.  All numbers provided as input parameters, or output by the program, are base-10 numbers.  And both $p$ and $o$ will always be prime numbers when we test your code.

The four required modes of the program are:

- `userid` will just print your userid.  All lower-case, no quotes, and no extra spaces.  There will not be any other command-line parameters.  Below is an execution run.  Needless to say, it should print out *your* userid, not 'mst3k'.
  ```
$ ./ecdsa.sh userid
mst3k
$
```
- `genkey` will generate a (random) primary key $d$ such that $1 \le d \le o-1$, and use that to compute the public key, point $Q$.  The numerical command-line parameters are just the four described above ($p$, $o$, $G_x$, $G_y$).  The output should be three integers, one on each line: $d$, $Q_x$, and $Q_y$.  You can verify [here](https://andrea.corbellini.name/ecc/interactive/modk-mul.html?a=0&b=7&p=43) that the values returned are correct (specifically that $Q=d \otimes G$). Below is a sample execution run, which uses $p=43$, $o=31$, and $G=(25,25)$.  Since this output is based on a random number that is generated (specifically, $d$), one would expect that your output would be different on each execution run.  The result of the execution run shown below is that the private key is $d=16$ and the public key is $Q=(37,36)$.  A full work-up of this computation is in the next section.
  ```
$ ./ecdsa.sh genkey 43 31 25 25
16
37
36
$
```
- `sign` will sign a message.  In addition to the four standard numerical parameters ($p$, $o$, $G_x$, and $G_y$), there will be two more provided: $d$ and $h$.  The first these, $d$ is the private key, and was part of the output from the `genkey` mode, above.  The second one, $h$, is meant to represent the hash of the message that is being signed -- it will be an integer in the range $1 \le h \le o-1$.  To simplify this assignment, we are not providing the message $m$ that you are to take the hash of -- we are just providing the hash value itself as a base-10 integer.  Note that $Q$ is not needed for signing, and is thus not provided.  To be clear, the six numerical parameters are, in order: ($p$, $o$, $G_x$, $G_y$, $d$, $h$).  The output should be two integers, one on each line: the $r$ and $s$ values of the signature.  Note that the randomly generated -- and secret -- value $k$ is *not* part of the output, as would be expected with a typical ECDSA implementation.  And if $r$ or $s$ are zero, your program should re-generate $k$ and try again -- there should be no difference in the output.  Below is a sample execution run, which uses $p=43$, $o=31$, $G=(25,25)$, $d=16$, and $h=30$ (the public key, $Q=(37,36)$, is not part of the parameter list).  Since this output is based on a random number that is generated (specifically, $k$), one would expect that your output would be different on each execution run. The result of the execution run below is that the signature is $(r,s)=(12,24)$. A full work-up of this computation is in the next section.
  ```
$ ./ecdsa.sh sign 43 31 25 25 16 30
12
24
$
```
- `verify` will verify a message.  In addition to the four standard numerical parameters ($p$, $o$, $G_x$, and $G_y$), there will be five more parameters provided.  The next two are the public key: $Q_x$ and $Q_y$ (the verifier does not know the private key!).  Following that are the two parts of the signature, $r$ and $s$.  Lastly will be the (computed) hash of the message that is being verified.  To be clear, the nine numerical parameters are, in order: ($p$, $o$, $G_x$, $G_y$, $Q_x$, $Q_y$, $r$, $s$, $h$).  The output should just be 'True' if the signature matches, and 'False' if it does not -- case matters here!  Below are two sample execution runs, which set $p=43$, $o=31$, $G=(25,25)$, $Q=(37,36)$, $(r,s)=(12,24)$, and ($h=30$ or $h=29$).  This output is *not* based on a random number, so your program should have the same output for these two execution runs. A full work-up of this computation is in the next section.
  ```
$ ./ecdsa.sh verify 43 31 25 25 37 36 12 24 30
True
$ ./ecdsa.sh verify 43 31 25 25 37 36 12 24 29
False
$
```

Note: please do not print out any other output for those modes, else your program will be marked incorrect by the auto-grader!  You are welcome to add additional modes that you use for debugging, or that perform those functions with verbose output.  But the four required modes -- `userid`, `genkey`, `sign`, and `verify` -- must only produce the output shown above.  

Your code may occasionally incorrectly verify a invalid signature!  The computation of $s$ is computed mod $o$, which -- in this example -- is only 31.  This means about 1 in 31 random but invalid signatures would be expected to verify as true.  (In reality, with secp256k1, $o \approx 1.16 \ast 10^{77}$, the chance of an invalid signature returning true is quite small).  If you do get an invalid signature (or two or three) to return true, just try some other values.

### Example

To help you understand the previous example, below is the complete formulaic work-up of the values that were computed above in the three execution runs.  All elliptic point computations can be verified [here for addition](https://andrea.corbellini.name/ecc/interactive/modk-add.html?a=0&b=7&p=43) and [here for multiplication](https://andrea.corbellini.name/ecc/interactive/modk-mul.html?a=0&b=7&p=43); verification links are them are also provided below.  Note that some of the values used (specifically $d$ and $k$) are randomly generated, so we would expect them to be different in your execution runs.

To ensure clarity about the operations, the $+$ symbol is only used for scalar addition (meaning between two numbers) and the $\ast$ symbol is only used for scalar multiplication (meaning between two numbers).  Addition of two elliptic points uses the $\oplus$ symbol, and multiplication of an elliptic point by a scalar uses the $\otimes$ symbol.

We know that the prime modulus $p=43$, the order $o=31$, and the base point $G=(25,25)$, as these were given in the first four numeric command-line parameters.  These are consistent for all the execution runs.

**Elliptic point addition:** There are [formulas presented in the slides](../../slides/encryption.html#/secp256k1addition) to add two points, both on secp256k1, within a field.  Given two points $P_1=(x_1,y_1)$ and $P_2=(x_2,y_2)$, the sum of those two points is: $x_3=m^2-x_1-x_2$ and $y_3=m(x_1-x_3)-y_1$.  In $Z_{43}$ we'll pick two arbitrary points to add: $(29,31)$ and $(37,36)$.  Formally, we want to compute $P_3=P_1 \oplus P_2 = (29,31) \oplus (37,36)$.  As we are not counting points on a curve, but instead just using curve formulas, this is all mod'ed by 43 (NOT $o=31$).

First we determine the slope.  The formula is $m=(y_2−y_1)/(x_2−x_1)=(36-31)/(37-29)=5/8$.  The division $5 \div 8$ in $Z_{43}$ is 6 (confirmation: $6*8 \mod 43 = 5$).  Thus, we know the slope: $m=6$.  To determine the points, we use the [formulas presented in the slides](../../slides/encryption.html#/secp256k1addition):  $x_3=m^2-x_1-x_2=6^2-29-37=13$ and $y_3=m(x_1-x_3)-y_1=6*(29-13)-31=22$, both in $Z_{43}$.  (I've removed all the "mod $p$" parts for clarity.)  Thus, $(29,31) \oplus (37,36) = (13,22)$, and this computation can be verified [here](https://andrea.corbellini.name/ecc/interactive/modk-add.html?a=0&b=7&p=43&px=29&py=31&qx=37&qy=36).

**Elliptic point multiplication:** There is an example in the next section ("Testing") that shows elliptic point multiplication, and shows how to avoid cases that will generate the point at infinity as the answer.

**Key generation:** The random value for the private key is $d=16$.  Computing $d \otimes G = 16 \otimes (25,25) = (37,36)$ ([verification](https://andrea.corbellini.name/ecc/interactive/modk-mul.html?a=0&b=7&p=43&n=16&px=25&py=25)).

**Signing:** The secret $k$ value, which was not shown, was $k=17$.  We compute $R = k \otimes G = 17 \otimes (25,25) = (12,12)$ ([verification](https://andrea.corbellini.name/ecc/interactive/modk-mul.html?a=0&b=7&p=43&n=17&px=25&py=25)).  The $x$-value of this, 12, is the first part of the signature, and is referred to as lower-case $r$.  We next have to compute $k^{-1}$.  Because $k$ is counting the number of points, the inverse is computed in $Z_{31}$, NOT in $Z_{43}$.  Thus, in $Z_{31}$, $17^{-1} = 11$ ([verification](https://planetcalc.com/3311/?a=17&m=31); also that $11 \ast 17 \mod 31 = 1$).  We know via the command-line parameters that $h=30$ and $d=16$, and we have just computed $r=12$.  We can then compute $s$, which also is computed in $Z_{31}$, NOT $Z_{43}$: $s=k^{−1}(h+r∗d) \mod o = 11 \ast (30 + 12 \ast 16) \mod 31 = 24$.  Thus, the signature is $(r,s)=(12,24)$.

**Verification:** We are given the values for $Q=(37,36)$ and the signature $(r,s)=(12,24)$.  We are given two different hash values, each on its own execution run: the correct hash value of $h=30$ and an incorrect hash value of $h=29$.  As $s$ was computed in $Z_{31}$ (NOT $Z_{43}$), we also compute it's inverse in $Z_{31}$: $s^{-1}=24^{-1}=22$ in $Z_{31}$; ([verification](https://planetcalc.com/3311/?a=24&m=31); also that $22 \ast 24 \mod 31 = 1$).  

To verify the correct signature (where $h=30$), we need to compute $R=s^{−1} \ast h \otimes G \oplus s^{−1} \ast r \otimes Q$ = $660 \otimes G \oplus 264 \otimes Q$ (this is an equivalent form of the formula used to sign the signature, as shown in the slides starting [here](../../slides/encryption.html#/ecdsaverify)).  We can mod those two scalars (660 and 264), but that mod is also in $Z_{31}$, and yields $R = 9 \otimes G \oplus 16 \otimes Q = 9 \otimes (25,25) \oplus 16 \otimes (37,36) = (2,31) \oplus (29,31) = (12,12)$; (verifications [1](https://andrea.corbellini.name/ecc/interactive/modk-mul.html?a=0&b=7&p=43&n=9&px=25&py=25), [2](https://andrea.corbellini.name/ecc/interactive/modk-mul.html?a=0&b=7&p=43&n=16&px=37&py=36), and [3](https://andrea.corbellini.name/ecc/interactive/modk-add.html?a=0&b=7&p=43&px=2&py=31&qx=29&qy=31)).  Because the $x$-value of this computed point (i.e., 12) equals the provided $r$ value in the signature, the signature is valid.

The second execution run had the incorrect hash ($h=29$).  The process is the same as the above -- we compute $R=s^{−1} \ast h \otimes G \oplus s^{−1} \ast r \otimes Q$.  As $h$ is different the coefficient in front of $G$ changes: $R = 638 \otimes G \oplus 264 \otimes Q = 18 \otimes G \oplus 16 \otimes Q = (7,36) \oplus (29,31) = (21,18)$; (verifications [1](https://andrea.corbellini.name/ecc/interactive/modk-mul.html?a=0&b=7&p=43&n=18&px=25&py=25), [2](https://andrea.corbellini.name/ecc/interactive/modk-mul.html?a=0&b=7&p=43&n=16&px=37&py=36), and [3](https://andrea.corbellini.name/ecc/interactive/modk-add.html?a=0&b=7&p=43&px=7&py=36&qx=29&qy=31)).  As the $x$-value of that computed $R$, specifically the value 21, does not equal the $r=12$ provided with the signature, the signature is not valid.

### Testing

One type of test that we are going to perform is whether your program can verify a signature that your code signs; another is whether it can indicate as invalid a signature that you did not sign.  We will be trying different prime field sizes; all of the ones listed below also have a prime order size.  Here are a few examples you can use.

- $p=43$, $o=31$, $G=(25,25)$
- $p=79$, $o=67$, $G=(35,8)$
- $p=127$, $o=127$, $G=(93,33)$
- $p=733$, $o=691$, $G=(336,170)$

You are certainly welcome to come up with your own examples to test it with as well -- just make sure BOTH $p$ and $o$ are prime.

Note that if you enter the curve of $a=0$ and $b=7$ into [this site](https://andrea.corbellini.name/ecc/interactive/modk-mul.html?a=0&b=7&p=43), and enter a different $p$ value, it will tell you the order below the boxes ("The curve has ... points").  You can pick any valid point on that curve as $G$; we just arbitrarily picked one for the examples above.

#### Corner cases and EC multiplication

Let's imagine that you wanted to compute $1000 \otimes (12,31)$ in $Z_{43}$.  We can see that the answer is $(20,3)$ ([verification](https://andrea.corbellini.name/ecc/interactive/modk-mul.html?a=0&b=7&p=43&n=1000&px=13&py=31)).  But to compute it ourselves, first you we compute the powers of 2 that add to 1,000: $1000=512+256+128+64+32+8$.

Next, we determine $(12,31)$ times the various powers of two by repeatedly adding it to itself:

- $1 \otimes (12,31) = (12,31)$
- $2 \otimes (12,31) = 1 \otimes (12,31) \oplus 1 \otimes (12,31) = (12,31) \oplus (12,31) = (42,36)$ (verifications [1](https://andrea.corbellini.name/ecc/interactive/modk-add.html?a=0&b=7&p=43&px=12&py=31&qx=12&qy=31) and [2](https://andrea.corbellini.name/ecc/interactive/modk-mul.html?a=0&b=7&p=43&n=2&px=12&py=31))
- $4 \otimes (12,31) = 2 \otimes (12,31) \oplus 2 \otimes (12,31) = (42,36) \oplus (42,36) = (40,25)$ (verifications [1](https://andrea.corbellini.name/ecc/interactive/modk-add.html?a=0&b=7&p=43&px=42&py=36&qx=42&qy=36) and [2](https://andrea.corbellini.name/ecc/interactive/modk-mul.html?a=0&b=7&p=43&n=4&px=12&py=31))
- $8 \otimes (12,31) = 2 \otimes (12,31) \oplus 2 \otimes (12,31) = (40,25) \oplus (40,25) = (20,3)$ (verifications [1](https://andrea.corbellini.name/ecc/interactive/modk-add.html?a=0&b=7&p=43&px=40&py=25&qx=40&qy=25) and [2](https://andrea.corbellini.name/ecc/interactive/modk-mul.html?a=0&b=7&p=43&n=8&px=12&py=31))
- $16 \otimes (12,31) = 2 \otimes (12,31) \oplus 2 \otimes (12,31) = (20,3) \oplus (20,3) = (13,21)$ (verifications [1](https://andrea.corbellini.name/ecc/interactive/modk-add.html?a=0&b=7&p=43&px=20&py=3&qx=20&qy=3) and [2](https://andrea.corbellini.name/ecc/interactive/modk-mul.html?a=0&b=7&p=43&n=16&px=12&py=31))
- $32 \otimes (12,31) = 2 \otimes (12,31) \oplus 2 \otimes (12,31) = (13,21) \oplus (13,21) = (12,31)$ (verifications [1](https://andrea.corbellini.name/ecc/interactive/modk-add.html?a=0&b=7&p=43&px=13&py=21&qx=13&qy=21) and [2](https://andrea.corbellini.name/ecc/interactive/modk-mul.html?a=0&b=7&p=43&n=32&px=12&py=31))
- $64 \otimes (12,31) = 2 \otimes (12,31) \oplus 2 \otimes (12,31) = (12,31) \oplus (12,31) = (42,36)$ (verifications [1](https://andrea.corbellini.name/ecc/interactive/modk-add.html?a=0&b=7&p=43&px=12&py=31&qx=12&qy=31) and [2](https://andrea.corbellini.name/ecc/interactive/modk-mul.html?a=0&b=7&p=43&n=64&px=12&py=31))
- $128 \otimes (12,31) = 2 \otimes (12,31) \oplus 2 \otimes (12,31) = (42,36) \oplus (42,36) = (40,25)$ (verifications [1](https://andrea.corbellini.name/ecc/interactive/modk-add.html?a=0&b=7&p=43&px=42&py=36&qx=42&qy=36) and [2](https://andrea.corbellini.name/ecc/interactive/modk-mul.html?a=0&b=7&p=43&n=128&px=12&py=31))
- $256 \otimes (12,31) = 2 \otimes (12,31) \oplus 2 \otimes (12,31) = (40,25) \oplus (40,25) = (20,3)$ (verifications [1](https://andrea.corbellini.name/ecc/interactive/modk-add.html?a=0&b=7&p=43&px=40&py=25&qx=40&qy=25) and [2](https://andrea.corbellini.name/ecc/interactive/modk-mul.html?a=0&b=7&p=43&n=256&px=12&py=31))
- $512 \otimes (12,31) = 2 \otimes (12,31) \oplus 2 \otimes (12,31) = (20,3) \oplus (20,3) = (13,21)$ (verifications [1](https://andrea.corbellini.name/ecc/interactive/modk-add.html?a=0&b=7&p=43&px=12&py=31&qx=12&qy=31) and [2](https://andrea.corbellini.name/ecc/interactive/modk-mul.html?a=0&b=7&p=43&n=512&px=12&py=31))

Note that a lot of the points repeat because it's a small field ($p=43$) with a small order ($o=31$), and the order size is one less than a power of 2.

Next we add up the necessary values.  Recall that elliptic curve addition is commutative (you can add the points in any order and get the same result).  Let's assume we add them left-to-right

- $1000 \otimes (12,31) = 512 \otimes (12,31) \oplus 256 \otimes (12,31) \oplus 128 \otimes (12,31) \oplus 64 \otimes (12,31) \oplus 32 \otimes (12,31) \oplus 8 \otimes (12,31)$
- $1000 \otimes (12,31) = (13,21) \oplus (20,3) \oplus (40,25) \oplus (42,36) \oplus (12,31) \oplus (20,3)$
  - As $(13,21) \oplus (20,3) = (21,18)$ we get:
- $1000 \otimes (12,31) = (21,18) \oplus (40,25) \oplus (42,36) \oplus (12,31) \oplus (20,3)$
  - As $(21,18) \oplus (40,25) = (38,21)$ we get:
- $1000 \otimes (12,31) = (38,21) \oplus (42,36) \oplus (12,31) \oplus (20,3)$
  - As $(38,21) \oplus (42,36) = (12,12)$ we get:
- $1000 \otimes (12,31) = (12,12) \oplus (12,31) \oplus (20,3)$

And here we run into a problem.  Trying to compute $(12,12) \oplus (12,31)$ is going to yield the point at infinity, as we are [adding two points that form a vertical line](../../slides/encryption.html#/3/22).  We could first compute $(12,12) \oplus (20,3) = (21,25)$, and then finally compute $(21,25) \oplus (12,31) = (20.3)$ (the final answer).  But there are a lot of corner cases for where the two points are in the list that have the same $x$-value.

We are not looking for the most optimal solution, just a working one.

For this assignment, when adding the points together, if you come across two points that have the same $x$-value, just shuffle the list of points and then add them up again.


### Submission

You have to submit three files:

- `ecdsa.sh`, the shell script that will be called to run your program.  See above for the format.
- A Makefile that will compile your code when we call `make`, which will be called on submission.  For languages that do not need compilation (such as Python), just put in a single `echo` statement so that `make` still runs properly.
- The source code itself, likely something like `ecdsa.py` or `ECDSA.java`
