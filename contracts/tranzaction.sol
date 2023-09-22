// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;
contract tranzaction {
    struct Users{
        address addr;
        string uName;
        bool adm;
    }
    struct PremakeTransaction{
        string name;
        address sender;
        address resiever;
        uint value;
    }
    struct Transaction{
        string keyWord;
        address sender;
        address resiever;
        uint value;
        bool confermed;
    }

    address public owner = msg.sender;

    PremakeTransaction[] public premakeTransaction;
    Transaction[] public transactions;
    Users[] public users;
    
    mapping(address => Users) private user;
    mapping(string => Transaction) private transaction;
    mapping(string => PremakeTransaction) private premakeTransactions;
    constructor() { 
        // Заранее заготовленные переводы
        //premakeTransactions["Present"] = PremakeTransaction("Present", 0x17F6AD8Ef982297579C203069C1DbfFE4348c372, 20);

        // Пользователи
        user[0x5B38Da6a701c568545dCfcB03FcB875f56beddC4] = Users(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4, "Ivan", true);
        user[0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2] = Users(0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2, "Egor", true);
        user[0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db] = Users(0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db, "Max", false);
        user[0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB] = Users(0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB, "Vetal", false);
        user[0x617F2E2fD72FD9D5503197092aC168c91465E7f2] = Users(0x617F2E2fD72FD9D5503197092aC168c91465E7f2, "Kirill", false);
        user[0x17F6AD8Ef982297579C203069C1DbfFE4348c372] = Users(0x17F6AD8Ef982297579C203069C1DbfFE4348c372, "Vova", false);
    }
    
    // 

    function Deposit(string memory _keyCode, address _Resiever) public payable {
        //require(user[msg.sender]); // Затравочка на то, что переводить могут только зарегестрированные пользователи
        require(msg.value > 0, "0 in Value");
        require(msg.value <= msg.sender.balance * 10**18, "You Have No Such Money");
        transaction[_keyCode].confermed == false;
        transaction[_keyCode].sender = msg.sender;
        transaction[_keyCode].keyWord = _keyCode;
        transaction[_keyCode].value = msg.value;
        transaction[_keyCode].resiever = _Resiever;
    }

    function CancelTransaction(string memory _keyCode) public payable{
        require(transaction[_keyCode].confermed == false);
        require(transaction[_keyCode].sender == msg.sender);
        payable(msg.sender).transfer(transaction[_keyCode].value); 
    }
    
    function PreMake(string memory _Type) public payable { // Заготовка для заготовленных транзакций
        payable(premakeTransactions[_Type].resiever).transfer(premakeTransactions[_Type].value);
    }

    function getTransact(string memory _keyCode) public payable {
        require(msg.sender == transaction[_keyCode].resiever);
        require(transaction[_keyCode].value > 0, "0 in value");
        if (keccak256(abi.encodePacked(_keyCode)) == keccak256(abi.encodePacked(transaction[_keyCode].keyWord))) {
            payable(msg.sender).transfer(transaction[_keyCode].value);
            transaction[_keyCode].confermed = true;
        }
        else {
            payable(transaction[_keyCode].sender).transfer(transaction[_keyCode].value); // Доработать возврат средств при неправильном ключе
        }
    }
}