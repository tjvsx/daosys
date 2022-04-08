// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  UInt8,
  UInt8Utils
} from "contracts/types/primitives/UInt8.sol";
import {
  String,
  StringUtils
} from "contracts/types/primitives/String.sol";

library ERC20MetadataStorage {

  struct Layout {
    UInt8.Layout decimals;
    String.Layout name;
    String.Layout symbol;
  }

}

library ERC20MetadataUtils {

  using ERC20MetadataUtils for ERC20MetadataStorage.Layout;

  bytes32 constant private STRUCT_STORAGE_SLOT = keccak256(type(ERC20MetadataStorage).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT
      ^ UInt8Utils._structSlot()
      ^ StringUtils._structSlot();
  }

  function _layout(bytes32 salt) pure internal returns (ERC20MetadataStorage.Layout storage layout) {
    bytes32 saltedSlot =
      salt
      ^ ERC20MetadataUtils._structSlot();
    assembly{ layout.slot := saltedSlot }
  }

  function _setName(
    ERC20MetadataStorage.Layout storage layout,
    string memory name
  ) internal {
    layout.name.value = name;
  }

  function _getName(
    ERC20MetadataStorage.Layout storage layout
  ) view internal returns (string memory name) {
    name = layout.name.value;
  }

  function _setSymbol(
    ERC20MetadataStorage.Layout storage layout,
    string memory symbol
  ) internal {
    layout.symbol.value = symbol;
  }

  function _getSymbol(
    ERC20MetadataStorage.Layout storage layout
  ) view internal returns (string memory symbol) {
    symbol = layout.symbol.value;
  }

  function _setDecimals(
    ERC20MetadataStorage.Layout storage layout,
    uint8 decimals
  ) internal {
    layout.decimals.value = decimals;
  }

  function _getDecimals(
    ERC20MetadataStorage.Layout storage layout
  ) view internal returns (uint8 decimals) {
    decimals = layout.decimals.value;
  }
  
}