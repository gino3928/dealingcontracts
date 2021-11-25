// SPDX-License-Identifier: MIT

pragma solidity 0.8.2;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

//Develop my own contract
contract GinoERC20 is ERC20, Ownable {
    
    constructor () ERC20("Gino", "GYEH") {
        // _mint(owner(), 1000 * 10**decimals());
    }

    function mint(address _account, uint256 _qty) public onlyOwner {
        _mint(_account, _qty);
    }

    function burn(address _account, uint256 _qty) public onlyOwner {
        _burn(_account, _qty);
    }
    
    // function approve(address spender, uint256 amount) public virtual override returns (bool) {
    //     super.approve(spender, amount * 10**decimals());
    //     return true;
    // }
    
    // function transferFrom(
    //     address sender,
    //     address recipient,
    //     uint256 amount
    // ) public virtual override returns (bool) {
    //     super.transferFrom(sender, recipient, amount * 10**decimals());
    //     return true;
    // }
}