# Submission information for the DAO & Web3 HW
# https://aaronbloomfield.github.io/ccc/hws/daoweb3/

# The filename of this file must be 'dex.py', else the submission
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

	# Your deployed DAO contract.  All of the other information in this file
	# is assumed to be from this contract.  The address does not need to be
	# in checksummed form.  It must have been deployed by the eth_coinbase
	# address, above.
	'dao': '',

}


# This dictionary contains various information that will vary depending on the
# assignment.
other = {
	
	# The transaction hash where you voted on one of the course-wide DAO
	# proposals.  It doesn't matter which one you voted for or how you voted.
	'dao_vote_txn': None,

}


# These are various sanity checks, and are meant to help you ensure that you
# submitted everything that you are supposed to submit.  Other than
# submitting the necessary files to Gradescope (which checks for those
# files), all other submission requirements are listed herein.  These values 
# need to be changed to True (instead of None).
sanity_checks = {
	
	# Did you add the three required proposals to your DAO?  One should have
	# expired, one expires week after the due date, and one is your choice.
	'added_three_required_dao_proposals': False,

	# Did you make the isntructor account a member of your DAO?  The account
	# address in on the Collab landing page.
	'made_instructor_dao_member': False,

	# Is the URL of your dao.html exactly:
	# https://www.cs.virginia.edu/~mst3k/dao.html, where 'mst3k' is your
	# userid?
	'dao_url_is_correct': False,

	# Does your dao.html web page specifically load up the information
	# on *your* DAO, and the latest version (that has the three proposals
	# mentioned above?)
	'dao_contract_addr_is_correct': False,

	# Did you join the course-wide DAO and vote on one of the proposals?
	'voted_on_course_dao': False,

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
