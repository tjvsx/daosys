// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ServiceProxy,
  IServiceProxy
} from "contracts/proxies/service/ServiceProxy.sol";
import {IDelegateService} from "contracts/service/delegate/interfaces/IDelegateService.sol";

/**
 * @title Base proxy contract
 */
contract ServiceProxyMock is ServiceProxy {

  function registerDelegateService(
    address[] memory delegateServices
  ) external returns (bool success) {

    for(uint16 iteration = 0; delegateServices.length > iteration; iteration++) {
      IDelegateService.ServiceDef memory delegateService = IDelegateService(delegateServices[iteration]).getServiceDef();
      _registerDelegateService(
        type(IServiceProxy).interfaceId,
        delegateServices[iteration],
        delegateService.functionSelectors
      );
    }
    success = true;

  }

}
