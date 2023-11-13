// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.9.0) (token/ERC20/ERC20.sol)
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./interfaces/IBlackList.sol";

contract BlackList is Ownable, IBlackList {
    mapping(address => bool) public isBlackListed;
    mapping(address => bool) public allowedTokens;

    modifier _isBlacklist() {
        _checkBlackList(msg.sender);
        _;
    }
    modifier onlyOwnerAllowed() {
        require(allowedTokens[msg.sender]);
        _;
    }

    constructor() {}

    event DestroyBlackFunds(address _blackListedUser, uint _balance);

    event AddedBlacklist(address _user);

    event RemovedBlacklist(address _user);

    function allowedToken(address token) external onlyOwner {
        if (token == address(0)) {
            revert("Token 0");
        }
        allowedTokens[token] = true;
    }

    function _getBlackListStatus(
        address _evilUser
    ) internal view returns (bool) {
        return isBlackListed[_evilUser];
    }

    function getBlackListStatus(
        address _evilUser
    ) external view override returns (bool) {
        return isBlackListed[_evilUser];
    }

    function addBlackList(address _evilUser, address token) external {
        if (!allowedTokens[token]) {
            revert();
        }
        isBlackListed[_evilUser] = true;
    }

    function removeBlackList(address _evilUser, address token) external {
        if (!allowedTokens[token]) {
            revert();
        }
        isBlackListed[_evilUser] = false;
    }

    function _checkBlackList(address _evilUser) internal view virtual {
        require(
            _getBlackListStatus(_evilUser),
            "Blacklist: adress is blackListed"
        );
    }
}
