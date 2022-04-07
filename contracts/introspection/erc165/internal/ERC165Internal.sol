// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {IERC165} from "../interfaces/IERC165.sol";
import {
  ERC165Utils,
  ERC165Storage,
  Bytes4Set,
  Bytes4SetUtils
} from "../storage/ERC165Storage.sol";

/**
 * @title ERC165 implementation
 */
abstract contract ERC165Internal {

  using Bytes4SetUtils for Bytes4Set.Enumerable;
  using ERC165Utils for ERC165Storage.Layout;

  function _isSupportedInterface(
    bytes4 interfaceId
  ) virtual internal view returns (bool isSupportInterface) {
    isSupportInterface = ERC165Utils._layout( ERC165Utils._getDefaultSlot() )._isSupportedInterface(interfaceId);
  }

  function _setSupportedInterface(
    bytes4 interfaceId
  ) virtual internal {
    ERC165Utils._layout( ERC165Utils._getDefaultSlot() )._setSupportedInterface(interfaceId);
  }

  function _removeSupportedInterface(
    bytes4 interfaceId
  ) virtual internal {
    ERC165Utils._layout( ERC165Utils._getDefaultSlot() )._removeSupportedInterface(interfaceId);
  }
  
}
