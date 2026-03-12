// SPDX-License-Identifier: GPL-3.0-or-later

/* Debug.sol
 *
 * This library has various functions used for debugging.  By calling the various debug*() 
 * functions, an event is fired, and the blockchain explorer will display the parameters 
 * for that event.  Thus, one can use it as a stand-in for a print statement.
 */

pragma solidity ^0.8.33;

library Debug {

    // These functions will emit the event with the same argument type
    function debugUint(uint s) public            { emit debugEventUint(s);    }
    function debugInt(int s) public              { emit debugEventInt(s);     }
    function debugAddress(address s) public      { emit debugEventAddress(s); }
    function debugBytes32(bytes32 s) public      { emit debugEventBytes32(s); }
    function debugString(string memory s) public { emit debugEventString(bytesToBytes32(bytes(s))); }


    // These are the events that are fired from the above debug functions
    event debugEventString(bytes32 indexed s);
    event debugEventBytes32(bytes32 indexed b);
    event debugEventUint(uint indexed u);
    event debugEventInt(int indexed i);
    event debugEventAddress(address indexed a);

    // Internal utility function to convert an array of bytes1 into a bytes32 value
    function arrayToBytes32(bytes1[32] memory arr) internal pure returns (bytes32 result) {
        for (uint i = 0; i < 32; i++)
            result |= bytes32(arr[i]) >> (i * 8);
    }

    // Internal utility function to convert a variable-sized bytes into bytes32; only the first 32 characters 
    // are converted, and it is right-padded with 0 bytes if the parameter is less than 32 bytes in size
    function bytesToBytes32(bytes memory data) internal pure returns (bytes32 result) {
        bytes1[32] memory a;
        for ( uint i = 0; i < data.length; i++ )
            a[i] = data[i];
        for ( uint i = data.length; i < 32; i++ )
            a[i] = 0;
        return arrayToBytes32(a);
    }
}
