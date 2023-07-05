// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";


contract BasicERC721 is ERC721 {
 
    uint256 immutable public MAX_SUPPLY;
    uint256 immutable public PRICE;
    address immutable deployer;

    uint256 public tokenSupply = 0;
    string public baseURI;

    modifier onlyOwner() {
        require(msg.sender == deployer);
        _;
    }

    constructor(string memory name, string memory symbol, uint256 _maxSupply, uint256 _price) ERC721(name, symbol) {
        MAX_SUPPLY = _maxSupply;
        PRICE = _price;
        deployer = msg.sender;

        // console.log("Name:", name); 
        // console.log("Symbol:", symbol);
        // console.log("Deployed by:", msg.sender);
    }

    function mint() external payable {
        require(tokenSupply < MAX_SUPPLY, "supply used up");
        require(msg.value == PRICE, "wrong price");

        _mint(msg.sender, tokenSupply);
        tokenSupply++;
    }

    function viewBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function _baseURI() internal pure override returns(string memory) {
        return "ipfs://QmYfAwf2Ei75NZ5eSQP9sAvBi8nCsxkH5JaMVnexxw16mt/";
    }

    function withdraw() external onlyOwner {
        payable(deployer).transfer(address(this).balance);
    }
} 

// Immutables are stored directly in the deployed contract's bytecode (gas efficient)