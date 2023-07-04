// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "hardhat/console.sol";

contract BasicERC721 is ERC721 {
 
    uint256 public tokenSupply = 0;
    // Immutables are stored directly in the deployed contract's bytecode (gas efficient)
    uint256 public immutable MAX_SUPPLY;
    uint256 public constant PRICE = 0.1 ether;

    string public baseURI;

    constructor(string memory name, string memory symbol, uint256 _maxSupply) ERC721(name, symbol) {
        MAX_SUPPLY = _maxSupply;

        console.log("Name:", name); 
        console.log("Symbol:", symbol);
        console.log("Deployed by:", msg.sender);
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
        return "";
    }
} 