// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.9.0) (token/ERC20/ERC20.sol)
pragma solidity ^0.8.19;

interface IBlackList {
    function getBlackListStatus(address _evilUser) external view returns (bool);

    function addBlackList(address _evilUser, address token) external;

    function removeBlackList(address _evilUser, address token) external;
}
