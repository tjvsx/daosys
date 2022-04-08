// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  UInt256,
  UInt256Utils
} from "contracts/types/primitives/UInt256.sol";
import {
  AddressToUInt256,
  AddressToUInt256Utils
} from "contracts/types/collections/mappings/AddressToUInt256.sol";
import {
  AddressToAddressToUInt256,
  AddressToAddressToUInt256Utils
} from "contracts/types/collections/mappings/AddressToAddressToUInt256.sol";

library ERC20AccountStorage {

  struct Layout {
    UInt256.Layout totalSupply;
    AddressToUInt256.Layout balanceForAccount;
    AddressToAddressToUInt256.Layout approvalAmountForSpenderForAccount;
  }

}

library ERC20AccountUtils {

  using ERC20AccountUtils for ERC20AccountStorage.Layout;

  bytes32 constant private STRUCT_STORAGE_SLOT = keccak256(type(ERC20AccountStorage).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT
      ^ UInt256Utils._structSlot()
      ^ AddressToUInt256Utils._structSlot()
      ^ AddressToAddressToUInt256Utils._structSlot();
  }

  function _layout(bytes32 salt) pure internal returns (ERC20AccountStorage.Layout storage layout) {
    bytes32 saltedSlot =
      salt
      ^ ERC20AccountUtils._structSlot();
    assembly{ layout.slot := saltedSlot }
  }

  function _setTotalSupply(
    ERC20AccountStorage.Layout storage layout,
    uint256 newTotalSupply
  ) internal {
    layout.totalSupply.value = newTotalSupply;
  }

  function _getTotalSupply(
    ERC20AccountStorage.Layout storage layout
  ) view internal returns (uint256 totalSupply) {
    totalSupply = layout.totalSupply.value;
  }

  function _setBalance(
    ERC20AccountStorage.Layout storage layout,
    address account,
    uint256 newBalance
  ) internal {
    layout.balanceForAccount.value[account].value = newBalance;
  }

  function _getBalance(
    ERC20AccountStorage.Layout storage layout,
    address accountQuery
  ) view internal returns (uint256 balance) {
    balance = layout.balanceForAccount.value[accountQuery].value;
  }

  function _setApproval(
    ERC20AccountStorage.Layout storage layout,
    address account,
    address spender,
    uint256 newLimit
  ) internal {
    layout.approvalAmountForSpenderForAccount.value[account][spender].value = newLimit;
  }

  function _getApproval(
    ERC20AccountStorage.Layout storage layout,
    address accountQuery,
    address spenderQuery
  ) view internal returns (uint256 limit) {
    limit = layout.approvalAmountForSpenderForAccount.value[accountQuery][spenderQuery].value;
  }
  
}