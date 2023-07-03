const { expect } = require('chai');

describe("BasicERC721", function() {

    it("Should return correct name", async function () {

        const tokenName = "MyERC721Token";

        const BasicERC721 = await hre.ethers.getContractFactory("BasicERC721");
        const BasicERC721Deployed = await BasicERC721.deploy(tokenName, "ERC");

        await BasicERC721Deployed.deployed();

        expect(await BasicERC721Deployed.name()).to.equal(tokenName);
    })

    it("Should return correct name", async function () {

        const tokenSymbol = "ERC";

        const BasicERC721 = await hre.ethers.getContractFactory("BasicERC721");
        const BasicERC721Deployed = await BasicERC721.deploy("MyERC721Token", tokenSymbol);

        await BasicERC721Deployed.deployed();

        expect(await BasicERC721Deployed.symbol()).to.equal(tokenSymbol);
    })

}) 