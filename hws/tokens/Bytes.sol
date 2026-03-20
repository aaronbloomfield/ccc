// SPDX-License-Identifier: GPL-3.0-or-later

/*
 * Bytes.sol
 *
 * The actual Bytes.sol is found at 
 * https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Bytes.sol
 *
 * However, that version uses the mcopy assembly instruction, and that is not
 * compatible with the London EVM version.  The only Bytes function used in
 * the files needed for this assignment is the equals() function, which is 
 * reproduced below.
 */

pragma solidity ^0.8.33;

library Bytes {

    function equal(bytes memory a, bytes memory b) internal pure returns (bool) {
        // The original had this one line:
        return a.length == b.length && keccak256(a) == keccak256(b);
    }

}
