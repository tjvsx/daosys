// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ERC20MetadataInternal,
  ERC20MetadataUtils,
  ERC20MetadataStorage
} from "./internal/ERC20MetadataInternal.sol";
import {IERC20} from "contracts/tokens/erc20/interfaces/IERC20.sol";

abstract contract ERC20Metadata is ERC20MetadataInternal {

  function _name() view internal returns (string memory tokenName) {
    tokenName = _getName(type(IERC20).interfaceId);
  }

  function _symbol() view internal returns (string memory tokenSymbol) {
    tokenSymbol = _getSymbol(type(IERC20).interfaceId);
  }

  function _decimals() view internal returns (uint8 tokenDecimals) {
    tokenDecimals = _getDecimals(type(IERC20).interfaceId);
  }
  
}