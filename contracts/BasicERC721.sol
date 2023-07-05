// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BasicERC721 is ERC721 {
 
    uint256 immutable public MAX_SUPPLY;
    uint256 immutable public PRICE;
    address immutable deployer;

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

    constructor(string memory name, string memory symbol, uint256 _maxSupply, uint256 _price, string memory _baseURI, string memory _contractURI) ERC721(name, symbol) {
        MAX_SUPPLY = _maxSupply;
        PRICE = _price;
        deployer = msg.sender;
        baseURI = _baseURI;
        contractURI = _contractURI;
    }

    function mint(address _recipient) external payable onlyOwner {
        require(tokenSupply < MAX_SUPPLY, "supply used up");
        require(msg.value == PRICE, "wrong price");

        _safeMint(_recipient, tokenSupply);
        emit Minted(_recipient, tokenSupply);
        tokenSupply++;
    }

    /// @notice View number of tokens in collection that an address holds
    function viewBalance() external view returns (uint256) {
        return address(this).balance;
    }

    /// @notice Update baseURI of NFT
    /// @param _newBaseURI New baseURI
    function setBaseURI(string calldata _newBaseURI) public onlyOwner {
        baseURI = _newBaseURI;
        emit BaseURIChanged(msg.sender, _newBaseURI);
    }

    /// @notice Return baseURI
    function _baseURI() internal view override returns(string memory) {
        return baseURI;
    }

    /// @notice Update contractURI/NFT metadata
    /// @param _newContractURI New metadata
    function setContractURI(string calldata _newContractURI) public onlyOwner {
        contractURI = _newContractURI;
        emit ContractURIChanged(msg.sender, _newContractURI);
    }

    /// @notice Withdraw all funds from contract to owner
    function withdraw() external onlyOwner {
        payable(deployer).transfer(address(this).balance);
    }
} 

// Immutables are stored directly in the deployed contract's bytecode (gas efficient)