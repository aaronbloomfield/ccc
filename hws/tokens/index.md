Ethereum Tokens
===============

[Go up to the CCC HW page](../index.html) ([md](../index.md))

<!-- to provide on the Canvas landing page:

	- the blockchain explorer url
	- the URLs to upload the NFT images and the TCC logo to
		- explain that it should then appear in the blockchain explorer
		- mention that it puts `mst3k_` at the start of each NFT image if they don't have it there
	- the account to send the 10.0 TCC and the NFT to
	- the account of the course-wide NFT manager

-->


### Overview

In this assignment you are going to develop and deploy two types of tokens on our private Ethereum blockchain.  You will develop a token cryptocurrency manager using the [ERC-20 token standard](https://ethereum.org/en/developers/docs/standards/tokens/erc-20/), and you will deploy a non-fungible token (NFT) manager using the [ERC-721 token standard](https://ethereum.org/en/developers/docs/standards/tokens/erc-721/).

The actual amount of code developed in this assignment is relatively small.  The complexity is understanding the code of the existing implementations and extending them.

As you develop the items in this assignment, keep in mind that -- on our private Ethereum blockchain -- it is possible to track back whose smart contracts are whose.

You will have to have completed the [connecting to the private Ethereum blockchain](../ethprivate/index.html) assignment as well as the [dApp Introduction](../dappintro/index.html) assignment.  You will also need to be familiar with the [lecture slides on Tokens](../../slides/tokens.html#/).  For some of the tasks below you will need to launch your geth node, connecting to the course server, and start up a geth Javascript terminal; how to do all that is all described in the [connecting to the private Ethereum blockchain](../ethprivate/index.html) assignment.

If you have not successfully completed those two assignments, then you will not be able to complete this assignment.

In addition to your source code, you will submit an edited version of [tokens.py](tokens.py.html) ([src](tokens.py)).

### Changelog

Any changes to this page will be put here for easy reference.  Typo fixes and minor clarifications are not listed here.  <!-- So far there aren't any significant changes to report. -->

- Fri, 3/22: Added one more field to the `other` dictionary: `'which_gen_ai_tool_used'`
- Thu, 3/21: Added one more sanity check to [tokens.py](tokens.py.html) ([src](tokens.py)): `'created_two_nfts_on_own'`
- Thu, 3/21: Added two more fields to the `other` dictionary in [tokens.py](tokens.py.html) ([src](tokens.py)): `'used_gen_ai_for_cclogo'` and `'used_gen_ai_for_nfts'`.  See the comments therein for details.  If you already downloaded the tokens.py file and started editing it, you can just cut-and-paste those two fields into the `other` dictionary.


### Part 1: ERC-20 Fungible Token

In this part, you will create a fungible token manager that follows the (enhanced) [ERC-20 token standard](https://ethereum.org/en/developers/docs/standards/tokens/erc-20/).  This token will represent a token cryptocurrency.  You will use this code in future assignments, such as where you will be creating a decentralized cryptocurrency exchange for the cryptocurrency that you are creating here.

#### Part 1, task 1: Name your cryptocurrency

You can pick any name that you want.  The only restrictions are that you can not use the name of the course cryptocurrency or of an [existing cryptocurrency](https://coinmarketcap.com/).  Feel free to be funny and creative here, but please be appropriate in your selection.  Also keep in mind that, in this course, it is possible for somebody to figure out who deployed what cryptocurrency by analyzing the blockchain.  

You will need to create both a name and an abbreviation.  The name can have spaces in it; only *alphanumeric* ASCII characters (this means no emojis).  Your abbreviation cannot already be taken by another student.  To see if an abbreviation has been taken, go to the URL (which is on the Canvas landing page) and try to upload an image with the appropriate name (`xyz.png`, for example).  That site will tell you if that name is already taken -- if so, then some other student has claimed that abbreviation.  To claim an abbreviation, upload such a named file.  You can put a placeholder file there while you work on the logo (below) and then upload a better image later.  Please make the file name be all lower case.

Following in the precedent for currently existing cryptocurrencies, abbreviations are at most four characters, typically three, and possibly two.  You can have letters and numbers, but not symbols; the first character of the abbreviation must be a letter.  The abbreviation when representing the cryptocurrency is always rendered in upper case (i.e., "XYZ"), but the logo file name is all lower case with a ".png" extension (i.e., "xyz.png").

In this course, we will generally be using the abbreviation "TC" when referring to a generic token cryptocurrency.


#### Part 1, task 2: Create a logo

You will need to create a logo for your cryptocurrency.  The logo that you submit should be 512x512 pixels in size.  Use a fun color!  Create a neat logo!  But please make sure the logo is appropriate.  You can look at the types of logos on a site such as [coinmarketcap.com](https://coinmarketcap.com) for ideas, as well as [cryptologos.cc](https://cryptologos.cc/) and [this github site](https://github.com/coinwink/cryptocurrency-logos).  You are welcome to use any generative AI tool for this image creation, as long as it fulfills the requirements below.

The logo itself needs to have the following requirements:

- A circular logo with a transparent background outside the circle, just like what is on coinmarketcap.com.  Your logo can also be almost-circular, like some we have -- or will have -- seen: [STORJ](../../slides/images/logos/storj-coin-symbol.svg), [ERG](../../slides/images/logos/erg-coin-symbol.svg), and [MIM](../../slides/images/logos/mim-coin-symbol.svg).
- It should be recognizable if the size were reduced to a 32x32 pixel version.
- The background outside the circle of the coin needs to be transparent.
- The background of the coin circle itself needs to be something more interesting than white.
- The file must be a .png file, and it will have to be named `xyz.png`, where "xyz" is your coin abbreviation.
- The image should be 512x512 in size.  This means that the circular logo itself should be about 512 pixels in diameter -- having a 512x512 square image with a tiny logo in the center is not the intent.

We provide a [logo-template.png](logo-template.png) file as a starter file -- it is the correct size and has a transparent background outside the circle.  You can use a free program such as [GIMP](https://www.gimp.org/) to edit your program.  

You will upload your logo to the URL given on the Canvas landing page.

#### Part 1, task 3: Review the starter code

The code we are going to start with is the [OpenZeppelin ERC-20 implementation](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.0.0/contracts/token/ERC20/ERC20.sol) from the the [OpenZeppelin github repo](https://github.com/OpenZeppelin/openzeppelin-contracts).  This code was the same as was discussed in class.

The included code is:

- [Context.sol](Context.sol.html) ([src](Context.sol)) is a better way to get the context rather than `msg.sender` and `msg.data`; this is the [OpenZeppellin implementation](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Context.sol)
- [IERC165.sol](IERC165.sol.html) ([src](IERC165.sol)), as [discussed in lecture](../../slides/tokens.html#/erc165); this is the [OpenZeppellin implementation](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/introspection/IERC165.sol)
- [IERC20.sol](IERC20.sol.html) ([src](IERC20.sol)), as [discussed in lecture](../../slides/tokens.html#/erc20); this is the [OpenZeppellin implementation](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol)
- [IERC20Metadata.sol](IERC20Metadata.sol.html) ([src](IERC20Metadata.sol)), as [discussed in lecture](../../slides/tokens.html#/erc20); this is the [OpenZeppellin implementation](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/extensions/IERC20Metadata.sol)
- [ERC20.sol](ERC20.sol.html) ([src](ERC20.sol)); this is the [OpenZeppellin implementation](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol)
- [ITokenCC.sol](ITokenCC.sol.html) ([src](ITokenCC.sol)), as [discussed in lecture](../../slides/tokens.html#/erc20)
- [draft-IERC6093.sol](draft-IERC6093.sol.html) ([src](draft-IERC6093.sol)) is an imported file needed by some of the above

You can download *all* of these files via [sol-includes.zip](sol-includes.zip); this also includes the includes for the next section.

The *only* changes made to the OpenZeppelin code above is the paths in the `import` statements.

You should look over and familiarize yourself with all this code.  The inheritance hierarchy of this code is shown below.

![](inheritance.dot.1.svg)

Note that the only new files, beyond the the OpenZeppelin implementation, are the two bottom grey nodes.  We added was the ITokenCC interface, and you have to implement the TokenCC contract.


#### Part 1, task 4: Develop the smart contract

You will need to develop the smart contract for your cryptocurrency, and deploy it to our private Ethereum blockchain.  Your code will use the files listed above.

There are some very strict submission requirements for this submission so that we can grade it in a sane manner:

1. Your contract MUST be in a file called `TokenCC.sol`.
2. You must put your name and userid as the second line of the file (right after the SPDX line).
3. Your contract opening line MUST be: `contract TokenCC is ITokenCC, ERC20 {`; this will inherit the other contracts and interfaces (Context, IERC20, IERC20Metadata, ERC20, and IERC165).
4. The pragma line should be: `pragma solidity ^0.8.24;`.
5. You are NOT to submit any of the *files* for the interfaces above (Context.sol, IERC20.sol, IERC20Metadata.sol, ITokenCC.sol, or IERC165.sol), nor the ERC20.sol file.  And don't include the code from those files in your TokenCC.sol file.  You should `import` them in `TokenCC.sol` as such: `import "./ITokenCC.sol";` and `import "./ERC20.sol";` -- those two files import all the other contracts and interfaces.  The necessary files will be put into the appropriate directory on Gradescope when it compiles your program.
6. You cannot edit the [ERC20.sol](ERC20.sol.html) ([src](ERC20.sol)) file -- any changes have to go into your `TokenCC.sol` file.

Your task is to create a `TokenCC.sol` file with a `TokenCC` contract.  Some implementation notes:

- You have to define the name and symbol when the constructor is called -- you can do this by calling the base class (`ERC20`) constructor that takes two parameters -- to see how to do this, look at [this lecture slide](../../slides/tokens.html#/erc20constructor) and the [Arguments for Base Constructors](https://docs.soliditylang.org/en/v0.8.13/contracts.html#arguments-for-base-constructors) section of the Solidity language reference.  Defining them via this method means you don't have to create a `name()` method nor a `name` public variable (and likewise for `symbol()` and `symbol`), as the ERC20 code will provide that for you.
- The `decimals()` function:
	- You cannot define a public variable for `decimals` because of peculiarities of Solidity inheritance; it has to be a function.
	- Your `decimals()` function will override a method defined in two ancestors in the inheritance tree -- `ERC20` and `IERC20Metadata`.  You have to use a form of `override` that specifies the multiple items being overridden, as shown [here](../../slides/solidity.html#/multioverride).
	- How many decimals you pick is up to you.  Ethereum uses 18; Bitcoin uses 8.  To make this a bit more sane for us to manage, let's choose a number between 8 and 12 (inclusive).
- Minting coins:
	- Keep in mind that, because the `_mint()` function is `internal`, it can only be called from code you write.  So your constructor should mint for you a reasonable amount of the cryptocurrency.
	- How many coins you mint is up to you.  Bitcoin has 21 million coins; Ravencoin has 21 billion coins.  On the other end of the spectrum, [SHIB](https://coinmarketcap.com/currencies/shiba-inu/) -- a token cryptocurrency on Ethereum -- minted 549,063,278,876,302 (yes, $5.5 \ast 10^{14}$ or about 550 trillion) coins.  
		- We would recommend no less than 1,000 coins, and it *must* be at least 100 coins.
		- A million coins, or a billion coins, is not unreasonable here
		- Keep in mind the amount you are specifying in the mint call is $x \ast 10^d$ where $x$ is how many coins you want to mint and $d$ is the number of decimal places.  So if you want to mint 100 coins, and you are using 10 decimal places, then the amount to mint is 1,000,000,000,000.
- You have to implement the `supportsInterface()` method to fulfill the requirements of the [IERC165.sol](IERC165.sol.html) ([src](IERC165.sol)) contract; remember that your code supports *four* interfaces: `IERC165`, `IERC20`, `IERC20Metadata`, and `ITokenCC`.  Although your contract also extends `Context`, there are no `external` or `public` methods in `Context`, and it's an abstract contract, so there is no interface there to support.
- You have to implement a `requestFunds()` function that does nothing other than `revert()` -- we will be using that function in a future assignment, which is why it is in this interface.  Since you are just going to call `revert()`, Solidity will recommend making that a `pure` function -- that's fine to do in your contract.  But the function line in the interface should not have the `pure` keyword on it, since a use of that function in a future assignment will read/write the contract's state.


Be sure to thoroughly test this in Remix!  Remember that you have multiple accounts in the Javascript deployment environment, so you can transfer your new cryptocurrency back and forth.  Just switch the account in the "Account" drop-down list to initiate a transaction from a different account.

#### Part 1, task 5: Deployment

One you have thoroughly tested your ERC-20 token in Remix, you should deploy it to our private Ethereum blockchain.  How to do this was covered in the [dApp Introduction](../dappintro/index.html) assignment, which you may want to refer back to.  You have to deploy this part and the next part from the same account, and you will have to submit that account address at the end.

Save the contract address it was deployed to, as you will need to submit those at the end of this assignment.


#### Part 1, task 6: Send me some money!

You need to transfer some amount of your cryptocurrency.  The address to transfer it to in on the Canvas landing page.  This should be through the `transfer()` function (NOT `approve()`).  You should transfer me exactly 10.0 of your token cryptocurrency.  So if you have 8 decimals, then you will transfer 1,000,000,000 (which is $10 \ast 10^8$) total units.  Save the transaction hash of where you sent me your cryptocurrency, as you will need to submit that value.

If you look at the blockchain explorer for the account you have to send the cryptocurrency to, it will tell you how much has been sent (formally, how much that account holds).  Note that if you deploy multiple contracts that use the same token cryptocurrency abbreviation, it will only consider the most recently deployed one -- which means if you redeploy the contract, you will have to re-send the cryptocurrency.


### Part 2: ERC-721 Non-Fungible Token

In this part, you will create a manager for non-fungible tokens (NFT) that follows the [ERC-721 token standard](https://ethereum.org/en/developers/docs/standards/tokens/erc-721/).  Such a token can represent anything, but we will have it represent some image.  You will use this code in a future assignment, where you will then be creating a decentralized auction for NFTs.

#### Part 2, task 1: NFT images

You will be creating three images for NFTs for this assignment.  The images should be uploaded to the URL provided on the Canvas landing page.  Note that you can upload a file into that folder, but once uploaded you can not edit it or delete it -- this was done to mirror the fact that you can't delete images from the Internet once they are placed on the web.  Only those in this course can view those files -- but that means anybody in the course can view it.

All image file names should start with your userid and an underscore: `mst3k_foo.jpg`.  You will need three such images.  As long as the file name starts with your userid and an underscore, we don't really care what (appropriate) alphanumeric string the rest of the file name is.  Only JPEG (.jpg), PNG (.png), and WEBP (.webp) images, please.

**NOTE:** The filenames, with the extension, **MUST** be strictly less than 32 characters in length.  This is just for the filename ("mst3k_foo_bar.png"), not the path to that file name.

The images must be no larger than 2000 pixels in either dimension!  Which means a 2000x2000 image is the maximum size.

We don't really care what images you upload, as long as:

1. They image file names are strictly less than 32 characters (including the extension, but not including the rest of the URL).
2. The image sizes are as specified above (no larger than 2000x2000).
3. They are appropriate images.  Nothing vulgar, nothing involving nudity, nothing that could be labeled NSFW (not safe for work), or otherwise deemed as offensive.  Basically, nothing that would get me in trouble with an administration that does not have a sense of humor about these things.  Like with the poll in the [dApp introduction](../dappintro/index.html) ([md](../dappintro/index.md)) assignment, there are many great ways to express your opinions that others may find controversial -- but an image for a NFT on our private Ethereum blockchain is not really one of them.
4. No animations, please.  They just cause problems in certain rendering situations.

You are welcome to use any generative AI tool for these images, as long as it fulfills the requirements described herein.

Understand this: **IN THIS COURSE, OWNING THE NFT DOES NOT IMPLY OWNERSHIP OF THE IMAGE.**  The assumption is that you may not actually own the original image.  Or if you do own the image, then possession of the NFT does not mean you are willing to give up ownership of the original image itself.

Pick some fun or funny image.  You are welcome to pick one from Wikipedia or Reddit or similar.  Or memes.  But something appropriate.  And keep in mind that, like with NFTs on the real Ethereum blockchain, anybody can download the image.  Likewise, others will be able to determine who uploaded that image, since your userid will be at the start of the image file name.

You will upload three such images to the URL given on the Canvas landing page.

#### Part 2, task 2: Review the starter code

The code we are going to start with is the [OpenZeppelin ERC-721 implementation](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.0.0/contracts/token/ERC721/ERC721.sol) from the the [OpenZeppelin github repo](https://github.com/OpenZeppelin/openzeppelin-contracts).  This code was the same as was discussed in class.  Other than the `import` lines, there have been no changes to the code in this repo.

In addition to some of the files used above (IERC165.sol. ERC165.sol, and Context.sol), there are a few additional files that this part uses; you will need to familiarize yourself with how they work.

- [Address.sol](Address.sol.html) ([src](Address.sol)) is a library (not a contract!) that provides some useful functions when dealing with Ethereum addresses; this is the [OpenZeppellin implementation](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol)
- [Strings.sol](Strings.sol.html) ([src](Strings.sol)) is a library (not a contract!) that provides some useful String manipulation functions; this is the [OpenZeppellin implementation](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Strings.sol)
- [Math.sol](Math.sol.html) ([src](Math.sol)) is a library needed for Strings.sol; this is the [OpenZeppellin implementation](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/Math.sol)
- [SignedMath.sol](SignedMath.sol.html) ([src](SignedMath.sol)) is a library needed for Strings.sol; this is the [OpenZeppellin implementation](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SignedMath.sol)
- [Context.sol](Context.sol.html) ([src](Context.sol)) is a better way to get the context rather than `msg.sender` and `msg.data`; this is the [OpenZeppellin implementation](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Context.sol)
- [IERC165.sol](IERC165.sol.html) ([src](IERC165.sol)), as [discussed in lecture](../../slides/tokens.html#/erc165); this is the [OpenZeppellin implementation](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/introspection/IERC165.sol)
- [ERC165.sol](ERC165.sol.html) ([src](ERC165.sol)): a bare-bones implementation of the `IERC165` interface; this is the [OpenZeppellin implementation](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/introspection/ERC165.sol)
- [IERC721.sol](IERC721.sol.html) ([src](IERC721.sol)), as [discussed in lecture](../../tokens.html#/erc721); this is the [OpenZeppellin implementation](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/IERC721.sol)
- [ERC721.sol](ERC721.sol.html) ([src](ERC721.sol)), which is the [OpenZeppelin ERC-721 implementation](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.0.0/contracts/token/ERC721/ERC721.sol); this is the [OpenZeppellin implementation](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol)
- [IERC721Metadata.sol](IERC721Metadata.sol.html) ([src](IERC721Metadata.sol)): this add three functions on top of the ERC-721 standard: `name()`, `symbol()`, and `tokenURI()`; the first two are for the NFT manager, the last one is the URI (aka URL) of the image that the NFT represents; this is the [OpenZeppellin implementation](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/extensions/IERC721Metadata.sol)
- [IERC721Receiver.sol](IERC721Receiver.sol.html) ([src](IERC721Receiver.sol)): we won't use the functionality in this interface, but it is needed for the ERC721.sol file to compile.; this is the [OpenZeppellin implementation](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/IERC721Receiver.sol)
- [INFTManager.sol](INFTManager.sol.html) ([src](INFTManager.sol)): this adds two `mintWithURI()` functions on top of the IERC721Metadata interface, which allow creation of NFTs, and setting it's image URI (aka URL) in one function call.  This also adds a `count()` method, which is how many NFTs have been minted by this manager.  Note that the `mintWithURI()` function will return a token ID, which is just a `uint` that is used to identify (and find) that particular NFT in your token manager.
- [ERC721Utils.sol](ERC721Utils.sol.html) ([src](ERC721Utils.sol)) is an imported file needed by some of the above
- [Panic.sol](Panic.sol.html) ([src](Panic.sol)) is an imported file needed by some of the above
- [SafeCast.sol](SafeCast.sol) ([src](SafeCast.sol)) is an imported file needed by some of the above
- [draft-IERC6093.sol](draft-IERC6093.sol.html) ([src](draft-IERC6093.sol)) is an imported file needed by some of the above

You can download *all* of these files via [sol-includes.zip](sol-includes.zip); this also includes the includes for the next section.

The *only* changes made to the OpenZeppelin code above is the paths in the `import` statements.

Why so many files?  Three of the interfaces (IERC165, IERC721, and IERC721Metadata) are Ethereum standards, and the practice is to include them as-is without modifications.  Four of the files are utilities (libraries or abstract contracts): Address, Context, Math, and Strings.  The INFTManager adds a few functions that we need, and the ERC721.sol is the implementation itself.  ERC165.sol is needed for ERC721 to compile.  We realize that's a lot of files to use, but that's why there are so many of them.

You should look over and familiarize yourself with this code. The inheritance hierarchy of this code is shown below.  Note that two of the entries (`Address` and `Strings`) are type substitutions in `ERC721.sol`.  `IERC721Recevier` is used as a casting type.

![](inheritance.dot.2.svg)

The only new files, beyond the the OpenZeppelin implementation, are the two bottom grey nodes.  We added was the INFTManager abstract contract, and you have to implement the NFTManager contract. There are a lot of lines because of how the OpenZeppelin code is set up.

#### Part 2, task 3: Compile and test the provided code

You should compile the [ERC721.sol](ERC721.sol.html) ([src](ERC721.sol)) code in Remix.  Deploy it to the Javascript environment and play with the various functions.  Note that you will have to remove the `abstract` keyword (right before the `contract` keyword) and re-compile it, to be able to deploy it.  Note that you need to understand what the code in that smart contract does!  As this is the provided code, and does not have all the features that we need (yet).


#### Part 2, task 4: Create an NFT manager for images

We are going to assemble all this code together to create an NFT manager.  Most of the code is already done in the [ERC721.sol](ERC721.sol.html) ([src](ERC721.sol)).  We are going to create a smart contract called `NFTManager` that will work for image URLs (or any other URL).  The updated smart contract will implement the [INFTManager.sol](INFTManager.sol.html) ([src](INFTManager.sol)) interface (and, though inheritance, a number of other interfaces).  


There are some very strict submission requirements for this submission so that we can grade it in a sane manner:

1. You must put your name and userid as the second line of the file (right after the SPDX line)
2. Your contract MUST be in a file called `NFTManager.sol` -- note the capitalization!
3. Your contract line MUST be: `contract NFTManager is INFTManager, ERC721 {`; this will inherit all the other necessary interfaces and contracts.
4. The pragma line should be: `pragma solidity ^0.8.24;`
5. You are NOT to submit any of the *files* for the interfaces above (ERC721, IERC721, INFTManager, IERC165.sol, etc.), nor the ERC721 file either.  And don't copy-and-paste that code in your file.  You should `import` them in `NFTManager.sol` as such: `import "./INFTManager.sol";`; they will be put into the appropriate directory on Gradescope when it attempts to compile your program

Some implementation notes:

- Your `supportsInterface()` function supports four interfaces (see below), and overrides the `supportsInterface()` function from two different ancestors: `ERC721` and `IERC165`.  You will need to specify, via the override keyword, that it does so: `override(IERC165,ERC721)` instead of just `override`.  This is discussed in lecture [here](../../slides/solidity.html#/multioverride).
- If you want to concatenate strings, such as when returning a value from `tokenURI()`, which must include the base URI, you can use `string.concat(s1,s2)` where `s1` and `s2` are strings.  Note that you can concatenate more than two strings via this function call via additional parameters.
- In Remix, when calling a `view` or `pure` function on a contract, which is a blue button, the return value is displayed right below the button itself.  For a transaction (orange button), you have to look at the JSON data returned to get the return value -- expand the line that is displayed in the Remix console by clicking on the down arrow, and the return value will be in the "decoded output" field.  Sometimes Remix doesn't like to display the value.  Note that the explorer will also display the return value of a transaction (although you will have to wait a minute for the explorer to refresh, and that has to be deployed to the course blockchain for the explorer to see it).
- How you decide on a NFT ID is up to you.  The most straight-forward way is to have consecutive integers, and a mapping from that NFT ID to a string.  The course NFT manager encodes the string of the filename as a (very long) `uint`.  Either one is acceptable.
- With the previous part, you had to call the `ERC20()` constructor with two parameters -- the coin name and symbol.  Similarly, you have to do so here as well -- the `ERC721()` constructor takes in two parameters.  They are the name of the NFT manager and the symbol of the NFT manager.  (I'm not sure why it has to have a symbol, so you can put in any reasonable value here).
- Be sure to use the ERC721 functions!  That is how you mint a new NFT, for example.

The following are the functional requirements for the development of this contract:

- Implementation of the two `mintWithURI()` functions
	- The one-parameter version assumes that the `address _to` is really `msg.sender` -- just have the one parameter version call the two parameter version with `msg.sender`
	- Note the string parameter is *just* the filename (such as `mst3k_foo.jpg`), not the full URI
  	- It should allow minting by *anybody*
  	- A duplicate URI should cause a reversion
  	- This *returns* the token ID of the newly minted NFT; the function itself determines what that ID is (the next integer in sequence, an encoded version of the file name, etc.)
- Implementation of the `supportsInterface()` function for *four* interfaces -- the two ERC721 interfaces (`IERC721`, `IERC721Metadata`), `IERC165`, and `INFTManager`.
    - Your contract also extends `Context` through ERC721, but there are no `external` or `public` methods in `Context`, so there is no interface there to support.
- Implementation of `tokenURI()`, which is inherited from `ERC721`
	- It should revert if an invalid token ID is provided
	- It should return the *full* URL of the file; the first part of that URL is the base URI from the Canvas landing page, and the last part of that URL is what was passed into `mintWithURI()`
	- This URL base should be hard-coded into the contract itself
	- You can override the `_baseURI()` function from `ERC721`, and use that in a similar fashion to what is shown in the `tokenURI()` function in `ERC721`
- Implementation of the `count()` function, which is just how many NFTs have been created by this contract

Make sure this works properly in Remix before proceeding onto the next step.

#### Part 2, task 5: Deployment

Before final submission of this assignment, you will need to deploy both this token manager and the auction program to our final Ethereum blockchain.  Be sure to select the appropriate contract ("NFTManager") from the Contract down-down list in Remix.  Also be sure that it's all working via Remix (in the JavaScript environment) first.

One you have thoroughly tested your NFTManager in Remix, you should deploy it to our private Ethereum blockchain.  How to do this was covered in the [dApp Introduction](../dappintro/index.html) assignment, which you may want to refer back to.  You have to deploy all the code in this assignment from the same account, and you have to tell us that account when you submit the assignment.

Save the contract address for the deployment, as you will need to submit it at the end of this assignment.

#### Part 2, task 6: Create two NFTs, and send me one

You should create two NFTs with *your* deployed contract -- they should be the two of the images that you created, above.  You need to send me one of them -- the address to transfer it to in on the Canvas landing page.  You will need to note the tokenID of the two NFTs -- the one you sent me and the one you kept for yourself -- as you will need to submit those as well.  You are welcome to create more, if you would like, as long as the images for each are unique.  But we only need two for grading.

If you look at the blockchain explorer for the account you have to send the NFT to, it will tell you that the NFT is owned by that account.  Note that if you deploy multiple contracts that use the same token NFTManager abbreviation, it will only consider the most recently deployed one -- which means if you redeploy the contract, you will have to re-send the NFT.

#### Part 2, task 7: Create one NFT on the course manager

Create one NFT for yourself on the course-wide NFT manager, whose address is on the Canvas landing page.  This should be the third of the three images you created.  Save the token ID received, and the transaction hash from that transaction, as you will need to submit those values.  The course-wide NFT manager also follows the INFTManager interface.



### Troubleshooting

Some common problems encountered, and their solutions:

- "This contract may be abstract, not implement an abstract parent's methods completely or not invoke an inherited contract's constructor correctly." -- likely this means you are trying to deploy the interface rather than the contract itself.  In Remix, in the Deploy pane, make sure the correct contract (and not an interface!) is selected in the "Contract" drop-down list.

More will be added to this list as further common problems (and their solutions) arise.

### Submission

You will need to fill in the various values from this assignment into the [tokens.py](tokens.py.html) ([src](tokens.py)) file.  That file clearly indicates all the values that need to be filled in.  That file, along with your Solidity source code, are the only files that must be submitted.  The `sanity_checks` dictionary is intended to be a checklist to ensure that you perform the various other aspects to ensure this assignment is fully submitted.


There are *five* forms of submission for this assignment; you must do all five.

Submission 1: You must deploy the two smart contracts to our private Ethereum blockchain.  It's fine if you deploy it a few times to test it.  The contract addresses of these deployments are in the `tokens.py` file that you submit.

Submission 2: You will need to upload your cryptocurrency logo (properly named!) to URLs provided on the Canvas landing page.  Note that the logo for your cryptocurrency and the NFT images are uploaded to different URLs!

Submission 3: You need to send me exactly 10.0 of your token cryptocurrency, and also one of your NFTs.  The address to send that to is on the Canvas landing page.  The transaction hashes of these go into the `tokens.py` file.

Submission 4: You need to create one NFT on the course-wide NFT manager, and two on your NFTManager.

Submission 5: You should submit your `TokenCC.sol` and `NFTManager.sol` files and your completed `tokens.py` file, and ONLY those three files, to Gradescope.  All your Solidity code should be in the first two files, and you should specifically import the necessary interfaces.  Those interface files will be placed in the same directory on Gradescope when you submit.  **NOTE:** Gradescope cannot fully test this assignment, as it does not have access to the private blockchain. So it can only do a few sanity tests (correct files submitted, successful compilation, valid values in auction.py, etc.).
