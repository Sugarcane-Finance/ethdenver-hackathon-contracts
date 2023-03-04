// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

// Overall imports
import "@openzeppelin/contracts-upgradeable/token/ERC1155/IERC1155Upgradeable.sol";

// Connected parts of the system
import "../../code/libs/SugarcaneLib.sol";
import "../utils/IManagerUtil.sol";

// The badge interface
interface ISugarcaneBadge is IManagerUtil {
    // // // // // // // // // // // // // // // // // // // //
    // EVENTS
    // // // // // // // // // // // // // // // // // // // //
    // // // // // // // // // // // // // // // // // // // //
    // GETTERS
    // // // // // // // // // // // // // // // // // // // //

    /**
     * TAKEN FROM ERC1155SupplyUpgradeable
     * @dev Total amount of tokens in with a given id.
     */
    function totalSupply(uint256 id) external view returns (uint256);

    /**
     * * TAKEN FROM ERC1155SupplyUpgradeable
     * @dev Indicates whether any token exist with a given id, or not.
     */
    function exists(uint256 id) external view returns (bool);

    // // // // // // // // // // // // // // // // // // // //
    // CORE FUNCTIONS
    // // // // // // // // // // // // // // // // // // // //
}
