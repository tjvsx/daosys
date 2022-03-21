// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ERC20MetadataInternal,
  ERC20MetadataLib,
  ERC20MetadataStorage
} from "./internal/ERC20MetadataInternal.sol";

abstract contract ERC20Metadata is ERC20MetadataInternal {

  function _name() view internal returns (string memory tokenName) {
    tokenName = _getName();
  }

  function _symbol() view internal returns (string memory tokenSymbol) {
    tokenSymbol = _getSymbol();
  }

  function _decimals() view internal returns (uint8 tokenDecimals) {
    tokenDecimals = _getDecimals();
  }
  
}