// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  DelegateServiceLogic,
  DelegateServiceStorage,
  DelegateServiceStorageUtils
} from "contracts/service/delegate/logic/DelegateServiceLogic.sol";
import {IDelegateService} from "contracts/service/delegate/interfaces/IDelegateService.sol";
import {IDelegateServiceFactory} from "contracts/factories/service/delegate/interfaces/IDelegateServiceFactory.sol";
import {
  IDelegateServiceRegistry
} from "contracts/registries/service/delegate/interfaces/IDelegateServiceRegistry.sol";

abstract contract DelegateService is IDelegateService, DelegateServiceLogic {

  using DelegateServiceStorageUtils for DelegateServiceStorage.Layout;

  function _setServiceDef(
    bytes4 interfaceId,
    bytes4[] memory functionSelectors,
    address bootstrapper,
    bytes4 bootstrapperInitFunction
  ) internal {
    _setServiceDef(
      type(IDelegateService).interfaceId,
      interfaceId,
      functionSelectors,
      bootstrapper,
      bootstrapperInitFunction
    );
  }

  function registerDelegateService() external returns (bool success) {
    address delegateServiceRegistry = IDelegateServiceFactory(msg.sender).getDelegateServiceRegistry();
    IDelegateServiceRegistry(delegateServiceRegistry).selfRegisterDelegateService(address(this));
    success = true;
  }

  function getServiceDef() view external returns (ServiceDef memory serviceDef) {
    (
      serviceDef.interfaceId,
      serviceDef.functionSelectors,
      serviceDef.bootstrapper,
      serviceDef.bootstrapperInitFunction
    ) = DelegateServiceStorageUtils._layout(type(IDelegateService).interfaceId)
      ._getServiceDef();
  }

}