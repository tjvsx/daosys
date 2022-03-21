// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

library ERC20AccountStorage {

  struct Layout {
    uint256 totalSupply;
    mapping(address => uint256) balanceForAccount;
    mapping(address => mapping(address => uint256)) approvalAmountForSpenderForAccount;
  }

  function _layout(bytes32 slot) pure internal returns (Layout storage layout) {
    assembly{ layout.slot := slot }
  }

}