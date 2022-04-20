// SPDX-License-Identifier: AGPL-3.0-or-later

/* -------------------------------------------------------------------------- */
/*                       SECTION DelegateServiceFactory                       */
/* -------------------------------------------------------------------------- */

pragma solidity ^0.8.0;

import {
  DelegateServiceFactoryLogic
} from "contracts/factories/service/delegate/logic/DelegateServiceFactoryLogic.sol";
import {
  IDelegateServiceFactory
} from "contracts/factories/service/delegate/interfaces/IDelegateServiceFactory.sol";
import {
  IDelegateServiceRegistry
} from "contracts/registries/service/delegate/interfaces/IDelegateServiceRegistry.sol";
import {
  IDelegateService
} from "contracts/service/delegate/interfaces/IDelegateService.sol";

contract DelegateServiceFactory
  is
    DelegateServiceFactoryLogic
{

  // TODO Restrict to Ownable
  // TODO Implement RBAC NFT
  function deployDelegateService(
    bytes memory delegateServiceCreationCode,
    bytes32 delegateServiceInterfaceId
  ) external returns (address delegateService) {
    delegateService = _deployDelegateService(delegateServiceCreationCode, delegateServiceInterfaceId);
  }

  function getDelegateServiceRegistry() view external returns (address delegateServiceRegistry) {
    delegateServiceRegistry = _getDelegateServiceRegistry(type(IDelegateServiceFactory).interfaceId);
  }

}
/* -------------------------------------------------------------------------- */
/*                       !SECTION DelegateServiceFactory                      */
/* -------------------------------------------------------------------------- */