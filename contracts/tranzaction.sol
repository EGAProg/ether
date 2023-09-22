// SPDX-License-Identifier: MIT

pragma solidity >= 0.7.0 < 0.9.0;

contract tranzaction {
    struct Users{
        uint id;
        address addr;
        string uName;
        bool adm;
    }

    struct Transaction{
        uint id;
        string keyWord;
        uint value;
        bool confermed;

    }

    Transaction[] public transactions;
    Users[] public users;

    mapping(address => uint256) private user;
    
    constructor() { 
        users.push(Users(0, 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4, "Ivan", true));
        users.push(Users(1, 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2, "Egor", false));
    }


    function deposit() public payable{
        require(msg.value > 0);
    } 

    // function GetPay(string memory _Key) public {
    //     require(keccak256(abi.encodePacked(_Key)) == keccak256(abi.encodePacked(user[_Key])));
    //     uint256 amount = user[_Key];
        
    //     payable(msg.sender).transfer(amount);
    //     user[_Key] = 0; // Очищаем баланс после снятия.
    // }
}