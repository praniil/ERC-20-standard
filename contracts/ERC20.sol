// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
//mint: new token generation, totalSupply attribute
//attributes
//different functions for transfer and all

contract ERC20 {
    mapping (address => uint) balance;  //key value pair
    uint256 private _totalSupply;
    string private _name;
    string private _symbol;
    uint8 private _decimal; 


    //when deployer initializes the constructor, msg.sender is the address of initializer, who deploys the contract
    constructor (string memory name, string memory symbol, uint8 decimal, uint256 totalSupply) {
        _name = name;
        _symbol = symbol;
        _decimal = decimal;
        _mint(msg.sender, totalSupply); //msg.sender := address of deployer
    }

    //internal:= can be called from the inherent function as well
    function _mint(address owner, uint256 totalSupply) internal { 
        balance[owner] = totalSupply;   
        _totalSupply = totalSupply;
    }

    function transfer(address to, uint amount) public {
        require(balance[msg.sender] > amount, "Insufficient fund");
        balance[msg.sender] = balance[msg.sender] - amount;
        balance[to] = balance[to] - amount;
    }

    function balanceOf(address owner) public view returns (uint) {
        return balance[owner];
    }

    function burn(uint amount) public {
        require(balance[msg.sender] > amount, "Insufficient fund to burn");
        balance[msg.sender] = balance[msg.sender] - amount;
        _totalSupply = _totalSupply - amount;
    }
}