//SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

// importing erc721, erc20(test1,test2) tokens 
import "./robot.sol";
import "./test2.sol";
import "./test1.sol";

contract sendNFT {
    
    // create instance of all the  three contract for using their functions 

    myERC721 robot;  
    token1 test1;
    token2 test2;

    address public owner;

    constructor(address ERC721_,address test1_, address test2_) 
    {
        // take the contract address of those three contracts before deployment
        robot = myERC721(ERC721_);
        test1 = token1(test1_);
        test2 = token2(test2_);
        owner = msg.sender;
    }


    function getNFT(uint tok1, uint tok2) public {
        require(tok1 == 100, "send exact 100 erc20 tokens for 1 robot NFT");
        require(tok2 == 200, "send exact 200 erc20 tokens for 1 robot NFT");

        test1.transferFrom(msg.sender, address(this), tok1);
        test2.transferFrom(msg.sender, address(this), tok2);

        robot.mint(msg.sender, "" , 1);


    } 

}
