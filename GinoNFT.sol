// SPDX-License-Identifier: MIT
pragma solidity 0.8.2;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Anime is Context, ERC721Enumerable, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    uint private MAX_SUPPLY=2000;

    string private baseURI;

    constructor() ERC721("anime", "ANIME11"){
        baseURI = "https://gateway.pinata.cloud/ipfs/QmbB4DADBWwzEL6Lz3CN1oxH5zusoas9PJVYDR5Dqx6ppf/";
    }

    function increaseSupply(uint256 amount) public onlyOwner {
        require(amount > 0, "");
        MAX_SUPPLY += amount;
    }

    function viewSupply() public view returns(uint256) {
        return totalSupply();
    }

    function setBaseURI(string memory uri_) external {
        baseURI = uri_;
    }

    function safeMint(address to) public payable {
        require(totalSupply()<MAX_SUPPLY, "Can't mint more.");
        // require(msg.value>=mintRate, "Not enough ether sent.");
        _safeMint(to, _tokenIdCounter.current());
        _tokenIdCounter.increment();
    }
    
    function mint(address to_, uint256 tokenId_) external {
        require(totalSupply()<MAX_SUPPLY, "Can't mint more.");
        _safeMint(to_, tokenId_);
    }

    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }

    function baseTokenURI() public view returns (string memory) {
        return baseURI;
    }
}
