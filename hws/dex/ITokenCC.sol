// SPDX-License-Identifier: GPL-3.0-or-later

// This file is part of the http://github.com/aaronbloomfield/ccc repository,
// and is released under the GPL 3.0 license.

pragma solidity ^0.8.21;

import "./IERC165.sol";
import "./IERC20Metadata.sol";

interface ITokenCC is IERC20Metadata, IERC165 {

    // You'll need a constructor, which should call the ERC20 constructor
    // and _mint().  This sets the name and symbol, so you don't have to
    // define those methods (or public variables).

    // You have to implement the decimals() function from the IERC20Metadata
    // interface.  Because of some peculiarities of Solidity inheritance, you
    // have to implement these as actual functions, not public variables. And
    // it has to use the multi-override version of the `override` keyword, as
    // described in the slides (solidity.html#/multioverride) and the
    // homework description.

    // We will need this function in a future assignment (Arbitrage Trading),
    // which is why it is in this interface. For now, it should have a single
    // line: `revert();`.  You can make your implementation `pure` as well
    // (the compiler will warn you about that).
    function requestFunds() external;

    // You also need to implement supportsInterface(), which is required by
    // the IERC165 interface.  You support four interfaces!

    // The other methods needed by the IERC20 interface are already
    // implemented for you in the ERC20.sol contract.

}
