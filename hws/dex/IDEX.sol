// SPDX-License-Identifier: GPL-3.0-or-later

// This file is part of the http://github.com/aaronbloomfield/ccc repoistory,
// and is released under the GPL 3.0 license.

pragma solidity ^0.8.16;

import "./IERC165.sol";
import "./EtherPricer.sol";

interface IDEX is IERC165 {

	//------------------------------------------------------------
	// Events

	// This event must be emitted whenever the amount of liquidity
	// (either ether or token cryptocurrency) changes.  This is from the
	// methods: createPool(), addLiquidity(), removeLiquidity()
	// exchangeEtherForToken(), and exchangeTokenForEther().
	event liquidityChangeEvent();

	//------------------------------------------------------------
	// Getting the exchange rates and prices

	// How many decimals the token is shown to; this is from the ERC-20 token
	// manager itself.
	function tokenDecimals() external view returns (uint);

	// Get the price of 1 ETH using the EtherPricer contract; return it in
	// cents.  This just gets the price from the EtherPricer contract.
	function getEtherPrice() external view returns (uint);

	// Get the price of 1 Token using the EtherPricer contract; return it in
	// cents.  This gets the price of ETH from the EtherPricer contract, and
	// then scales it -- based on the exchange ratio -- to determine the
	// price of the token cryptocurrency.
	function getTokenPrice() external view returns (uint);

	//------------------------------------------------------------
	// Getting the liquidity of the pool or part thereof

	// Get the k value.  If 100 ETH were added along with 1,000 of the token
	// cryptocurrency, and the former has 18 decimals and the latter 10
	// decimals, then this will return 10^33.  This can just be a public
	// variable.
	function k() external view returns (uint);

	// How much ether is in the pool; this can just be a public variable. This
	// is with all the decimal places, so 1.5 ETH -- which has 18 decimals --
	// would be 1,500,000,000,000,000,000.  This can just be a public variable.
	function etherLiquidity() external view returns (uint);

	// How many tokens are in the pool; this can just be a public variable. As
	// with the previous, this is returned with all the decimals.  So 15 of
	// the token cryptocurrency coin, which has (say) 10 decimals, this would
	// return 15,000,000,000.  This can just be a public variable.
	function tokenLiquidity() external view returns (uint);

	// Get the amount of pool liquidity in USD (actually cents) using the
	// EtherPricer contract.  We assume that the ETH and the token
	// cryptocurrency have the same value, and we know (from the EtherPricer
	// smart contract) how much the ETH is worth.  This can just be a public
	// variable.
	function getPoolLiquidityInUSDCents() external view returns (uint);

	// How much ETH does the address have in the pool.  This is the number in
	// wei.  This can be just be a public mapping variable.
	function etherLiquidityForAddress(address who) external returns (uint);

	// How much of the token cryptocurrency does the address have in the pool.
	// This is with however many decimals the token cryptocurrency has.  This
	// can be just be a public mapping variable.
	function tokenLiquidityForAddress(address who) external returns (uint);

	//------------------------------------------------------------
	// Pool creation

	// This can be called exactly once, and creates the pool; only the
	// deployer of the contract call this.  Some amount of ETH is passed in
	// along with this call.  For purposes of this assignment, the ratio is
	// then defined based on the amount of ETH paid with this call and the
	// amount of the token cryptocurrency stated in the first parameter.  The
	// first parameter is how many of the token cryptocurrency (with all the
	// decimals) to add to the pool; the ERC-20 contract that manages that
	// token cryptocurrency is the fourth parameter (the caller needs to
	// approve this contract for that much of the token cryptocurrency before
	// the call).  The second and third parameters define the fraction --
	// 0.1% would be 1 and 1000, for example.  The last parameter is the
	// contract address of the EtherPricer contract being used, and can be
	// updated later via the setEtherPricer() function.
	function createPool(uint _tokenAmount, uint _feeNumerator, uint _feeDenominator, 
						address _erc20token, address _etherpricer) external payable;

	//------------------------------------------------------------
	// Fees

	// Get the numerator of the fee fraction; this can just be a public
	// variable.
	function feeNumerator() external view returns (uint);

	// Get the denominator of the fee fraction; this can just be a public
	// variable.
	function feeDenominator() external view returns (uint);

	// Get the amount of ether fees accumulated (for all addresses) so far;
	// this can just be a public variable.
	function feesEther() external view returns (uint);

	// Get the amount of token fees accumulated (for all addresses) so far;
	// this can just be a public variable.
	function feesToken() external view returns (uint);

	//------------------------------------------------------------
	// Managing pool liquidity

	// Anybody can add liquidity to the pool.  The amount of ETH is paid along
	// with the function call.  The caller will have to approve the
	// appropriate amount of token cryptocurrency, via the ERC-20 contract,
	// for this call to complete successfully.  Note that this function does
	// NOT remove any fees.
	function addLiquidity() external payable;

	// Remove liquidity -- both ether and token -- from the pool.  The ETH is
	// paid to the caller, and the token cryptocurrency is transfered back as
	// well.  If the parameter amount is more than the amount the address has
	// stored in the pool, this should revert.  See the homework description
	// for how fees are managed and paid out, but note that this function
	// does NOT remove any fees.
	function removeLiquidity(uint amountEther) external;

	//------------------------------------------------------------
	// Exchanging currencies

	// Swaps ether for token.  The amount of ETH is passed in as payment along
	// with this call.
	function exchangeEtherForToken() external payable;

	// Swap token for ether.  The ERC-20 smart contract for the token
	// cryptocurrency must be approved to transfer that much into the DEX,
	// and the appropriate amount of ETH is paid back to the caller.
	function exchangeTokenForEther(uint amountToken) external;

	//------------------------------------------------------------
	// Functions for debugging and grading

	// This function allows changing of the contract that provides the current
	// ether price.
	function setEtherPricer(address p) external;

	// This gets the address of the etherPricer being used so that we can
	// verify we are using the correct one; this can just be a public variable.
	function etherPricerAddress() external returns (address);

	// Get the address of the ERC-20 token manager being used for the token
	// cryptocurrency; this can just be a public variable.
	function erc20TokenAddress() external returns (address);

	// Get the abbreviation of the ERC-20 cryptocurrency; this can just call
	// the ERC-20 contract to get that information.
	function getTokenCCAbbreviation() external returns (string memory);

	//------------------------------------------------------------
	// Functions for efficiency

	// this function is just to lower the number of calls to the contract from
	// the web page; it just returns the information in many of the above
	// calls as a single call.  The information it returns is a tuple and is,
	// in order:
	//
	// 0: the address of *this* DEX contract
	// 1: token cryptocurrency abbreviation (string memory)
	// 2: token cryptocurrnecy name (string memory)
	// 3: ERC-20 token cryptocurrency address (address)
	// 4: k (uint)
	// 5: ether liquidity (uint)
	// 6: token liquidity (uint)
	// 7: fee numerator (uint)
	// 8: fee denominator (uint)
	// 9: token decimals (uint)
	// 10: fees collected in ether (uint)
	// 11: fees collected in the token CC (uint)
	function getDEXinfo() external returns (address, string memory, string memory, 
							address, uint, uint, uint, uint, uint, uint, uint, uint);

	//------------------------------------------------------------
	// Inherited functions

	// From IERC165.sol:
	// function supportsInterface(bytes4 interfaceId) external view returns (bool);

}
