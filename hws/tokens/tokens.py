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

	# The NFT Manager (aka ERC-721) contract.  Two of the minted NFTs, below,
	# are assumed to come from this contract (the third comes from the
	# course-wide contract).  The address does not need to be in checksummed
	# form.  It must have been deployed by the eth_coinbase address, above.
	'nft_manager': '',
}


# This dictionary contains various information that will vary depending on the
# assignment.
other = {
	
	# TokenCC fields

	# This is the name of your cryptocurrency.  Be creative!  But don't use
	# something that will get me in trouble.  This can have any printable
	# ASCII character (no emojis) and spaces.
	'cryptocurrency_name': None,

	# The abbreviation for your cryptocurrency: at most 4 letters.  And be
	# sure it is not already used (see the assignment for how to verify this).
	'cryptocurrency_abbrev': None,

	# The transaction hash where you sent me 10.0 of your cryptocurrency.  It
	# must have been done by eth_coinbase, above.  And it must have used your
	# deployed TokenCC contract, above.
	'cc_sent_txn_hash': None,

	# NFTManager fields

	# The NFT ID that you created from YOUR NFTManager (the nft_manager
	# contract, above) and kept (meaning you did not send to the course
	# instructor).  It must have been done by eth_coinbase, above.
	'nft_id_kept': None,

	# The NFT ID that you sent to the course instructor from YOUR NFTManager
	# (the nft_manager contract, above).  It must have been done by
	# eth_coinbase, above.
	'nft_id_sent': None,

	# The transaction hash where you sent me an NFT from YOUR NFTManager
	# (the nft_manager contract, above).  It must have been done by
	# eth_coinbase, above.  And it must have used your deployed NFTManager
	# contract, above.
	'nft_sent_txn_hash': None,

	# The NFT ID from when you created an NFT on the course-wide NFT manager.
	# It must have been done by eth_coinbase, above.
	'course_nft_id': None,

	# The transaction hash from when you created an NFT on the course-wide NFT
	# manager.  It must have been done by eth_coinbase, above.
	'course_nft_txn_hash': None,

	# Did you use generative AI when creating your cryptocurrency logo?  It's
	# fine if you did -- you were allowed to do so -- we just wanted to know
	# how many people did or did not.  This should be either True or False.
	'used_gen_ai_for_cclogo': None,

	# Did you use generative AI when creating any (or all) of your NFTs?  It's
	# fine if you did -- you were allowed to do so -- we just wanted to know
	# how many people did or did not.  This should be either True or False.
	'used_gen_ai_for_nfts': None,

	# If you did use a generative AI tool, which one did you use?  If you
	# didn't, you can have this be an empty string.
	'which_gen_ai_tool_used': None,
}


# These are various sanity checks, and are meant to help you ensure that you
# submitted everything that you are supposed to submit.  Other than
# submitting the necessary files to Gradescope (which checks for those
# files), all other submission requirements are listed herein.  These values
# need to be changed to True (instead of False).
sanity_checks = {
	
	# TokenCC sanity checks

	# Is your cryptocurrency logo image correct?  It should be 512x512, a .png
	# file, generally circular in appearance, and with a transparent
	# background outside the coin, and a non-white background in the circle
	# of the coin (these requirements match the template that was provided,
	# other than the non-white background).
	'cc_logo_image_is_correct': False,

	# Is your cc logo named properly?  It should be 'abcd.png', where 'abcd'
	# is your cryptocurrency abbreviation.  The file name should be all lower
	# case.
	'cc_logo_name_is_correct': False,

	# Did you upload your cryptocurrency logo to the 'cclogos/' directory?
	'uploaded_cc_logo': False,

	# Did you mint at least 100 coins of your TokenCC?  Keep in mind that you
	# have to add a number of decimal places after the number of coins minted.
	'minted_at_least_100_coins': False,

	# Did you send me exactly 10.0 of your token cryptocurrencty?  If your
	# token cryptocurrency uses 8 decimals, then that will be 1,000,000,000
	# total units sent.
	'sent_ten_tc': False,

	# Does your `supportsInterface()` function in TokenCC return true for the
	# four interfaces?
	'tokencc_supportsInterface_is_correct': False,

	# Is your TokenCC contract opening line *exactly:*
	# `contract TokenCC is ITokenCC, ERC20 {`?
	'tokencc_opening_line_is_correct': False,

	# NFTManager sanity checks

	# Did you upload three NFT images?  They must be either .jpg, .png,
	# or .webp images.
	'uploaded_three_nft_images': False,

	# Are all three NFT images no larger than 2000x2000?
	'nft_image_sizes_correct': False,

	# Did you name the images correctly?  The names should start with your
	# userid followed by a underscore, and have the appropriate image
	# extension.  All filenames must be strictly less than or equal to 32
	# characters in length.
	'image_files_named_correctly': False,

	# Can anybody mint an NFT?  Just make sure you don't require() that the
	# minter is the deployer, for example.
	'anybody_can_mint_nft': False,

	# Did you create two NFTs on *your* NFTManager?
	'created_two_nfts_on_own': False,

	# Did you send me one of your NFTs?  Which one was specified in
	# the 'nft_id_sent' field in the 'other' dictionary, above.
	'sent_nft': False,

	# Does your `supportsInterface()` function in NFTManager return true for
	# the four interfaces?
	'nftmanager_supportsInterface_is_correct': False,

	# Is your NFTManager contract opening line *exactly:*
	# `contract NFTManager is INFTManager, ERC721 {`?
	'nftmanager_opening_line_is_correct': False,

	# Did you create a NFT on the course-wide NFT manager?  The NFT ID for
	# this was put into the other['course_nft_id'] field, above.
	'created_course_nft': False,

}


# While some of these are optional, you still have to replace those optional
# ones with the empty string (instead of None).
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
