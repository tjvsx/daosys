// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ERC20AccountInternal,
  ERC20AccountLib,
  ERC20AccountStorage
} from "./internal/ERC20AccountInternal.sol";
import {IERC20} from "../interfaces/IERC20.sol";

abstract contract ERC20Account is ERC20AccountInternal {

  using ERC20AccountLib for ERC20AccountStorage.Layout;

  // event Transfer(address indexed from, address indexed to, uint256 value);

  // event Approval(address indexed owner, address indexed spender, uint256 value);

  function _mint(address recipient, uint256 amount) internal {
    _setTotalSupply(_getTotalSupply() + amount);
    _setBalance(recipient, _getBalance(recipient) + amount);
    // emit Transfer(address(0), recipient, amount);
  }

  function _burn(address account, uint256 amount) internal {
    uint256 totalSupply = _getTotalSupply();
    require(totalSupply >= amount);
    uint256 accountBalance = _getBalance(account);
    require(accountBalance >= amount);
    _setTotalSupply(totalSupply - amount);
    _setBalance(account, accountBalance - amount);
    // emit Transfer(account, address(0), amount);
  }

  function _totalSupply() internal view returns (uint256 supply) {
    supply = _getTotalSupply();
  }

  function _balanceOf(address account) internal view returns (uint256 balance) {
    balance = _getBalance(account);
  }

  function _allowance(
    address holder,
    address spender
  ) internal view returns (uint256 limit) {
    limit = _getApproval(holder, spender);
  }

  function _approve(
    address spender,
    uint256 amount
  ) internal {
    _setApproval(msg.sender, spender, amount);
    // emit Approval(msg.sender, spender, amount);
  }

  function _transfer(
    address account, 
    address recipient, 
    uint256 amount
  ) internal {
    require(account != address(0));
    require(recipient != address(0));
    uint256 accountBalance = _getBalance(account);
    require(accountBalance >= amount);
    _setBalance(account, accountBalance - amount);
    _setBalance(recipient, _getBalance(recipient) + amount);
    // emit Transfer(account, recipient, amount);
  }

  function _transferFrom(
    address holder,
    address recipient,
    uint256 amount
  ) internal {
    require(msg.sender != address(0));
    require(
      _getApproval(holder, msg.sender) >= amount,
      "ERC20: msg.sender is not approved for transfer."
    );
    _transfer(holder, recipient, amount);
  }
  
}