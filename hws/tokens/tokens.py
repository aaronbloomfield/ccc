# Submission information for the Ethereum Tokens HW
# https://aaronbloomfield.github.io/ccc/hws/tokens/

# The filename of this file must be 'tokens.py', else the submission
# verification routines will not work properly.

# You are welcome to have additional variables or fields in this file; you
# just cant remove variables or fields.


# Who are you?  Name and UVA userid.  The name can be in any human-readable format.
userid = "mst3k"
name = "Jane Doe"


# eth.coinbase: this is the account that you deployed the smart contracts
# (and performed any necessary transactions) for this assignment.  Be sure to
# include the leading '0x' in the address.
eth_coinbase = ""


# This dictionary contains the contract addresses of the various contracts
# that need to be deployed for this assignment.  The addresses do not need to
# be in checksummed form.  The contracts do, however, need to be deployed by
# the eth_coinbase address, above.  Be sure to include the leading '0x' in
# the address.
contracts = {

	# The Token cryptocurrency (aka ERC-20) contract.  All of the token
	# cryptocurrencty transactions below are assumed to come from this
	# contract. The address does not need to be in checksummed form.  It must
	# have been deployed by the eth_coinbase address, above.
	'token_cc': '',

	# The NFT Manager (aka ERC-721) contract.  All of the minted NFTs, below,
	# are assumed to come from this contract.  The address does not need to
	# be in checksummed form.  It must have been deployed by the eth_coinbase
	# address, above.
	'nft_manager': '',
}


# This dictionary contains various information that will vary depending on the
# assignment.
other = {
	
	# This is the name of your cryptocurrency.  Be creative!  But don't use
	# something that will get me in trouble.
	'cryptocurrency_name': None,

	# The abbreviation for your cryptocurrency: at most 4 letters.  And be
	# sure it is not already used (see the assignment for how to verify this).
	'cryptocurrency_abbrev': None,

	# The transaction hash where you sent me some of your cryptocurrency.  It
	# must have been done by eth_coinbase, above.
	'cc_sent_txn_hash': None,

	# The NFT ID that you sent me.  This is from the nft_manager contract, above.
	'nft_id_sent': None,

}


# These are various sanity checks, and are meant to help you ensure that you
# submitted everything that you are supposed to submit.  Other than
# submitting the necessary files to Gradescope (which checks for those
# files), all other submission requirements are listed herein.  These values
# need to be changed to True (instead of None).
sanity_checks = {
	
	# Is your cryptocurrency logo image correct?  It should be 512x512, a .png
	# file, generally circular in appearance, and with a transparent
	# background (these requirements match the template that was provided).
	'cc_logo_image_is_correct': False,

	# Is your cc logo named properly?  It should be 'abcd.png', where 'abcd'
	# is your cryptocurrency abbreviation.  The file name should be all lower
	# case.
	'cc_logo_name_is_correct': False,

	# Did you upload your cryptocurrency logo to the 'cclogos/' directory?
	'uploaded_cc_logo': False,

	# Did you mint at least 50 coins of your TokenCC?  Keep in mind that you
	# have to add a number of decimal places after the number of coins.
	'minted_at_least_50_coins': False,

	# Did you send me exactly 10.0 of your token cryptocurrencty?  If your
	# token cryptocurrency uses 8 decimals, then that will be 1,000,000,000
	# total units sent.
	'sent_ten_tc': False,

	# Can anybody mint an NFT?  Just make sure you don't require() that the
	# minter is the deployer, for example.
	'anybody_can_mint_nft': False,

	# Did you upload three NFT images?  They must be either .jpg, .png,
	# or .webp images.
	'uploaded_three_nft_images': False,

	# Are the NFT images no larger than 2000x2000?
	'nft_image_sizes_correct': False,

	# Did you name the images correctly?  The names should start with your
	# userid followed by a underscore, and have the appropriate image
	# extension.  All filenames must be strictly less than 32 characters in
	# length. stay open for ONE WEEK after the assignment due date/time?
	'image_files_named_correctly': False,

	# Did you send me one of your NFTs?  Which one was specified in
	# the 'nft_id_sent' field in the 'other' dictionary, above.
	'sent_nft': False,

}


# While some of these are optional, you still have to replace those optional
# ones with the empty string (rather than None).
comments = {

	# How long did this assignment take, in hours?  Please format as an
	# integer or float.
	'time_taken': None,

	# Any suggestions for how to improve this assignment?  This part is
	# completely optional.  If none, then you can have the value here be the
	# empty string (but not None).
	'suggestions': None,

	# Any other comments or feedback?  This part is completely optional. If
	# none, then you can have the value here be the empty string (but not
	# None).
	'comments': None,
}