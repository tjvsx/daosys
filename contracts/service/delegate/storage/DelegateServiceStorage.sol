// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Bytes4,
  Bytes4Utils
} from "contracts/types/primitives/Bytes4.sol";
import {
  Bytes4Set,
  Bytes4SetUtils
} from "contracts/types/collections/sets/Bytes4Set.sol";
import {IDelegateService} from "contracts/service/delegate/interfaces/IDelegateService.sol";

library DelegateServiceStorage {

  struct Layout {
    Bytes4.Layout interfaceId;
    Bytes4Set.Layout functionSelectors;
  }

}

library DelegateServiceStorageUtils {

  using Bytes4SetUtils for Bytes4Set.Enumerable;

  bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(DelegateServiceStorage).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT;
  }

  function _layout( bytes32 salt ) pure internal returns ( DelegateServiceStorage.Layout storage layout ) {
    bytes32 saltedSlot = salt
      ^ DelegateServiceStorageUtils._structSlot()
      ^ Bytes4Utils._structSlot()
      ^ Bytes4SetUtils._structSlot();
    assembly{ layout.slot := saltedSlot }
  }

  function _setServiceDef(
    DelegateServiceStorage.Layout storage layout,
    bytes4 interfaceId,
    bytes4[] memory functionSelectors
  ) internal {
    layout.interfaceId.value = interfaceId;
    for(uint16 iteration = 0; functionSelectors.length > iteration; iteration++) {
      layout.functionSelectors.set._add(functionSelectors[iteration]);
    }
  }

  function _getServiceDef(
    DelegateServiceStorage.Layout storage layout
  ) view internal returns (
    bytes4 interfaceId,
    bytes4[] memory functionSelectors
  ) {
    interfaceId = layout.interfaceId.value;
    functionSelectors = layout.functionSelectors.set._setAsArray();
  }

}