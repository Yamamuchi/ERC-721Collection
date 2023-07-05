const hre = require("hardhat");

async function main() {

  const tokenName = "MyERC";
  const tokenSymbol = "ERC";
  const baseURI = "ipfs://QmYfAwf2Ei75NZ5eSQP9sAvBi8nCsxkH5JaMVnexxw16mt/";
  const contractURI = "ipfs://QmReuBxLqvPJ35ub42mC6mhecfb7wcaaV96ypD2DWpASn1"

  const DiamondShades = await hre.ethers.getContractFactory("DiamondShades");
  const DiamondShadesDeployed = await DiamondShades.deploy(tokenName, tokenSymbol, baseURI, contractURI);

  await DiamondShadesDeployed.deployed();

  console.log("Deployed BasicERC721 to: ", DiamondShadesDeployed.address);

  await hre.run("verify:verify", {
    address: DiamondShadesDeployed.address,
    constructorArguments: [
      tokenName,
      tokenSymbol,
      baseURI,
      contractURI
    ]
  });
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
