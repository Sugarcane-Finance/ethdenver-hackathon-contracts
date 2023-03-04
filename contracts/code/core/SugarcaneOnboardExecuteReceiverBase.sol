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
    /*
    [READ] – _execute(
        string calldata sourceChain,
        string calldata sourceAddress,
        bytes calldata payload
    )
    Talks to the Sugarcane manager that is on this chain to run 

    [READ] – getManager() returns address
    Returns the manager address
    */

    // // // // // // // // // // // // // // // // // // // //
    // CORE FUNCTIONS
    // // // // // // // // // // // // // // // // // // // //

    // // // // // // // // // // // // // // // // // // // //
    // GAP
    // // // // // // // // // // // // // // // // // // // //

    // Gap for more space
    uint256[50] private __gap;
}
