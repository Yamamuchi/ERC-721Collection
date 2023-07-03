// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "hardhat/console.sol";

contract BasicERC721 is ERC721 {

    constructor(string memory name, string memory symbol) ERC721(name, symbol) {
        console.log("Name:", name); 
        console.log("Symbol:", symbol);
        console.log("Deployed by:", msg.sender);
    }
}