// SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.7;

import "./IERC165.sol";
import "./IERC20.sol";

interface ITokenCC is IERC165 {

	// This can just be implemented as a public variable, which will cause
	// Solidity to provide a getter function, and you should also make it
	// constant.
    function name() external view returns (string memory);

	// This can just be implemented as a public variable, which will cause
	// Solidity to provide a getter function, and you should also make it
	// constant.
    function symbol() external view returns (string memory);

	// This can just be implemented as a public variable, which will cause
	// Solidity to provide a getter function, and you should also make it
	// constant.
    function decimals() external view returns (uint8);

    // We will need this function in a future assignment (Arbitrage Trading),
    // which is why it is in this interface. For now, it should have a single
    // line: `revert();`.  You can make your implementation `pure` as well
    // (the compiler will warn you about that).
    function requestFunds() external;

    // You also need to implement supportsInterface(), which is required by
    // the IERC165 interface.

    // The other methods needed by the IERC20 interface are already
    // implemented for you in the ERC20.sol contract.

}
