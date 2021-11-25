// SPDX-License-Identifier: MIT
pragma solidity 0.8.2;

import "./GinoERC20.sol";
import "./GinoNFT.sol";

contract marketNFT is Ownable {
    
    GinoERC20 private token;
    Anime private NFT;
    
    constructor(address _token, address _NFT) {
        NFT = Anime(_NFT);
        token = GinoERC20(_token);
    }
    
    mapping (uint256 => uint256) prices;
    mapping (uint256 => bool) mintAlready;
    
    function setPrice(uint256 _tokenId, uint256 _price) public onlyOwner {
        require(_price > 0, "The price can only be positive");
        prices[_tokenId] = _price;
    }
    
    function viewPrice(uint256 _tokenId) public view returns(uint256) {
        require(prices[_tokenId] > 0, "Did not set price yet");
        return prices[_tokenId];
    }
    
    //Buyer's pov, make order 
    function buyNFT(uint256 _tokenId) public {
        require(prices[_tokenId] > 0, "Did not set price yet"); //no free items
        require(mintAlready[_tokenId] == false, "The token has been minted already!");
        
        mintAlready[_tokenId] = true;

        uint256 price = viewPrice(_tokenId);
        uint256 currentAllowance = token.allowance(msg.sender, address(this));
        require(currentAllowance >= price, "Gino: transfer amount exceeds allowance");

        token.transferFrom(msg.sender, address(this), price);
        NFT.mint(msg.sender, _tokenId);
    }
    
    fallback() external {}
    receive() external payable {}
}