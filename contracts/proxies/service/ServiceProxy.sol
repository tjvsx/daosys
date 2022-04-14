// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {Proxy} from "../Proxy.sol";
import {
  ServiceProxyLogic
} from "contracts/proxies/service/logic/ServiceProxyLogic.sol";
import {
  IServiceProxy
} from "contracts/proxies/service/interfaces/IServiceProxy.sol";

/**
 * @title Base proxy contract
 */
contract ServiceProxy is IServiceProxy, ServiceProxyLogic, Proxy {

  /**
   * @notice get logic implementation address
   * @return implementation address
   */
  function _getImplementation() virtual override(Proxy) internal returns (address implementation) {
    implementation = _getDelegateService(
      type(IServiceProxy).interfaceId,
      msg.sig
    );
  }

  function getImplementation(
    bytes4 functionSelector   
  ) view external returns (address delegateService) {
    delegateService = _getDelegateService(
      type(IServiceProxy).interfaceId,
      functionSelector
    );
  }
}
