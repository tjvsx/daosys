// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  DelegateServiceStorage,
  DelegateServiceStorageUtils
} from "contracts/service/delegate/storage/DelegateServiceStorage.sol";

abstract contract DelegateServiceInternal {

  using DelegateServiceStorageUtils for DelegateServiceStorage.Layout;

  function _setServiceDef(
    bytes32 storageSlot,
    bytes4 interfaceId,
    bytes4[] memory functionSelectors
  ) internal {
    DelegateServiceStorageUtils._layout(storageSlot)
      ._setServiceDef(
        interfaceId,
        functionSelectors
      );
  }

  function _getServiceDef(
    bytes32 storageSlot
  ) view internal returns (bytes4 interfaceId, bytes4[] memory functionSelectors) {
    (interfaceId, functionSelectors) = DelegateServiceStorageUtils._layout(storageSlot)
      ._getServiceDef();
  }

}