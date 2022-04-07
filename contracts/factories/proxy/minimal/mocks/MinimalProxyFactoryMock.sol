// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {MinimalProxyFactoryInternal} from '../internal/MinimalProxyFactoryInternal.sol';

contract MinimalProxyFactoryMock is MinimalProxyFactoryInternal {
  function __deployMinimalProxy(address target) external returns (address minimalProxy) {
    return _deployMinimalProxy(target);
  }

  function __deployMinimalProxyWithSalt(address target, bytes32 salt) external returns (address minimalProxy) {
    return _deployMinimalProxyWithSalt(target, salt);
  }

  function __calculateMinimalProxyDeploymentAddress(address target, bytes32 salt) external view returns (address) {
    return _calculateMinimalProxyDeploymentAddress(target, salt);
  }

  function __generateMinimalProxyInitCode(address target) external pure returns (bytes memory) {
    return _generateMinimalProxyInitCode(target);
  }
}
