// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

// Libraries
import {IAxelarGasService} from "@axelar-network/axelar-gmp-sdk-solidity/contracts/interfaces/IAxelarGasService.sol";
import {IAxelarGateway} from "@axelar-network/axelar-gmp-sdk-solidity/contracts/interfaces/IAxelarGateway.sol";

// Local imports
import "../libs/SugarcaneLib.sol";

// Interface imports
import "../../interfaces/core/ISugarcaneManagerBase.sol";
import "../utils/SugarcaneCore.sol";

//  Abstract class that the managers on primary and secondary chains will inherit
abstract contract SugarcaneManagerBase is SugarcaneCore, ISugarcaneManagerBase {
    // // // // // // // // // // // // // // // // // // // //
    // LIBRARIES AND STRUCTS
    // // // // // // // // // // // // // // // // // // // //

    // // // // // // // // // // // // // // // // // // // //
    // VARIABLES - REMEMBER TO UPDATE __gap
    // // // // // // // // // // // // // // // // // // // //
    IAxelarGateway internal _gateway;
    IAxelarGasService internal _gasService;

    // // // // // // // // // // // // // // // // // // // //
    // CONSTRUCTOR
    // // // // // // // // // // // // // // // // // // // //
    function __SugarcaneManagerBase_init(address gateway_, address gasService_)
        internal
        initializer
    {
        __SugarcaneCore_init();

        _gateway = IAxelarGateway(gateway_);
        _gasService = IAxelarGasService(gasService_);
    }

    // // // // // // // // // // // // // // // // // // // //
    // MODIFIERS
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

    // // // // // // // // // // // // // // // // // // // //
    // GAP
    // // // // // // // // // // // // // // // // // // // //

    // Gap for more space
    uint256[48] private __gap;
}
