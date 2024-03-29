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
import {
  Create2DeploymentMetadata,
  ICreate2DeploymentMetadata
} from "contracts/evm/create2/metadata/Create2DeploymentMetadata.sol";

abstract contract DelegateService
  is
    IDelegateService,
    DelegateServiceLogic,
    Create2DeploymentMetadata
{

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

  function registerDelegateService(
    bytes32 deploymentSalt
  ) external returns (bool success) {
    _setCreate2DeploymentMetaData(
      msg.sender,
      deploymentSalt
    );
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