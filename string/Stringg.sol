// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract SolString {
    // 715
    function stringg() external pure returns (string memory) {
        return "Ghost of Uchiha";
    }
}

contract YulString {
    // 140
    function stringg() external pure returns (string memory) {
        assembly {
            // Seaport's method of returning a string

            // Store the offset `0x20` in mem postion `0x00`
            mstore(0x00, 0x20)

            // Add the len of the string (15 or 0xF) to the next mem location (0x20) which is `0x2f`.
            // Concatenate the len of string `0xF` and the string in hex `0x47686F7374206F6620556368696861`
            // which is `0xF47686F7374206F6620556368696861` and store in `0xf`
            mstore(0x2f, 0xF47686F7374206F6620556368696861)

            // Return from offset `0x00` to offset+size `0x00+0x60`
            return(0x00, 0x60)
        }
    }
}
