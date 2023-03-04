// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

// Connected parts of the system
import "../../code/libs/SugarcaneLib.sol";
import "../utils/ISugarcaneCore.sol";

//  Abstract class that the managers on primary and secondary chains will inherit
interface ISugarcaneManagerBase is ISugarcaneCore {
    // // // // // // // // // // // // // // // // // // // //
    // EVENTS
    // // // // // // // // // // // // // // // // // // // //

    /**
     * @notice Emitted when the gas service address is updated
     * @param admin The admin that made the update
     * @param chainId The chain id of the chain this is deployed on
     * @param oldGasService The old gas service address
     * @param newGasService The new gas service address
     */
    event GasServiceUpdated(
        address indexed admin,
        uint256 chainId,
        address indexed oldGasService,
        address indexed newGasService
    );

    /**
     * @notice Emitted when the gateway address is updated
     * @param admin The admin that made the update
     * @param chainId The chain id of the chain this is deployed on
     * @param oldGateway The old gateway address
     * @param newGateway The new gateway address
     */
    event GatewayUpdated(
        address indexed admin,
        uint256 chainId,
        address indexed oldGateway,
        address indexed newGateway
    );

    /**
     * @notice Emitted when the Sugarcane Factory is updated
     * @param admin The admin that made the update
     * @param chainId The chain id of the chain this is deployed on
     * @param oldSugarcane The old Sugarcane Factory
     * @param newSugarcane The new Sugarcane Factory
     */
    event SugarcaneFactoryUpdated(
        address indexed admin,
        uint256 chainId,
        address indexed oldSugarcane,
        address indexed newSugarcane
    );

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
