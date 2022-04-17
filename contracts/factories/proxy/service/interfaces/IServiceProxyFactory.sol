// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

interface IServiceProxyFactory {

  function calculateDeploymentAddress(
    bytes32 initCodeHash,
    bytes32 salt
  ) view external returns (address newAddress);

  function deployServiceProxy(
    bytes4[] calldata delegateServiceInterfaceIds
  ) external returns (address newServiceProxy);

}