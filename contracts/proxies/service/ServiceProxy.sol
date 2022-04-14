// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

// import {Proxy} from "../Proxy.sol";
// import {IDelegateService} from "../../service/delegate/interfaces/IDelegateService.sol";
// import {Address} from "../../types/Address.sol";
// import {
//   ServiceProxyInternal,
//   ServiceProxyLib,
//   ServiceProxyStorage,
//   Address,
//   AddressSet,
//   Bytes4,
//   Bytes4Set
// } from "./internal/ServiceProxyInternal.sol";
// /**
//  * @title Base proxy contract
//  */
// contract ServiceProxy is ServiceProxyInternal {

//   using Address for address;

//   /**
//    * @notice get logic implementation address
//    * @return implementation address
//    */
//   function _getImplementation() virtual internal returns (address implementation) {
//     implementation = _getDelegateService(msg.sig);
//   }

//   // TODO Add validation that DelegateService came from platform factory and is registered.
//   function registerDelegateService(
//     address newDelegateService
//   ) external returns (bool result) {
//     IDelegateService.
//     result = true;
//   }

//   function registerRawDelegateService(
//     address newDelegateService,
//     bytes4 newDelegateServiceInterfaceId,
//     bytes4[] memory newDelegateServiceFunctionSelectors
//   ) external {
//     _registerDelegateService(newDelegateService, newDelegateServiceInterfaceId, newDelegateServiceFunctionSelectors);
//   }

//   function deregisterDelegateService(
//     address deprecatedDelegateService
//   ) external {
//     _deregisterDelegateService(deprecatedDelegateService);
//   }

//   function getDelegateService(
//     bytes4 functionSelector   
//   ) view external returns (address delegateService) {
//     delegateService = _getDelegateService(functionSelector);
//   }
// }
