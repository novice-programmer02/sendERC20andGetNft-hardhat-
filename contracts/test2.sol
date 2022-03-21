//SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;


contract token2 
{
    string public Name ;
    string public symbol;
    uint public decimal;
    address admin;

    // event Approval(address indexed tokenOwner, address indexed sender, uint tokens);
    // event Transfer(address indexed from, address indexed to, uint tokens) ;

    mapping(address => uint) balance;
    mapping(address => mapping(address => uint)) allowed;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);


    uint totalSupply_ ;
 
    constructor() 
    {
        Name = "test1";
        symbol = "t1";
        decimal = 8;
        admin = msg.sender;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "only Admin can reun this function!!");
        _;
    }

    function totalSupply() public  view returns(uint){
        return totalSupply_;
    }

    function balanceOf(address tokenOwner) public  view returns(uint){
        return balance[tokenOwner];
    }

    function transfer(address reciever ,  uint numTokens) public  returns(bool){
        require(balance[msg.sender] >= numTokens);
        balance[msg.sender] -= numTokens;
        balance[reciever] += numTokens;
        // emit Transfer(msg.sender, reciever, numTokens);
        return true;
    }
    
    function mint(address reciever, uint quantity) public  returns(uint){
        
        balance[reciever] += quantity;
        totalSupply_ += quantity;
        return totalSupply_;
    }

    function approve(address spender_, uint value_) public onlyAdmin returns(bool success){
        allowed[msg.sender][spender_] = value_;
        // emit Approval(msg.sender, spender_, value_);
        return true;
    }

    function allowance(address ownwer_, address spender_) public onlyAdmin view returns(uint remaining){
        return allowed[ownwer_][spender_];
    }

    function transferOwnership(address newOwner) public onlyAdmin {
        require(newOwner != address(0));
        emit OwnershipTransferred(admin, newOwner);
        admin = newOwner;
    }

    function transferFrom(address _from, address _to, uint value_) public returns(bool success)
    {
        uint allowance1 = allowed[_from][msg.sender];
        require(balance[_from] >= value_ && allowance1 >= value_);
        balance[_to] += value_;
        balance[_from] -= value_;
        allowed[_from][msg.sender] -= value_;
        
        // emit Transfer(_from, _to, value_);
        return true;
    }

    function increaseAllowance(address spender_, uint256 addedValue) public onlyAdmin returns (bool) {
       approve(spender_, allowed[msg.sender][spender_] + addedValue);
       return true;
    }
    
    function decreaseAllowance(address spender_, uint subtractedValue) public onlyAdmin returns(bool)
    {
        approve(spender_, allowed[msg.sender][spender_] - subtractedValue );
        return true;
    }
    
}