// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import {
  Uint256,
  Uint256Utils
} from "../primitives/Uint256.sol";

library Uint256Counter {

  struct Layout {
    Uint256.Layout count;
  }

  function _layout(bytes32 salt) pure internal returns (Uint256Counter.Layout storage layout) {
    bytes32 saltedSlot =
      salt 
      ^ Uint256Utils._structSlot();
    assembly{ layout.slot := saltedSlot }
  }

}

library Uint256CounterUtils {

  using Uint256CounterUtils for Uint256Counter.Layout;

  bytes32 constant private STRUCT_STORAGE_SLOT = keccak256(type(Uint256Counter).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT;
  }

  function _layout( bytes32 slot ) pure internal returns ( Uint256Counter.Layout storage layout ) {
    layout = Uint256Counter._layout(slot);
  }

  function _unsafeReadCount(
    Uint256Counter.Layout storage layout
  ) internal returns (uint256 lastCount) {
    lastCount = layout.count.value;
    layout.count.value++;
  }

}