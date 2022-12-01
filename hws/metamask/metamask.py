# Submission information for the Metamask HW
# https://aaronbloomfield.github.io/ccc/hws/metamask/

# The filename of this file must be 'metamask.py', else the submission
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

	# Your Auctioneer smart contract.  All of the transactions below are
	# assumed to come from this contract. The address does not need to be in
	# checksummed form.  It must have been deployed by the eth_coinbase
	# address, above.  This can be re-deployed for this assignment, or the
	# same one as for your auctions assignment.
	'auctioneer': '',

	# We do not need the contract address of your NFTManager, as we can call
	# the `nftmanager()` function on your Auctioneer contract to get that.

}


# This dictionary contains various information that will vary depending on the
# assignment.
other = {
	
	# nothing is required in this dictionary for this assignment

}


# These are various sanity checks, and are meant to help you ensure that you
# submitted everything that you are supposed to submit.  Other than
# submitting the necessary files to Gradescope (which checks for those
# files), all other submission requirements are listed herein.  These values
# need to be changed to True (instead of False).
sanity_checks = {
	
	# Is the URL of your metamask.html exactly:
	# https://www.cs.virginia.edu/~mst3k/metamask.html
	# where 'mst3k' is your userid?
	'auctions_url_is_correct': False,

	# Did you add three auctions to your metamask.html page?  There is no
	# requirement for the start/end dates/times for these.  They should be
	# for your three NFTs that you created in the Tokens assignment.
	'added_three_auctions': False,

	# Can somebody ELSE mint an NFT and start / bid on / close an auction?  If
	# we can't do that, then we won't be able to grade it. 
	'somebody_else_can_mint': False,

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
