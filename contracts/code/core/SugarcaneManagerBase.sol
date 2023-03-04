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

    uint256 private __chainId;
    address private __sugarcaneFactory;

    // Axelar specific variables
    address private __gateway;
    address private __gasService;

    // Map the holdings to the signer
    mapping(address => SugarcaneLib.HoldingsToSigner)
        internal _holdingsToSignerMap;

    // Map the signer to the holdings
    mapping(address => SugarcaneLib.OnboardAccountDetail)
        internal _addressOnboardMap;

    // List of all onboarded addresses
    address[] internal _onboardedAddresses;

    // // // // // // // // // // // // // // // // // // // //
    // CONSTRUCTOR
    // // // // // // // // // // // // // // // // // // // //
    function __SugarcaneManagerBase_init(
        uint256 _chainId,
        address gateway_,
        address gasService_
    ) internal initializer {
        __SugarcaneCore_init();

        _chainId = chainId_;
        __gateway = gateway_;
        __gasService = gasService_;
    }

    // // // // // // // // // // // // // // // // // // // //
    // MODIFIERS
    // // // // // // // // // // // // // // // // // // // //

    // // // // // // // // // // // // // // // // // // // //
    // AXELAR SPECIFIC FUNCTIONS
    // // // // // // // // // // // // // // // // // // // //

    /**
     * @notice Sends back the wrapped Axelar gateway object
     * @return returns the Axelar gateway object
     */
    function _axelarGateway() internal view returns (IAxelarGateway) {
        return IAxelarGateway(_bridgeGateway());
    }

    /**
     * @notice Sends back the wrapped Axelar gas service object
     * @return returns the Axelar gas service object
     */
    function _axelarGasService() internal view returns (IAxelarGasService) {
        return IAxelarGasService(_bridgeGasService());
    }

    // // // // // // // // // // // // // // // // // // // //
    // GETTERS
    // // // // // // // // // // // // // // // // // // // //
    /**
     * @notice Sends the chain id
     * @return returns the number that represents the chain id
     */
    function chainId()
        external
        view
        override
        whenNotPausedExceptAdmin
        returns (uint256)
    {
        return _chainId();
    }

    /**
     * @notice Sends the chain id
     * @return returns the number that represet
     */
    function _chainId() internal view returns (uint256) {
        return __chainId;
    }

    /**
     * @notice Sends back the address of the bridge gateway
     * @return returns the address of the bridge gateway
     */
    function bridgeGateway()
        external
        view
        override
        whenNotPausedExceptAdmin
        returns (address)
    {
        return _bridgeGateway();
    }

    /**
     * @notice Sends back the address of the bridge gateway
     * @return returns the address of the bridge gateway
     */
    function _bridgeGateway() internal view returns (address) {
        return __gateway;
    }

    /**
     * @notice Sends back the address of the bridge gas service
     * @return returns the address of the bridge gas service
     */
    function bridgeGasService()
        external
        view
        override
        whenNotPausedExceptAdmin
        returns (address)
    {
        return _bridgeGasService();
    }

    /**
     * @notice Sends back the address of the bridge gas service
     * @return returns the address of the bridge gas service
     */
    function _bridgeGasService() internal view returns (address) {
        return __gasService;
    }

    /**
     * @notice Sends back the address of the Sugarcane factory
     */
    function sugarcaneFactory()
        external
        view
        override
        whenNotPausedExceptAdmin
        returns (address)
    {
        return _sugarcaneFactory();
    }

    /**
     * @notice Sends back the address of the Sugarcane factory
     */
    function _sugarcaneFactory() internal view returns (address) {
        return __sugarcaneFactory;
    }

    /*
    [READ] – hasOnboarded(address userAddress_) returns bool
    Tells if the user has onboarded

    [READ] – onboarder() returns address
    Returns the address that can make it onboard users (on Base this is the Base relayer, on Goerli it is the defender address, and on the other chains it is their Sugarcane_Onboard_Executor)
    */

    // // // // // // // // // // // // // // // // // // // //
    // CORE FUNCTIONS
    // // // // // // // // // // // // // // // // // // // //

    /**
     * @notice Sets the address of the bridge gas service
     * @param gasService_ the address of the bridge gas service
     */
    function setGasService(address gasService_)
        external
        override
        whenNotPausedExceptAdmin
        onlySugarcaneAdmin
    {
        _setGasService(gasService_);
    }

    /**
     * @notice Sets the address of the bridge gas service
     * @param gasService_ the address of the bridge gas service
     */
    function _setGasService(address gasService_) internal returns (address) {
        address oldGasService = __gasService;
        __gasService = gasService_;

        emit GasServiceUpdated(
            _msgSender(),
            _chainId,
            oldGasService,
            gasService_
        );
    }

    /**
     * @notice Sets the address of the bridge gateway
     * @param gateway_ the address of the bridge gateway
     */
    function setGateway(address gateway_)
        external
        override
        whenNotPausedExceptAdmin
        onlySugarcaneAdmin
    {
        _setGateway(gateway_);
    }

    /**
     * @notice Sets the address of the bridge gateway
     * @param gateway_ the address of the bridge gateway
     */
    function _setGateway(address gateway_) internal returns (address) {
        address oldGateway = __gateway;
        __gateway = gateway_;

        emit GatewayUpdated(_msgSender(), _chainId, oldGateway, gateway_);
    }

    /**
     * @notice Sets the address of the Sugarcane Factory
     * @param sugarcaneFactory_ the address of the Sugarcane Factory
     */
    function setSugarcaneFactory(address sugarcaneFactory_)
        external
        override
        whenNotPausedExceptAdmin
        onlySugarcaneAdmin
    {
        _setSugarcaneFactory(sugarcaneFactory_);
    }

    /**
     * @notice Sets the address of the Sugarcane Factory
     * @param sugarcaneFactory_ the address of the Sugarcane Factory
     */
    function _setSugarcaneFactory(address sugarcaneFactory_)
        internal
        returns (address)
    {
        address oldSugarcaneFactory = __sugarcaneFactory;
        __sugarcaneFactory = sugarcaneFactory_;

        emit SugarcaneFactoryUpdated(
            _msgSender(),
            _chainId,
            oldSugarcaneFactory,
            sugarcaneFactory_
        );
    }

    /**
     * @notice Called to onboard an account
     * @param signerAddress the address of the account to onboard
     */
    function onboardAccount(address signerAddress)
        external
        override
        nonReentrant
        whenNotPausedExceptAdmin
        onlySugarcaneAdmin
    {
        _onboardAccount(signerAddress);
    }

    /**
     * @notice Called to onboard an account
     * @param signerAddress the address of the account to onboard
     */
    function _onboardAccount(address signerAddress) internal returns (address) {
        // Only onboard accounts who have not onboarded
        require(
            !_addressOnboardMap[signerAddress].isOnboarded,
            "ManagerBase: Account onboarded"
        );

        // Add the investment details
        SugarcaneLib.OnboardAccountDetail
            storage currentSignerAccount = _addressOnboardMap[signerAddress];

        currentSignerAccount.onboardedBlock = block.number;
        currentSignerAccount.timestamp = block.timestamp;
        currentSignerAccount.isOnboarded = true;
        currentSignerAccount.onboardingIndex = _onboardedAddresses.length;

        // Add the address to the list of onboarded addresses
        _onboardedAddresses.push(signerAddress);

        address holdingsAddress = ISugarcaneFactory(__sugarcaneFactory)
            .createHoldingsAccount(__chainId, signerAddress);

        // Update the reference of the signer address to the holdings address
        currentSignerAccount.holdings = holdingsAddress;

        // Also do a reverse mapping of the holdings address to the signer address
        SugarcaneLib.HoldingsToSigner
            storage reverseMapping = _holdingsToSignerMap[holdingsAddress];

        reverseMapping.signer = signerAddress;
        reverseMapping.isOnboarded = true;

        emit AccountOnboarded(
            _msgSender(),
            _chainId,
            signerAddress,
            holdingsAddress
        );
    }

    /*
    [WRITE] – setOnboarder(address onboarderAddress_)
    Updates the valid onboarding address contract 
    */

    // // // // // // // // // // // // // // // // // // // //
    // GAP
    // // // // // // // // // // // // // // // // // // // //

    // Gap for more space
    uint256[43] private __gap;
}
