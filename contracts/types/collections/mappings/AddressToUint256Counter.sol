// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import {
  Uint256Counter,
  Uint256CounterUtils
} from "../../counters/Uint256Counter.sol";

library AddressToUint256Counter {

  // NOTE Should only use language primitives as key pending research on the consistency of using a struct.
  struct Layout {
    mapping(address => Uint256Counter.Layout ) counterForAddress;
  }

  function _layout(bytes32 salt) pure internal returns (AddressToUint256Counter.Layout storage layout) {
    bytes32 saltedSlot =
      salt 
      ^ Uint256CounterUtils._structSlot();
    assembly{ layout.slot := saltedSlot }
  }
}

library AddressToUint256CounterUtils {

  using AddressToUint256CounterUtils for AddressToUint256Counter.Layout;

  bytes32 constant private STRUCT_STORAGE_SLOT = keccak256(type(AddressToUint256Counter).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT;
  }

  function _layout( bytes32 slot ) pure internal returns ( AddressToUint256Counter.Layout storage layout ) {
    layout = AddressToUint256Counter._layout(slot);
  }

  function _unsafeReadCountForAddress(
    AddressToUint256Counter.Layout storage layout,
    address addressQuery
  ) internal returns (uint256 lastCount) {
    lastCount = layout.counterForAddress[addressQuery].count.value;
    layout.counterForAddress[addressQuery].count.value++;
  }

}