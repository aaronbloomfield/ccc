// SPDX-License-Identifier: GPL-3.0-or-later

// This file is part of the http://github.com/aaronbloomfield/ccc repository,
// and is released under the GPL 3.0 license.

pragma solidity ^0.8.21;

import "./IEtherPriceOracle.sol";

contract EtherPriceOracleConstant is IEtherPriceOracle {

    string public constant name = "A constant EtherPrice oracle that always returns $100.00";

    string public constant symbol = "$";

    uint public constant decimals = 2;

    function supportsInterface(bytes4 interfaceId) external pure override returns (bool) {
        return interfaceId == type(IEtherPriceOracle).interfaceId || interfaceId == type(IERC165).interfaceId;
    }

    uint public constant price = 10000; // in cents

}