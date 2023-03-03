// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

library SugarcaneLib {
    // Organized this way for variable packing
    struct Action {
        string[] variables;
        uint256 chainId;
        address functionSignature;
    }

    struct ChainAddressPair {
        uint256 chainId;
        address chainAddress;
    }

    struct Investment {
        uint256 chainId;
        uint256 protocolId;
        uint256 initialAmountUsd;
        bool isActive;
    }
}
