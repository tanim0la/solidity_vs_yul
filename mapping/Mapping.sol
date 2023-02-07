//SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.15;

contract SolMapping {
    mapping(uint256 => uint256) num;

    // Gas cost - 44103
    function setMappingValue(uint256 key, uint256 value) external {
        /*
            Assigning `value` to storage variable (num) at positon `key`.
        */
        num[key] = value;
    }

    // Gas cost - 23950
    function getMappingValue(uint256 key1) external view returns (uint256) {
        /*
            Returning the value assigned to storage variable (num) at positon `key`.
        */
        return num[key1];
    }
}

contract YulMapping {
    mapping(uint256 => uint256) num;

    // Gas cost - 44089
    function setMappingValue(uint256 key, uint256 value) external {
        assembly {
            /* 
                Storing `key` and `slot number of num` in memory location `0x80` and `0xa0`
                respectively.
            */
            mstore(0x80, key)
            mstore(0xa0, num.slot)

            /*
                keccak256(0x80, 0x40) returns the hash of `key` and `slot`.
                sstore stores the `value` in the Keccak-256 hash which is a storage location.
            */
            sstore(keccak256(0x80, 0x40), value)
        }
    }

    // Gas cost - 23753
    function getMappingValue(uint256 key1) external view returns (uint256) {
        assembly {
            /* 
                Storing `key1` and `slot number of num` in memory location `0x80` and `0xa0`
                respectively.
            */
            mstore(0x80, key1)
            mstore(0xa0, num.slot)

            /*
                Loads from storage, the value stored in the Keccak-256 hash and store it in memory
                location `returndatasize()` which is `0x00`, since no external call was made. 
            */
            mstore(returndatasize(), sload(keccak256(0x80, 0x40)))

            /*
                Returns the value stored in memory location `returndatasize()` which is `0x00`
                to `0x00 + 0x20`
            */
            return(returndatasize(), 0x20)
        }
    }
}
