// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  DelegateServiceLogic
} from "contracts/registries/service/delegate/logic/DelegateServiceRegistryLogic.sol";
import {
  IDelegateServiceRegistry
} from "contracts/registries/service/delegate/interfaces/IDelegateServiceRegistry.sol";

contract DelegateServiceRegistry
  is
    IDelegateServiceRegistry,
    DelegateServiceLogic
{

  function registerDelegateService(
    bytes4 delegateServiceInterfaceId,
    address delegateServiceAddress
  ) external {
    _registerDelegateService(
        type(IDelegateServiceRegistry).interfaceId,
        delegateServiceInterfaceId,
        delegateServiceAddress
      );
  }

  function queryDelegateServiceAddress(
    bytes4 delegateServiceInterfaceId
  ) view external returns (address delegateServiceAddress) {
    delegateServiceAddress = _queryDelegateService(
      type(IDelegateServiceRegistry).interfaceId,
      delegateServiceInterfaceId
    );
  }

  function bulkQueryDelegateServiceAddress(
    bytes4[] calldata delegateServiceInterfaceIds
  ) view external returns (address[] memory delegateServiceAddresses) {
    delegateServiceAddresses = _bulkQueryDelegateService(
      type(IDelegateServiceRegistry).interfaceId,
      delegateServiceInterfaceIds
    );
  }

}