// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  IERC165,
  ERC165Internal,
  ERC165Utils,
  ERC165Storage,
  Bytes4Set,
  Bytes4SetUtils
} from './internal/ERC165Internal.sol';
// import {ERC165Lib, ERC165Storage} from './libraries/ERC165Lib.sol';

/**
 * @title ERC165 implementation
 */
abstract contract ERC165
  is 
    IERC165,
    ERC165Internal
{

  // using Bytes4SetUtils for Bytes4Set.Enumerable;
  using ERC165Utils for ERC165Storage.Layout;

  constructor() {
    ERC165._erc165Init();
  }

  function _erc165Init() internal {
    ERC165Internal._setSupportedInterface(type(IERC165).interfaceId);
  }

  function _initERC165(bytes4 interfaceId) virtual internal {
    ERC165Internal._setSupportedInterface(interfaceId);
  }

  function supportsInterface(bytes4 interfaceId) override virtual external view returns (bool) {
    return ERC165Internal._isSupportedInterface(interfaceId);
  }
  
}