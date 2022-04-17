// SPDX-License-Identifier: AGPL-3.0-or-later

/* -------------------------------------------------------------------------- */
/*                       SECTION DelegateServiceFactory                       */
/* -------------------------------------------------------------------------- */

pragma solidity ^0.8.0;

// import {
//   DelegateServiceFactoryInternal
// } from "./internal/DelegateServiceFactoryInternal.sol";
// import {
//   IDelegateService,
//   DelegateService
// } from "../../../service/delegate/DelegateService.sol";
// import {IDelegateServiceFactory} from "./interfaces/IDelegateServiceFactory.sol";
// import {
//   IDelegateServiceRegistry,
//   DelegateServiceRegistryInternal,
//   DelegateServiceRegistryUtils,
//   DelegateServiceRegistryStorage
// } from "../../../registries/service/delegate/internal/DelegateServiceRegistryInternal.sol";

// contract DelegateServiceFactory
//   is
//     DelegateServiceFactoryInternal,
//     DelegateService
// {

//   using DelegateServiceRegistryUtils for DelegateServiceRegistryStorage.Layout;

//   constructor() DelegateService() {
//     bytes4[] memory delegateServiceFunctions = new bytes4[](1);
//     delegateServiceFunctions[0] = IDelegateServiceFactory.deployDelegateService.selector;
//     _publishDelegateServiceSelf(
//       type(IDelegateServiceFactory).interfaceId,
//       delegateServiceFunctions
//     );
//   }

//   // TODO Restrict to Ownable
//   // TODO Implement RBAC NFT
//   function deployDelegateService(
//     bytes memory delegateServiceCreationCode,
//     bytes32 delegateServiceInterfaceId
//   ) external returns (address delegateService) {
//     delegateService = _deployDelegateService(delegateServiceCreationCode, delegateServiceInterfaceId);
//   }

// }
/* -------------------------------------------------------------------------- */
/*                       !SECTION DelegateServiceFactory                      */
/* -------------------------------------------------------------------------- */