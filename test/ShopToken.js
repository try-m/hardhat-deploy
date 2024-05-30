const {
    time,
    loadFixture,
} = require("@nomicfoundation/hardhat-toolbox/network-helpers");
const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("ShopToken", function () {
    async function deployErc20AndShopToken() {
        const _name = "Tia";
        const _symbol = "ustd";
        const _decimals = "18";

        const ERC20 = await ethers.getContractFactory("ERC20");
        const erc20 = await ERC20.deploy(_name, _symbol, _decimals);
        const erc20address = await erc20.getAddress();
        
        const _rate = 1000000000000000;
        const ShopToken = await ethers.getContractFactory("ShopToken");
        const shopToken = await ShopToken.deploy(erc20address, _rate);

        return { shopToken, erc20, _rate };
    }

    it("should return rate equal to initial rate", async function() {
        const {shopToken, erc20, _rate } = await loadFixture(deployErc20AndShopToken);
        const result = await shopToken.getRate();

        expect(result).to.equal(_rate);
    })
  });
