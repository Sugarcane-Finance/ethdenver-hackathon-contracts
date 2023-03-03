// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

// Connected parts of the system
import "../../code/libs/SugarcaneLib.sol";

import "./ISugarcaneManagerBase.sol";

//  The manager on the canonical chain
interface ISugarcaneManagerPrimary is ISugarcaneManagerBase {
    // // // // // // // // // // // // // // // // // // // //
    // EVENTS
    // // // // // // // // // // // // // // // // // // // //
    // // // // // // // // // // // // // // // // // // // //
    // GETTERS
    // // // // // // // // // // // // // // // // // // // //
    /*
    [READ] – executeOnboardReceiver() returns address
    Returns the execute onboard receiver address
    */
    // // // // // // // // // // // // // // // // // // // //
    // CORE FUNCTIONS
    // // // // // // // // // // // // // // // // // // // //
    /*
    [WRITE] – addToUserControlledAddress(uint256 chainId_, address userAddress_)
    This is a function only the Sugarcane_Onboard_Execute_Receiver_Primary contract can change it is 

    [WRITE] – crossChainOnboardUserInitiate(uint256 chainId_, address userAddress_)
    Does checks on valid chain name and talks to Axelar gateway to create on the other chain

    [WRITE] – onboardUser(address userAddress_)
    Does checks for valid request and talks to Sugarcane_Factory to create Holdings address on Base

    [WRITE] – setExecuteOnboardReceiver(address receiverExecuteAddress_)
    Updates the valid address of the Sugarcane_Onboard_Execute_Receiver_Primary contract
    */
}
