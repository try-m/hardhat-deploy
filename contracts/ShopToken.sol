// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// The ShopToken contract does this and that...
contract ShopToken is Ownable(msg.sender) {
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

    function setToken(address token_) external onlyOwner {
        require(token_ != address(0));
        TOKEN = IERC20(token_);
    }

    function setRate(uint rate_) external onlyOwner {
        require(rate_ > 0);
        RATE = rate_;
    }

    function withdrawTokens() external onlyOwner {
        require(getBalanceToken() > 0, "Not enough tokens!");
        TOKEN.transfer(owner(), getBalanceToken());
    }

    function withdrawEther() external onlyOwner {
        require(getBalanceEther() > 0, "Not enough ether!");
        payable(owner()).transfer(getBalanceEther());
    }

    function buyTokens() external payable {
        require(msg.value > RATE, "Not enough ether!");
        uint valueTokens = msg.value / RATE;
        require(getBalanceToken() >= valueTokens, "Not enough tokens!");
        TOKEN.transfer(msg.sender, valueTokens);
    }

    function sellTokens(uint _amount) external {
        uint allowenceToken = TOKEN.allowance(msg.sender, address(this));
        uint valueEther = _amount * RATE;
        require(allowenceToken > _amount, "Not approved tokens!");
        TOKEN.transferFrom(msg.sender, address(this), _amount);
        payable(msg.sender).transfer(valueEther);
    }
}
