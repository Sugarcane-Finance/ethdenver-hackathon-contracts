// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

// Local imports

// Interface imports
import "../../interfaces/core/ISugarcaneFactory.sol";
import "../utils/SugarcaneCore.sol";
import "./SugarcaneHoldings.sol";

// The smart contract wallet that the signer controls on various chains
contract SugarcaneFactory is SugarcaneCore, ISugarcaneFactory {
    // // // // // // // // // // // // // // // // // // // //
    // LIBRARIES AND STRUCTS
    // // // // // // // // // // // // // // // // // // // //

    // // // // // // // // // // // // // // // // // // // //
    // VARIABLES - REMEMBER TO UPDATE __gap
    // // // // // // // // // // // // // // // // // // // //

    address internal _manager;

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

        __SugarcaneFactory_init_unchained();
    }

    function __SugarcaneFactory_init_unchained() internal initializer {}

    // // // // // // // // // // // // // // // // // // // //
    // MODIFIERS
    // // // // // // // // // // // // // // // // // // // //

    /**
     * @notice Throws if message sender called by any account other than the manager contract.
     */
    modifier onlyManager() {
        require(_manager == _msgSender(), "Factory: not manager");
        _;
    }

    // // // // // // // // // // // // // // // // // // // //
    // GETTERS
    // // // // // // // // // // // // // // // // // // // //

    /**
     * @notice Get the address of the manager
     * @return returns the address of the manager
     */
    function manager()
        external
        view
        override
        whenNotPausedExceptAdmin
        returns (address)
    {
        return _manager;
    }

    // // // // // // // // // // // // // // // // // // // //
    // CORE FUNCTIONS
    // // // // // // // // // // // // // // // // // // // //
    /**
     * @notice Only the manager can talk to this function Sends back the address of the created holdings
     */
    function createHoldingsAccount(
        uint256 signerChainId_,
        address signerAddress_
    ) external override whenNotPausedExceptAdmin onlyManager returns (address) {
        // Deploy a new sugarcane holdings for the signer
        SugarcaneHoldings sugarcaneHoldings = new SugarcaneHoldings();
        sugarcaneHoldings.initialize(signerChainId_, signerAddress_);

        emit HoldingsAccountCreated(
            _msgSender(),
            address(sugarcaneHoldings),
            signerChainId_,
            signerAddress_
        );

        // Return the address of the holdings
        return address(sugarcaneHoldings);
    }

    /**
     * @notice Updates the manager contract location
     */
    function setManager(address managerAddress_)
        external
        override
        whenNotPausedExceptAdmin
        onlySugarcaneAdmin
    {
        _setManager(managerAddress_);
    }

    /**
     * @notice Updates the manager contract location
     */
    function _setManager(address managerAddress_) internal {
        address oldManagerAddress = _manager;
        _manager = managerAddress_;

        emit ManagerUpdated(_msgSender(), oldManagerAddress, managerAddress_);
    }

    // // // // // // // // // // // // // // // // // // // //
    // GAP
    // // // // // // // // // // // // // // // // // // // //

    // Gap for more space
    uint256[49] private __gap;
}
