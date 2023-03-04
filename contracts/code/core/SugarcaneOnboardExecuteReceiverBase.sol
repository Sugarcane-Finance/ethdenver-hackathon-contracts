// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

// Local imports
import "../libs/SugarcaneLib.sol";

// Interface imports
import "../../interfaces/core/ISugarcaneOnboardExecuteReceiverBase.sol";
import "../utils/ManagerUtil.sol";

abstract contract SugarcaneOnboardExecuteReceiverBase is
    ManagerUtil,
    ISugarcaneOnboardExecuteReceiverBase
{
    // // // // // // // // // // // // // // // // // // // //
    // LIBRARIES AND STRUCTS
    // // // // // // // // // // // // // // // // // // // //

    // // // // // // // // // // // // // // // // // // // //
    // VARIABLES - REMEMBER TO UPDATE __gap
    // // // // // // // // // // // // // // // // // // // //

    // // // // // // // // // // // // // // // // // // // //
    // CONSTRUCTOR
    // // // // // // // // // // // // // // // // // // // //

    function __SugarcaneOnboardExecuteReceiverBase_init(address managerAddress_)
        internal
        initializer
    {
        __ManagerUtil_init(managerAddress_);
    }

    // // // // // // // // // // // // // // // // // // // //
    // MODIFIERS
    // // // // // // // // // // // // // // // // // // // //

    // // // // // // // // // // // // // // // // // // // //
    // GETTERS
    // // // // // // // // // // // // // // // // // // // //

    // // // // // // // // // // // // // // // // // // // //
    // CORE FUNCTIONS
    // // // // // // // // // // // // // // // // // // // //

    // // // // // // // // // // // // // // // // // // // //
    // GAP
    // // // // // // // // // // // // // // // // // // // //

    // Gap for more space
    uint256[50] private __gap;
}
