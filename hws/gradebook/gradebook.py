# Submission information for the dApp Gradebook HW
# https://aaronbloomfield.github.io/ccc/hws/gradebook/

# The filename of this file must be 'gradebook.py', else the submission
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

	# The Gradebook contract.  The address does not need to be in checksummed
	# form.  It must have been deployed by the eth_coinbase address, above.
	'gradebook': '',

}


# This dictionary contains various information that will vary depending on the
# assignment.
other = {
	
	# What is your (fake) average in the course gradebook?  This should be a
	# number out of 100 with decimals.
	'your_fake_avg': None,

	# The maximum number of points on the assignment with index 3 in the
	# course-wide gradebook; see the assignment write-up for details.
	'max_points_on_3': None,

	# Your score on the assignment with index 3 in the course-wide gradebook;
	# see the assignment write-up for details.
	'your_score_on_3': None,

}


# These are various sanity checks, and are meant to help you ensure that you
# submitted everything that you are supposed to submit.  Other than
# submitting the necessary files to Gradescope (which checks for those
# files), all other submission requirements are listed herein.  These values
# need to be changed to True (instead of None).
sanity_checks = {
	
	# Did you properly deploy your gradebook contract to the blockchain?
	'deployed_gradebook': False,

	# Can we allow ourselves to be a TA via the `requestTAAccess()` function?
	# If not, we will be unable to grade any of the assignment, and you'll
	# receive a 0.
	'requestTAAccess_works': False,

	# Did you make NO OTHER CALLS to your deployed Gradebook contract (the one
	# whose address is above)?
	'made_no_other_calls': False,

	# Does your constructor have only one line that states `instructor = msg.sender;`?  
	# In particular, if you added any other lines for testing, you should
	# remove those.
	'constructor_has_one_line': False,

	# Does your `supportsInterface()` function return true for two values?  In
	# particular, it should be exactly as specified in the homework.
	'supportsInterface_is_correct': False,

	# Is your gradebook contract opening line *exactly:*
	# `contract Gradebook is IGradebook {`?
	'contract_opening_line_is_correct': False,
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
