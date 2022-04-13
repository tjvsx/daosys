// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  DelegateServiceRegistryStorage,
  DelegateServiceRegistryStorageUtils
} from "contracts/registries/service/delegate/storage/DelegateServiceStorage.sol";

abstract contract DelegateServiceLogic {

  using DelegateServiceRegistryStorageUtils for DelegateServiceRegistryStorage.Layout;

  function _registerDelegateService(
    bytes32 storageSlotSalt,
    bytes4 delegateServiceInterfaceId,
    address delegateServiceAddress
  ) internal {
    DelegateServiceRegistryStorageUtils._layout(storageSlotSalt)
      ._mapDelegateServiceAddress(
        delegateServiceInterfaceId,
        delegateServiceAddress
      );
  }

  function _queryDelegateService(
    bytes32 storageSlotSalt,
    bytes4 delegateServiceInterfaceId
  ) view internal returns (address delegateServiceAddress) {
    delegateServiceAddress = DelegateServiceRegistryStorageUtils._layout(storageSlotSalt)
      ._queryDelegateService(
        delegateServiceInterfaceId
      );
  }
  
}