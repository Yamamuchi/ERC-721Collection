const hre = require("hardhat");

async function main() {

  const tokenName = "MyERC";
  const tokenSymbol = "ERC";

  const BasicERC721 = await hre.ethers.getContractFactory("BasicERC721");
  const BasicERC721Deployed = await BasicERC721.deploy(tokenName, tokenSymbol);

  await BasicERC721Deployed.deployed();

  console.log("Deployed BasicERC721 to: ", BasicERC721Deployed.address);

  await hre.run("verify:verify", {
    address: BasicERC721Deployed.address,
    constructorArguments: [
      tokenName,
      tokenSymbol
    ]
  });

}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
