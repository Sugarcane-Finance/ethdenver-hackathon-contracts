// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

// Local imports
import "../libs/SugarcaneLib.sol";

// Interface imports
import "../utils/SugarcaneCore.sol";
import "../../interfaces/core/ISugarcaneHoldings.sol";

// The smart contract wallet that the admin controls on various chains
contract SugarcaneHoldings is SugarcaneCore, ISugarcaneHoldings {
    // // // // // // // // // // // // // // // // // // // //
    // LIBRARIES AND STRUCTS
    // // // // // // // // // // // // // // // // // // // //

    // // // // // // // // // // // // // // // // // // // //
    // VARIABLES - REMEMBER TO UPDATE __gap
    // // // // // // // // // // // // // // // // // // // //

    uint256 internal _adminChainId;
    address internal _admin;

    // // // // // // // // // // // // // // // // // // // //
    // CONSTRUCTOR
    // // // // // // // // // // // // // // // // // // // //
    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() initializer {}

    /**
     * @notice Initializes the contract.
     */
    function initialize() public initializer {
        __SugarcaneCore_init();

        __SugarcaneHoldings_init_unchained();
    }

    function __SugarcaneHoldings_init_unchained() internal initializer {}

    // // // // // // // // // // // // // // // // // // // //
    // MODIFIERS
    // // // // // // // // // // // // // // // // // // // //

    // // // // // // // // // // // // // // // // // // // //
    // GETTERS
    // // // // // // // // // // // // // // // // // // // //
    /*
    [READ] – admin() returns address
    Sends back the address of the admin of the holdings wallet
    */

    /*
    [READ] – adminChain() returns uint256
    Sends back the chain id of the admin of the holdings wallet
    */

    // // // // // // // // // // // // // // // // // // // //
    // CORE FUNCTIONS
    // // // // // // // // // // // // // // // // // // // //
    /*

    [WRITE] – bridgeUsd(uint256 destinationChain_, address adminAddress_, uint256 amount_)
    Sends the tokens to the destination chain

    [WRITE] – metaTransfer(address tokenAddress_, address toAddress_, uint256 amount_)
    A transaction where the gas was paid for by a separate party but the owner of the account is the only one that can move the assets

    [WRITE] – setAdmin(uint256 chainId_, address adminAddress_)
    Sets the admin address and the chain id of the admin

    [WRITE] – transfer(address tokenAddress_, address toAddress_, uint256 amount_)
    Moves the amount of tokens from the holdings to the admin address
    */

    // // // // // // // // // // // // // // // // // // // //
    // GAP
    // // // // // // // // // // // // // // // // // // // //

    // Gap for more space
    uint256[48] private __gap;
}
