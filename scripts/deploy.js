const hre = require("hardhat");

async function main() {

  const BasicERC721 = await hre.ethers.getContractFactory("BasicERC721");
  const BasicERC721Deployed = await BasicERC721.deploy("MyERC", "MERC");

  await BasicERC721Deployed.deployed();

  console.log("Deployed BasicERC721 to: ", BasicERC721Deployed.address);

}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
