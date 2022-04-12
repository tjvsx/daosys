// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import "../../introspection/erc165/ERC165.sol";

import { IMooniswapManager } from "./interfaces/IMooniswapManager.sol";
import { MooniswapManagerInternal } from "./internal/MooniswapManagerInternal.sol";

contract MooniswapManagerInitalizer is ERC165, MooniswapManagerInternal {
    address poolAddress;

    constructor(address _poolAddress){
        poolAddress = _poolAddress;
    }

    function initalizeMooniswapManager() external {
        _setMooniswapPoolAddress(type(IMooniswapManager).interfaceId, poolAddress);
    }

    function supportsInterface(bytes4 interfaceID) external pure override returns(bool){
        return
            interfaceID == this.supportsInterface.selector ||
            interfaceID == this.initalizeMooniswapManager.selector;
    }
}