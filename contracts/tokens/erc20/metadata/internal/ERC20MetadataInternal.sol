// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ERC20MetadataLib,
  ERC20MetadataStorage
} from "../libraries/ERC20MetadataLib.sol";

abstract contract ERC20MetadataInternal {

  using ERC20MetadataLib for ERC20MetadataStorage.Layout;

  function _setName(
    string memory name
  ) internal {
    ERC20MetadataLib._layout(ERC20MetadataLib._getDefaultSlot())
      ._setName(name);
  }

  function _getName() view internal returns (string memory name) {
    name = ERC20MetadataLib._layout(ERC20MetadataLib._getDefaultSlot())
      ._getName();
  }

  function _setSymbol(
    string memory symbol
  ) internal {
    ERC20MetadataLib._layout(ERC20MetadataLib._getDefaultSlot())
      ._setSymbol(symbol);
  }

  function _getSymbol() view internal returns (string memory symbol) {
    symbol = ERC20MetadataLib._layout(ERC20MetadataLib._getDefaultSlot())
      ._getSymbol();
  }

  function _setDecimals(
    uint8 decimals
  ) internal {
    ERC20MetadataLib._layout(ERC20MetadataLib._getDefaultSlot())
      ._setDecimals(decimals);
  }

  function _getDecimals() view internal returns (uint8 decimals) {
    decimals = ERC20MetadataLib._layout(ERC20MetadataLib._getDefaultSlot())
      ._getDecimals();
  }
  
}