// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

// Local imports
import "../libs/SugarcaneLib.sol";

// Interface imports
import "../../interfaces/base/ISugarcaneInvestmentRegistry.sol";
import "../utils/SugarcaneCore.sol";

// The registry of what investments a given admin has
contract SugarcaneInvestmentRegistry is
    SugarcaneCore,
    ISugarcaneInvestmentRegistry
{
    // // // // // // // // // // // // // // // // // // // //
    // LIBRARIES AND STRUCTS
    // // // // // // // // // // // // // // // // // // // //

    // // // // // // // // // // // // // // // // // // // //
    // VARIABLES - REMEMBER TO UPDATE __gap
    // // // // // // // // // // // // // // // // // // // //

    address internal _manager;

    mapping(address => uint256[]) internal _addressToInvestmentIds;
    mapping(uint256 => SugarcaneLib.Investment) internal _investmentIdToDetails;

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

        __SugarcaneInvestmentRegistry_init_unchained();
    }

    function __SugarcaneInvestmentRegistry_init_unchained()
        internal
        initializer
    {}

    // // // // // // // // // // // // // // // // // // // //
    // MODIFIERS
    // // // // // // // // // // // // // // // // // // // //

    /**
     * @notice Throws if message sender called by any account other than the manager contract.
     */
    modifier onlyManager() {
        require(_manager == _msgSender(), "InvestmentRegistry: not manager");
        _;
    }

    // // // // // // // // // // // // // // // // // // // //
    // GETTERS
    // // // // // // // // // // // // // // // // // // // //

    /**
     * @notice Gets all the investments that have been added for this address
     * @return returns full list of the investments
     */
    function investments(address adminAddress_)
        external
        view
        override
        whenNotPausedExceptAdmin
        returns (uint256[] memory)
    {
        return _investments(adminAddress_);
    }

    /**
     * @notice Gets all the investments that have been added for this address
     * @return returns full list of the investments
     */
    function _investments(address adminAddress_)
        internal
        view
        returns (uint256[] memory)
    {
        return _addressToInvestmentIds[adminAddress_];
    }

    /**
     * @notice Get the details of a specific investment
     * @return returns the details of the investment
     */
    function investmentDetails(uint256 investmentId_)
        external
        view
        override
        whenNotPausedExceptAdmin
        returns (SugarcaneLib.Investment memory)
    {
        return _investmentDetails(investmentId_);
    }

    /**
     * @notice Get the details of a specific investment
     * @return returns the details of the investment
     */
    function _investmentDetails(uint256 investmentId_)
        internal
        view
        returns (SugarcaneLib.Investment memory)
    {
        return _investmentIdToDetails[investmentId_];
    }

    /**
     * @notice Combines the admin address and the investment index to create a unique id
     * @return returns the investment id
     */
    function investmentIdHash(address adminAddress_, uint256 investmentIndex_)
        external
        view
        override
        whenNotPausedExceptAdmin
        returns (uint256)
    {
        return _investmentIdHash(adminAddress_, investmentIndex_);
    }

    /**
     * @notice Combines the admin address and the investment index to create a unique id
     * @return returns the investment id
     */
    function _investmentIdHash(address adminAddress_, uint256 investmentIndex)
        internal
        pure
        returns (uint256)
    {
        return
            uint256(
                keccak256(abi.encodePacked(adminAddress_, "-", investmentIndex))
            );
    }

    /**
     * @notice Get the address of the manager
     * @return returns the address of the manager
     */
    function managerAddress()
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
     * @notice Adds the investment to the admin
     */
    function addInvestment(
        address adminAddress_,
        uint256 chainId_,
        uint256 protocolId_,
        uint256 initialAmountUsd_
    ) external override whenNotPausedExceptAdmin onlyManager {
        _addInvestment(adminAddress_, chainId_, protocolId_, initialAmountUsd_);
    }

    /**
     * @notice Adds the investment to the admin
     */
    function _addInvestment(
        address adminAddress_,
        uint256 chainId_,
        uint256 protocolId_,
        uint256 initialAmountUsd_
    ) internal {
        uint256 investmentIndex = _addressToInvestmentIds[adminAddress_].length;

        // Create the investment id
        uint256 investmentId = _investmentIdHash(
            adminAddress_,
            investmentIndex
        );

        // Add the id to the list of investments that is user has
        uint256[] storage currentInvestmentListing = _addressToInvestmentIds[
            adminAddress_
        ];
        currentInvestmentListing.push(investmentId);

        // Add the investment details
        SugarcaneLib.Investment
            storage currentInvestment = _investmentIdToDetails[investmentId];
        currentInvestment.chainId = chainId_;
        currentInvestment.protocolId = protocolId_;
        currentInvestment.initialAmountUsd = initialAmountUsd_;
        currentInvestment.isActive = true;

        emit InvestmentAdded(
            _msgSender(),
            adminAddress_,
            investmentId,
            investmentIndex
        );
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
    uint256[47] private __gap;
}
