// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {ERC20AccountLib, ERC20AccountStorage} from "../libraries/ERC20AccountLib.sol";

abstract contract ERC20AccountInternal {

  using ERC20AccountLib for ERC20AccountStorage.Layout;

  function _setTotalSupply(
    uint256 newTotalSupply
  ) internal {
    ERC20AccountLib._layout(ERC20AccountLib._getDefaultSlot())
      ._setTotalSupply(newTotalSupply);
  }

  function _getTotalSupply() view internal returns (uint256 totalSupply) {
    totalSupply = ERC20AccountLib._layout(ERC20AccountLib._getDefaultSlot())
      ._getTotalSupply();
  }

  function _setBalance(
    address account,
    uint256 newBalance
  ) internal {
    ERC20AccountLib._layout(ERC20AccountLib._getDefaultSlot())
      ._setBalance(account, newBalance);
  }

  function _getBalance(
    address accountQuery
  ) view internal returns (uint256 balance) {
    balance = ERC20AccountLib._layout(ERC20AccountLib._getDefaultSlot())
      ._getBalance(accountQuery);
  }

  function _setApproval(
    address account,
    address spender,
    uint256 newLimit
  ) internal {
    ERC20AccountLib._layout(ERC20AccountLib._getDefaultSlot())
      ._setApproval(account, spender, newLimit);
  }

  function _getApproval(
    address accountQuery,
    address spenderQuery
  ) view internal returns (uint256 limit) {
    limit = ERC20AccountLib._layout(ERC20AccountLib._getDefaultSlot())
      ._getApproval(accountQuery, spenderQuery);
  }
  
}