// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  DelegateServiceInternal,
  DelegateServiceStorage,
  DelegateServiceStorageUtils
} from "contracts/service/delegate/internal/DelegateServiceInternal.sol";
import {IDelegateService} from "contracts/service/delegate/interfaces/IDelegateService.sol";

abstract contract DelegateService is IDelegateService, DelegateServiceInternal {

  using DelegateServiceStorageUtils for DelegateServiceStorage.Layout;

  function setServiceDef(
    bytes4 interfaceId,
    bytes4[] memory functionSelectors
  ) external {
    _setServiceDef(
      type(IDelegateService).interfaceId,
      interfaceId,
      functionSelectors
    );
  }

  function getServiceDef() view external returns (ServiceDef memory serviceDef) {
    (serviceDef.interfaceId, serviceDef.functionSelectors) = DelegateServiceStorageUtils
      ._layout(type(IDelegateService).interfaceId)
      ._getServiceDef();
  }

}