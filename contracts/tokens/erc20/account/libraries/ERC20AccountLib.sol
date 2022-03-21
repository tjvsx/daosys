// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {ERC20AccountStorage} from "../storage/ERC20AccountStorage.sol";

library ERC20AccountLib {

  using ERC20AccountLib for ERC20AccountStorage.Layout;

  bytes32 constant private STORAGE_SLOT = keccak256(type(ERC20AccountStorage).creationCode);

  function _getDefaultSlot() pure internal returns (bytes32 defaultSlot) {
    defaultSlot = STORAGE_SLOT;
  }

  function _layout(bytes32 slot) pure internal returns (ERC20AccountStorage.Layout storage layout) {
    layout = ERC20AccountStorage._layout(slot);
  }

  function _setTotalSupply(
    ERC20AccountStorage.Layout storage layout,
    uint256 newTotalSupply
  ) internal {
    layout.totalSupply = newTotalSupply;
  }

  function _getTotalSupply(
    ERC20AccountStorage.Layout storage layout
  ) view internal returns (uint256 totalSupply) {
    totalSupply = layout.totalSupply;
  }

  function _setBalance(
    ERC20AccountStorage.Layout storage layout,
    address account,
    uint256 newBalance
  ) internal {
    layout.balanceForAccount[account] = newBalance;
  }

  function _getBalance(
    ERC20AccountStorage.Layout storage layout,
    address accountQuery
  ) view internal returns (uint256 balance) {
    balance = layout.balanceForAccount[accountQuery];
  }

  function _setApproval(
    ERC20AccountStorage.Layout storage layout,
    address account,
    address spender,
    uint256 newLimit
  ) internal {
    layout.approvalAmountForSpenderForAccount[account][spender] = newLimit;
  }

  function _getApproval(
    ERC20AccountStorage.Layout storage layout,
    address accountQuery,
    address spenderQuery
  ) view internal returns (uint256 limit) {
    limit = layout.approvalAmountForSpenderForAccount[accountQuery][spenderQuery];
  }
  
}