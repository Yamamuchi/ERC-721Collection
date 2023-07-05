const hre = require("hardhat");

async function main() {

  const tokenName = "DiamondShades";
  const tokenSymbol = "DS";
  const baseURI = "ipfs://QmabUnb43Ltgs2HWNRN1VwnAtEQyGWKwc5XP3Wqz2tCbpn/";
  const contractURI = "ipfs://Qma6edVgatxmt1AiEX7mCme2az2CNgSoNBkwRWcykj9MhC"

  const DiamondShades = await hre.ethers.getContractFactory("DiamondShades");
  const DiamondShadesDeployed = await DiamondShades.deploy(tokenName, tokenSymbol, baseURI, contractURI);

  await DiamondShadesDeployed.deployed();

  console.log("Deployed DiamondShades to: ", DiamondShadesDeployed.address);

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
