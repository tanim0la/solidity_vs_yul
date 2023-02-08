// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract SolEth {
    // 31244
    function sendEth(address addy) external payable {
        payable(addy).transfer(msg.value);
    }
}

contract YulEth {
    // 31162
    function sendEth(address addy) external payable {
        assembly {
            let success := call(gas(), addy, callvalue(), 0, 0, 0, 0)
        }
    }
}
