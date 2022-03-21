// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

library ERC20MetadataStorage {

  struct Layout {
    string name;
    string symbol;
    uint8 decimals;
  }

  function _layout(bytes32 slot) pure internal returns (Layout storage layout) {
    assembly{ layout.slot := slot }
  }

}