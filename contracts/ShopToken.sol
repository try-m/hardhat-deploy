// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// The ShopToken contract does this and that...
contract ShopToken {
    IERC20 public TOKEN;
    uint public RATE;

    constructor(address _token, uint _rate) {
        TOKEN = IERC20(_token);
        RATE = _rate;
    }

    function getBalanceToken() public view returns (uint balance) {
        balance = TOKEN.balanceOf(address(this));
    }

    function getBalanceEther() public view returns (uint balanceEther) {
        balanceEther = address(this).balance;
    }
}
