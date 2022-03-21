// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {ERC20MetadataStorage} from "../storage/ERC20MetadataStorage.sol";

library ERC20MetadataLib {

  using ERC20MetadataLib for ERC20MetadataStorage.Layout;

  bytes32 constant private STORAGE_SLOT = keccak256(type(ERC20MetadataStorage).creationCode);

  function _getDefaultSlot() pure internal returns (bytes32 defaultSlot) {
    defaultSlot = STORAGE_SLOT;
  }

  function _layout(bytes32 slot) pure internal returns (ERC20MetadataStorage.Layout storage layout) {
    layout = ERC20MetadataStorage._layout(slot);
  }

  function _setName(
    ERC20MetadataStorage.Layout storage layout,
    string memory name
  ) internal {
    layout.name = name;
  }

  function _getName(
    ERC20MetadataStorage.Layout storage layout
  ) view internal returns (string memory name) {
    name = layout.name;
  }

  function _setSymbol(
    ERC20MetadataStorage.Layout storage layout,
    string memory symbol
  ) internal {
    layout.symbol = symbol;
  }

  function _getSymbol(
    ERC20MetadataStorage.Layout storage layout
  ) view internal returns (string memory symbol) {
    symbol = layout.symbol;
  }

  function _setDecimals(
    ERC20MetadataStorage.Layout storage layout,
    uint8 decimals
  ) internal {
    layout.decimals = decimals;
  }

  function _getDecimals(
    ERC20MetadataStorage.Layout storage layout
  ) view internal returns (uint8 decimals) {
    decimals = layout.decimals;
  }
  
}