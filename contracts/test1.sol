//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract token1 is ERC20 {
    
    constructor() ERC20("Test1", "t1") {
        
    }
}