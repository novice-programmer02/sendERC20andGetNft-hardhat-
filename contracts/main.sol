//SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

// importing erc721, erc20(test1,test2) tokens 
import "./robot.sol";
import "./test1.sol";
import "./test2.sol";


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

    // the user give 100 and 200 erc20 tokens and get 1 robot nft token in there address.
    function getNFT(uint tok1, uint tok2) public {
        require(tok1 == 100, "send exact 100 erc20 tokens for 1 robot NFT");
        require(tok2 == 200, "send exact 200 erc20 tokens for 1 robot NFT");

        // in there the mint function from contract test1 and test2 call and mint the erc20 token to contact address of owner.
        test1._mint(owner, tok1);
        test2.mint(owner, tok2);

        // after reciveing the erc20 token from both the contract, the mint function is call from robot erc721 contract and mint 1 token to the msg.sender(user)
        robot.mint(msg.sender, "" , 1);

    } 

}

// after calling getNFT function successfully, the contract address gets both test1 and test2 erc20 tokens and user get a nft.
// check it by calling balanceOf function from the contract by passing the address. 