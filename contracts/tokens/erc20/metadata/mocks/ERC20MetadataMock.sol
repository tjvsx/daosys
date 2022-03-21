// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ERC20Metadata,
  ERC20MetadataInternal,
  ERC20MetadataLib,
  ERC20MetadataStorage
} from "../ERC20Metadata.sol";

contract ERC20MetadataMock is ERC20Metadata {

  function setName(
    string memory tokenName
  ) external {
    _setName(tokenName);
  }

  function setSymbol(
    string memory newSymbol
  ) external {
    _setSymbol(newSymbol);
  }

  function setDecimals(
    uint8 newDecimals
  ) external {
    _setDecimals(newDecimals);
  }

  function name() view external returns (string memory tokenName) {
    tokenName = _name();
  }

  function symbol() view external returns (string memory tokenSymbol) {
    tokenSymbol = _symbol();
  }

  function decimals() view external returns (uint8 tokenDecimals) {
    tokenDecimals = _decimals();
  }

}