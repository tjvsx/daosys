// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {ERC20Metadata} from "../metadata/ERC20Metadata.sol";
import {ERC20Account} from "../account/ERC20Account.sol";
import {IERC20} from "../interfaces/IERC20.sol";

contract ERC20Basic is IERC20, ERC20Account, ERC20Metadata {

  constructor(
    string memory newName,
    string memory newSymbol,
    uint8 newDecimals,
    uint256 supply
  ) {
    _setName(
      type(IERC20).interfaceId,
      newName
    );
    _setSymbol(
      type(IERC20).interfaceId,
      newSymbol
    );
    _setDecimals(
      type(IERC20).interfaceId,
      newDecimals
    );
    _mint(msg.sender,supply);
  }

  function name() override(IERC20) view external returns (string memory tokenName) {
    tokenName = _name();
  }

  function symbol() override(IERC20) view external returns (string memory tokenSymbol) {
    tokenSymbol = _symbol();
  }

  function decimals() override(IERC20) view external returns (uint8 tokenDecimals) {
    tokenDecimals = _decimals();
  }
  
  function totalSupply() override(IERC20) external view returns (uint256 supply) {
    supply = _totalSupply();
  }

  function balanceOf(address account) override(IERC20) external view returns (uint256 balance) {
    balance = _balanceOf(account);
  }

  function allowance(
    address holder,
    address spender
  ) override(IERC20) external view returns (uint256 limit) {
    limit = _allowance(holder, spender);
  }

  function approve(
    address spender,
    uint256 amount
  ) override(IERC20) external returns (bool success) {
    _approve(spender, amount);
    emit Approval(msg.sender, spender, amount);
    success = true;
  }

  function transfer(
    address recipient, 
    uint256 amount
  ) override(IERC20) external returns (bool success) {
    _transfer(msg.sender, recipient, amount);
    emit Transfer(msg.sender, recipient, amount);
    success = true;
  }

  function transferFrom(
    address account,
    address recipient,
    uint256 amount
  ) override(IERC20) external returns (bool success) {
    _transferFrom(account, recipient, amount);
    emit Transfer(account, recipient, amount);
    success = true;
  }

}