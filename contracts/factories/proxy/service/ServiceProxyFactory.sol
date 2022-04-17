// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  IDelegateServiceRegistry,
  DelegateServiceRegistry
} from "contracts/registries/service/delegate/DelegateServiceRegistry.sol";
import {
  ServiceProxyFactoryLogic
} from "contracts/factories/proxy/service/logic/ServiceProxyFactoryLogic.sol";
import {
  MinimalProxyFactoryLogic
} from "contracts/factories/proxy/minimal/logic/MinimalProxyFactoryLogic.sol";
import {
  IServiceProxy
} from "contracts/proxies/service/interfaces/IServiceProxy.sol";
import {
  FactoryInternal
} from "contracts/factories/internal/FactoryInternal.sol";
import {
  IServiceProxyFactory
} from "contracts/factories/proxy/service/interfaces/IServiceProxyFactory.sol";
// import {MinimalProxyFactoryInternal} from '../minimal/internal/MinimalProxyFactoryInternal.sol';
// import {IDelegateService, DelegateService, DelegateServiceInternal} from "../../../service/delegate/DelegateService.sol";
// import {FactoryInternal} from "../../internal/FactoryInternal.sol";
// import {IServiceProxyFactory} from "./interfaces/IServiceProxyFactory.sol";

contract ServiceProxyFactory
  is
    IServiceProxyFactory,
    ServiceProxyFactoryLogic,
    MinimalProxyFactoryLogic,
    FactoryInternal
{

  // address public delegateServiceRegistry;

  bytes4 constant private invalidInterfaceId = 0xffffffff;

  /**
   * @notice calculate the _deployMetamorphicContract deployment address for a given salt
   * @param initCodeHash hash of contract initialization code
   * @param salt input for deterministic address calculation
   * @return newAddress deployment address
   */
  function calculateDeploymentAddress (bytes32 initCodeHash, bytes32 salt) external view returns (address newAddress) {
    newAddress = _calculateDeploymentAddress(initCodeHash, salt);
  }

  function calculateMinimalProxyDeploymentAddress(address target, bytes32 salt) external view returns (address) {
    return _calculateMinimalProxyDeploymentAddress(target, salt);
  }

  function generateMinimalProxyInitCode(address target) external pure returns (bytes memory) {
    return _generateMinimalProxyInitCode(target);
  }

  function calculateDeploymentSalt(
    address deployer,
    bytes4[] calldata delegateServiceInterfaceIds
  ) pure external returns (bytes32 deploymentSalt) {
    deploymentSalt = _calculateDeploymentSalt(
        deployer,
        delegateServiceInterfaceIds
      );
  }

  function _calculateDeploymentSalt(
    address deployer,
    bytes4[] calldata delegateServiceInterfaceIds
  ) pure internal returns (bytes32 deploymentSalt) {
    deploymentSalt = bytes32(bytes20(deployer)) ^ _calculateServiceID(
        delegateServiceInterfaceIds
      );
  }

  function _calculateServiceID(
    bytes4[] calldata serviceInterfaceIds
  ) pure internal returns (bytes4 newServiceID) {
    for(uint16 iteration = 0; serviceInterfaceIds.length > iteration; iteration++) {
      newServiceID = newServiceID ^ serviceInterfaceIds[iteration];
    }
  }

  function deployServiceProxy(
    bytes4[] calldata delegateServiceInterfaceIds
  ) external returns (address newServiceProxy) {

    address serviceProxyTarget = IDelegateServiceRegistry(
        _getDelegateServiceRegistry(type(IServiceProxyFactory).interfaceId)
      ).queryDelegateServiceAddress(type(IServiceProxy).interfaceId);

    address[] memory delegateServices = IDelegateServiceRegistry(
        _getDelegateServiceRegistry(type(IServiceProxyFactory).interfaceId)
      ).bulkQueryDelegateServiceAddress(delegateServiceInterfaceIds);

    // bytes4 newProxyServiceId = _calculateServiceID(
    //     delegateServiceInterfaceIds
    //   );

    // bytes32 deploymentSalt = _calculateDeploymentSalt(msg.sender, delegateServiceInterfaceIds);
    
    newServiceProxy = _deployMinimalProxyWithSalt(
        serviceProxyTarget,
        _calculateDeploymentSalt(msg.sender, delegateServiceInterfaceIds)
      );

    IServiceProxy(newServiceProxy).initializeServiceProxy(delegateServices);

    // for(uint16 iteration = 0; delegateServiceInterfaceIds.length > iteration; iteration++) {
    //   address defaultDelegateService = IDelegateServiceRegistry(delegateServiceRegistry).getDefaultDelegateService(delegateServiceInterfaceIds[iteration]);
    //   // bytes4[] memory delegateServiceFunctions = IDelegateService(defaultDelegateService).getDelegateServiceFunctions();
    //   require(
    //     IServiceProxy(newServiceProxy).delegateService(
    //       defaultDelegateService
    //     )
    //   );
    // }

  }

  // constructor() {
  //   bytes4[] memory serviceProxyFactoryFunctions = new bytes4[](2);
  //   serviceProxyFactoryFunctions[0] = IServiceProxyFactory.setDelegateServiceRegistry.selector;
  //   serviceProxyFactoryFunctions[1] = IServiceProxyFactory.deployServiceProxy.selector;
  //   _publishDelegateServiceSelf(
  //     type(IServiceProxyFactory).interfaceId,
  //     serviceProxyFactoryFunctions
  //   );
  // }

  // // TODO Remove and integrate into deployment.
  // function setDelegateServiceRegistry(
  //   address newDelegateServiceRegistry
  // ) external returns (bool result) {
  //   delegateServiceRegistry = newDelegateServiceRegistry;
  //   result = true;
  // }

  
  
  /**
   * @dev Not intended for public use.
   *  This exists for access to the raw ability to configure a new proxy.
   */
  // TODO Remove after development.
  // function deployServiceProxyRaw(
  //   address serviceProxy,
  //   address delegateServiceTarget,
  //   bytes4[] memory delegateServiceFunctions
  // ) external returns (address newServiceProxy) {
  //   newServiceProxy = _deployMinimalProxy(serviceProxy);

  //   require(
  //     IServiceProxy(newServiceProxy).registerRawDelegateService(
  //       delegateServiceTarget,
  //       delegateServiceFunctions
  //     )
  //   );

  // }

}