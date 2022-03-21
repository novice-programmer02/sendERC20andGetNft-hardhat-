//SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

interface IERC721
{
    function name() external view returns(string memory);
    function symbol() external view returns(string memory);
    function balanceOf(address _owner) external view returns(uint256);
    function ownerOf(uint256 _tokenId) external view returns(address);
    function totalTokens() external view  returns(uint tokens);
    function approve(address _to, uint256 _tokenId) external;
    function takeOwnerShip(uint256 _tokenId) external ;
    function mint_(address account, uint256 _tokenId, uint amount) external ;
    function exists(uint256 _tokenId) external view returns (bool) ;
    function transfer(address _from, address _to, uint256 _tokenId) external; 



}


contract myERC721 is IERC721 {

    string name_;
    string symbol_;
    uint256 totalToken;
    address public admin_;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;


    mapping(address => uint256) private balance;
    mapping(uint256 => address) private owner;
    mapping(address => mapping(address => uint256)) private allowed;
    mapping(uint256 => string)private _tokenURIs;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor(){
        name_ = "Robot";
        symbol_ = "robot_";
        admin_ = msg.sender;
    }

    modifier admin {
        require(msg.sender == admin_, "only admin");
        _;
    }

    function name() public override  view returns(string memory)
    {
        return name_;
    }

    function symbol() public override view returns(string memory)
    {
        return symbol_;
    }

    function balanceOf(address _owner) public override view returns(uint256)
    {
        return balance[_owner];
    }

    function ownerOf(uint256 _tokenId) public override view returns(address)
    {
        address owner_ = owner[_tokenId];
        return owner_;
    }

    function totalTokens() public  override view  returns(uint tokens)
    {
        return totalToken;
    }

    function exists(uint256 _tokenId) public override view returns (bool) 
    {
        return owner[_tokenId] != address(0);
    }

    function approve(address _to, uint256 _tokenId) public override
    {   require(msg.sender == ownerOf(_tokenId));
        require(msg.sender != _to);

        allowed[msg.sender][_to] = _tokenId;
    }

    function takeOwnerShip(uint256 _tokenId) public override                                                                   
    {
        address oldowner = ownerOf(_tokenId);
        address newowner = msg.sender;

        require(oldowner != newowner);
        require(allowed[oldowner][newowner] == _tokenId);

        balance[oldowner] -= 1;
        owner[_tokenId] = newowner;
        balance[newowner] += 1;
    }

    function transferOwnership(address newOwner) public admin {
        require(newOwner != address(0));
        emit OwnershipTransferred(admin_, newOwner);
        admin_ = newOwner;
    }

    function mint_(address account, uint256 _tokenId, uint amount) public override                                                                                                                                                                                   
    {
        balance[account] += amount;
        owner[_tokenId] = account;
        totalToken += 1;
    }

    function transfer(address _from, address _to, uint256 _tokenId) public override 
    {   require(_from != _to);
        require(_to != msg.sender);

        balance[_from] -= 1;
        balance[_to] += 1;
        owner[_tokenId] = _to;

    }

    function _setTokenURI(uint256 _tokenId,string memory _tokenURI)internal virtual {
        _tokenURIs[_tokenId]=_tokenURI;
    }
    
    function mint( address recipient,string memory uri, uint amount)public admin returns(uint){
        
        _tokenIds.increment();
        uint256 newItemId=_tokenIds.current();
        mint_(recipient,newItemId, amount);
        _setTokenURI(newItemId,uri);
        return newItemId;
    }

}