// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  UInt256,
  UInt256Utils
} from "../primitives/UInt256.sol";

/* -------------------------------------------------------------------------- */
/*                            SECION Uint256Counter                           */
/* -------------------------------------------------------------------------- */

library UInt256Counter {

  struct Layout {
    UInt256.Layout count;
  }

}

/* -------------------------------------------------------------------------- */
/*                           !SECION Uint256Counter                           */
/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/*                         SECTION Uint256CounterUtils                        */
/* -------------------------------------------------------------------------- */

library UInt256CounterUtils {

  using UInt256CounterUtils for UInt256Counter.Layout;

  bytes32 constant private STRUCT_STORAGE_SLOT = 
    keccak256(type(UInt256Counter).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT
      ^ UInt256Utils._structSlot();
  }

  /**
   * @notice Could be optimized by having the exposing interface caclulate and store
   *  the storage slot as a constant.
   *  Storage slot is computed during runtime to facilitate development during
   *  standardization.
   */
  function _layout( bytes32 salt ) pure internal returns ( UInt256Counter.Layout storage layout ) {
    bytes32 saltedSlot =
      salt
      ^ UInt256CounterUtils._structSlot();
    assembly{ layout.slot := saltedSlot }
  }

  function _next(
    UInt256Counter.Layout storage layout
  ) internal returns (uint256 lastCount) {
    lastCount = layout.count.value;
    layout.count.value++;
  }

}

/* -------------------------------------------------------------------------- */
/*                        !SECTION Uint256CounterUtils                        */
/* -------------------------------------------------------------------------- */