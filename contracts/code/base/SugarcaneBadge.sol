// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

// Overall imports
import "@openzeppelin/contracts-upgradeable/token/ERC1155/ERC1155Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC1155/extensions/ERC1155SupplyUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/StringsUpgradeable.sol";

// Local imports
import "../utils/ManagerUtil.sol";

contract SugarcaneBadge is
    ManagerUtil,
    ERC1155Upgradeable,
    ERC1155SupplyUpgradeable
{
    // // // // // // // // // // // // // // // // // // // //
    // LIBRARIES AND STRUCTS
    // // // // // // // // // // // // // // // // // // // //

    using StringsUpgradeable for uint256;

    // // // // // // // // // // // // // // // // // // // //
    // VARIABLES - REMEMBER TO UPDATE __gap
    // // // // // // // // // // // // // // // // // // // //
    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(address managerAddress_) public initializer {
        __ManagerUtil_init(managerAddress_);

        __ERC1155_init("");
        __ERC1155Supply_init();
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(ERC1155Upgradeable, AccessControlUpgradeable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function setURI(string memory newuri) public onlySugarcaneAdmin {
        _setURI(newuri);
    }

    function uri(uint256 badgeId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        return
            string(
                abi.encodePacked(
                    "https://sugarcane.infura-ipfs.io/ipfs/QmdPqKhoYKbrqDx1jCEjPpHdi86nHdfcJS6ZJfKZQcbTJa/metadata/",
                    badgeId.toString(),
                    ".json"
                )
            );
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) internal override(ERC1155Upgradeable, ERC1155SupplyUpgradeable) {
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
    }

    // function safeTransferFrom(
    //     address from,
    //     address to,
    //     uint256 id,
    //     uint256 amount,
    //     bytes memory data
    // ) public virtual override {
    //   revert();
    // }

    function mint(
        address to,
        uint256 id,
        uint256 amount
    ) public onlySugarcaneManager {
        require(balanceOf(to, id) == 0, "User already has badge.");
        _mint(to, id, amount, "");
    }

    // // // // // // // // // // // // // // // // // // // //
    // GAP
    // // // // // // // // // // // // // // // // // // // //

    // Gap for more space
    uint256[49] private __gap;
}
