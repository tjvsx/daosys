// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Bytes4Set,
  Bytes4SetUtils
} from "../../../types/collections/sets/Bytes4Set.sol";

library ERC165Storage {

  using Bytes4SetUtils for Bytes4Set.Enumerable;

  struct Layout {
    Bytes4Set.Layout supportedInterfaces;
  }

  function _layout(bytes32 slot) internal pure returns (Layout storage layout) {
    assembly { layout.slot := slot }
  }

}

library ERC165Utils {

  using Bytes4SetUtils for Bytes4Set.Enumerable;
  // using ERC165Lib for ERC165Storage.Layout;

  bytes32 private constant STORAGE_SLOT = keccak256(type(ERC165Storage).creationCode);

  function _getDefaultSlot() internal pure returns ( bytes32 defaultSlot ) {
    defaultSlot = STORAGE_SLOT;
  }

  function _layout( bytes32 slot ) internal pure returns (ERC165Storage.Layout storage layout) {
    layout = ERC165Storage._layout(slot);
  }

  function _isSupportedInterface(
    ERC165Storage.Layout storage layout,
    bytes4 interfaceId
  ) internal view returns (bool) {
    return layout.supportedInterfaces.set._contains(interfaceId);
  }

  function _setSupportedInterface(
    ERC165Storage.Layout storage layout,
    bytes4 interfaceId
  ) internal {
    require(interfaceId != 0xffffffff, 'ERC165: invalid interface id');
    layout.supportedInterfaces.set._add(interfaceId);
  }

  function _removeSupportedInterface(
    ERC165Storage.Layout storage layout,
    bytes4 interfaceId
  ) internal {
    layout.supportedInterfaces.set._remove(interfaceId);
  }
  
}