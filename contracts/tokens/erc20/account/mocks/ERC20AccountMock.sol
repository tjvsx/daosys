// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ERC20Account,
  ERC20AccountInternal,
  ERC20AccountLib,
  ERC20AccountStorage
} from "../ERC20Account.sol";

contract ERC20AccountMock is ERC20Account {

  event Transfer(address indexed from, address indexed to, uint256 value);

  event Approval(address indexed owner, address indexed spender, uint256 value);

  function mint(address recipient, uint256 amount) external returns (bool success) {
    _mint(recipient, amount);
    emit Transfer(address(0), recipient, amount);
    success = true;
  }

 function totalSupply() external view returns (uint256 supply) {
    supply = _totalSupply();
  }

  function balanceOf(address account) external view returns (uint256 balance) {
    balance = _balanceOf(account);
  }

  function allowance(
    address holder,
    address spender
  ) external view returns (uint256 limit) {
    limit = _allowance(holder, spender);
  }

  function approve(
    address spender,
    uint256 amount
  ) external returns (bool success) {
    _approve(spender, amount);
    emit Approval(msg.sender, spender, amount);
    success = true;
  }

  function transfer(
    address recipient, 
    uint256 amount
  ) external returns (bool success) {
    _transfer(msg.sender, recipient, amount);
    emit Transfer(msg.sender, recipient, amount);
    success = true;
  }

  function transferFrom(
    address account,
    address recipient,
    uint256 amount
  ) external returns (bool success) {
    _transferFrom(account, recipient, amount);
    emit Transfer(account, recipient, amount);
    success = true;
  }
  
}