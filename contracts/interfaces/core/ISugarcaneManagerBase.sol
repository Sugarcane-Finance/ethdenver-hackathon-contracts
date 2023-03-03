// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

// Connected parts of the engine
import "../../code/libs/SugarcaneLib.sol";

//  Abstract class that the managers on primary and secondary chains will inherit
interface ISugarcaneManagerBase {
    // // // // // // // // // // // // // // // // // // // //
    // EVENTS
    // // // // // // // // // // // // // // // // // // // //
    // // // // // // // // // // // // // // // // // // // //
    // GETTERS
    // // // // // // // // // // // // // // // // // // // //
    /*
    [READ] – bridgeGateway() returns address
    Returns the cross-chain communication gateway

    [READ] – factory() returns address
    Returns the Sugarcane factory address

    [READ] – gasReceiver() returns address
    Returns the cross-chain gas payment location 

    [READ] – hasOnboarded(address userAddress_) returns bool
    Tells if the user has onboarded

    [READ] – onboarder() returns address
    Returns the address that can make it onboard users (on Base this is the Base relayer, on Goerli it is the defender address, and on the other chains it is their Sugarcane_Onboard_Executor)
    */
    // // // // // // // // // // // // // // // // // // // //
    // CORE FUNCTIONS
    // // // // // // // // // // // // // // // // // // // //
    /*
    [WRITE] – setFactory(address factoryAddress_)
    Updates the factory contract location 

    [WRITE] – setBridgeGateway(address gatewayAddress_)
    Updates the cross-chain communication gateway

    [WRITE] – setOnboarder(address onboarderAddress_)
    Updates the valid onboarding address contract 
    */
}
