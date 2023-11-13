// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.9.0) (token/ERC20/ERC20.sol)
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./interfaces/IBlackList.sol";

contract Token is ERC20, Ownable {
    IBlackList public blackListContract;

    constructor(
        string memory tokenName,
        string memory tokenSymbol,
        address blAddress
    ) ERC20(tokenName, tokenSymbol) {
        blackListContract = IBlackList(blAddress);
    }

    /* function decimals() public pure override returns (uint8){
        return 8;
    } */

    function mint(address account, uint amount) external onlyOwner {
        _mint(account, amount);
    }

    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    function insertInBlackList(address user) external onlyOwner {
        blackListContract.addBlackList(user, address(this));
    }

    function removeFromBlackList(address user) external onlyOwner {
        blackListContract.removeBlackList(user, address(this));
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal view override {
        amount;
        if (
            blackListContract.getBlackListStatus(from) ||
            blackListContract.getBlackListStatus(to)
        ) {
            revert("BlackListed Addresses");
        }
    }

    function getBlackListStatus(
        address _evilUser
    ) external view returns (bool) {}
}
