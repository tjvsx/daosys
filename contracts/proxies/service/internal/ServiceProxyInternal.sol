// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

// import {
//   ServiceProxyLib,
//   ServiceProxyStorage,
//   Address,
//   AddressSet,
//   Bytes4,
//   Bytes4Set
// } from "../libraries/ServiceProxyLib.sol";

// abstract contract ServiceProxyInternal {

//   using Address for AddressSet.Enumerable;
//   using Bytes4 for Bytes4Set.Enumerable;
//   using ServiceProxyLib for ServiceProxyStorage.Layout;

//   function _registerDelegateService(
//     address newDelegateService,
//     bytes4 newDelegateServiceInterfaceId,
//     bytes4[] memory newDelegateServiceFunctionSelectors
//   ) internal {
//     ServiceProxyLib._layout( ServiceProxyLib._getDefaultSlot() )
//       ._registerDelegateService(newDelegateService, newDelegateServiceInterfaceId, newDelegateServiceFunctionSelectors);
//   }

//   function _deregisterDelegateService(
//     address deprecatedDelegateService
//   ) internal {
//     ServiceProxyLib._layout( ServiceProxyLib._getDefaultSlot() )
//       ._deregisterDelegateService(deprecatedDelegateService);
//   }

//   function _getDelegateService(
//     bytes4 functionSelector   
//   ) view internal returns (address delegateService) {
//     delegateService = ServiceProxyLib._layout( ServiceProxyLib._getDefaultSlot() )
//       ._getDelegateService(functionSelector);
//   }

// }