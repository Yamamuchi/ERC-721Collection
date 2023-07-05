// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

/// @title Diamond NFT Collection
/// @author Harvey Yorke
/// @notice ERC721 NFT collection
contract DiamondShades is ERC721 {
 
    uint256 public constant MAX_SUPPLY = 10;
    uint256 immutable public PRICE;
    address immutable public deployer;

    uint256 public tokenSupply = 0;
    string public baseURI;
    string public contractURI;

    event BaseURIChanged(address sender, string newBaseURI);
    event ContractURIChanged(address sender, string newContractURI);
    event Minted(address recipient, uint256 tokenId);

    modifier onlyOwner() {
        require(msg.sender == deployer);
        _;
    }

    constructor(
        string memory name, 
        string memory symbol,
        uint256 _price, 
        string memory _baseURI, 
        string memory _contractURI
    ) ERC721(name, symbol) {
        PRICE = _price;
        baseURI = _baseURI;
        contractURI = _contractURI;
        deployer = msg.sender;
    }

    /// @notice Mints an NFT to the recipient
    /// @dev Uses _safeMint to check for recipient being a smart contract
    /// @param _recipient Address to mint NFT to
    function mint(address _recipient) external payable onlyOwner {
        require(tokenSupply < MAX_SUPPLY, "All tokens minted");
        require(msg.value == PRICE, "Incorrect amount of ETH");

        _safeMint(_recipient, tokenSupply);
        emit Minted(_recipient, tokenSupply);
        tokenSupply++;
    }

    /// @notice View the ETH balance of the contract
    /// @return contractBalance Balance of the contract
    function viewBalance() external view returns (uint256 contractBalance) {
        return address(this).balance;
    }

    /// @notice Update baseURI of NFT
    /// @param _newBaseURI New baseURI
    function setBaseURI(string calldata _newBaseURI) public onlyOwner {
        baseURI = _newBaseURI;
        emit BaseURIChanged(msg.sender, _newBaseURI);
    }

    /// @return baseURI The contract baseURI
    function _baseURI() internal view override returns(string memory) {
        return baseURI;
    }

    /// @notice Update contractURI/NFT metadata
    /// @param _newContractURI New collection metadata
    function setContractURI(string calldata _newContractURI) public onlyOwner {
        contractURI = _newContractURI;
        emit ContractURIChanged(msg.sender, _newContractURI);
    }

    /// @notice Withdraw all funds from contract to owner
    function withdraw() external onlyOwner {
        payable(deployer).transfer(address(this).balance);
    }
} 