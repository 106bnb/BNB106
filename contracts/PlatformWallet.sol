// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/access/Ownable.sol";

contract PlatformWallet is Ownable {
    address public platform1;
    uint256 public platform1Amount;
    uint256 public platform1AmountWithdraw;
    address public platform2;
    uint256 public platform2Amount;
    uint256 public platform2AmountWithdraw;
    address public platform3;
    uint256 public platform3Amount;
    uint256 public platform3AmountWithdraw;
    address public platform4;
    uint256 public platform4Amount;
    uint256 public platform4AmountWithdraw;
    address public platform5;
    uint256 public platform5Amount;
    uint256 public platform5AmountWithdraw;
    uint256 public totalIncome;

    constructor(
        address _platform1,
        address _platform2,
        address _platform3,
        address _platform4,
        address _platform5
    ) {
        platform1 = _platform1;
        platform2 = _platform2;
        platform3 = _platform3;
        platform4 = _platform4;
        platform5 = _platform5;
    }

    modifier onlyPlatform(address account) {
        require(msg.sender == account);
        _;
    }

    function withdrawPlatform1(uint256 amount) public onlyPlatform(platform1) {
        require(amount <= platform1Amount, "Not enough balance");
        platform1Amount -= amount;
        platform1AmountWithdraw += amount;
        payable(platform1).transfer(amount);
    }

    function withdrawPlatform2(uint256 amount) public onlyPlatform(platform2) {
        require(amount <= platform2Amount, "Not enough balance");
        platform2Amount -= amount;
        platform2AmountWithdraw += amount;
        payable(platform2).transfer(amount);
    }

    function withdrawPlatform3(uint256 amount) public onlyPlatform(platform3) {
        require(amount <= platform3Amount, "Not enough balance");
        platform3Amount -= amount;
        platform3AmountWithdraw += amount;
        payable(platform3).transfer(amount);
    }

    function withdrawPlatform4(uint256 amount) public onlyPlatform(platform4) {
        require(amount <= platform4Amount, "Not enough balance");
        platform4Amount -= amount;
        platform4AmountWithdraw += amount;
        payable(platform4).transfer(amount);
    }

    function withdrawPlatform5(uint256 amount) public onlyPlatform(platform5) {
        require(amount <= platform3Amount, "Not enough balance");
        platform5Amount -= amount;
        platform5AmountWithdraw += amount;
        payable(platform5).transfer(amount);
    }

    function setPlatformAddress(
        address account1,
        address account2,
        address account3,
        address account4,
        address account5
    ) public onlyOwner {
        platform1 = account1;
        platform2 = account2;
        platform3 = account3;
        platform4 = account4;
        platform5 = account5;
    }

    function emergencyWithdraw(uint256 amount) public onlyOwner {
        uint256 balance = address(this).balance;
        require(balance >= amount, "Not enough");
        (bool success, ) = payable(_msgSender()).call{value: amount}("");
        require(success, "transfer fail");
    }

    

    receive() external payable {
        uint256 amount = msg.value;
        totalIncome += amount;
        platform1Amount += ((amount * 3333) / 10000);
        platform2Amount += ((amount * 3333) / 10000);
        platform3Amount += ((amount * 1666) / 10000);
        platform4Amount += ((amount * 833) / 10000);
        platform5Amount += ((amount * 833) / 10000);
    }
}
