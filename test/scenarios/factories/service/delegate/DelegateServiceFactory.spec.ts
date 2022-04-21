import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  DelegateServiceFactoryMock,
  DelegateServiceFactoryMock__factory,
  MessengerDelegateService,
  MessengerDelegateService__factory,
  DelegateServiceRegistryMock,
  DelegateServiceRegistryMock__factory
} from '../../../../../typechain';

describe('Delegate Service Factory', function () {

  // Control values for tests
  const invalidInterfaceId = "0xffffffff";
  const Bytes4Zero = "0x00000000";

  // Test Wallets
  let deployer: SignerWithAddress;

  let delegateServiceRegistry: DelegateServiceRegistryMock;
  const IDelegateServiceRegistryInterfaceId = '0xb0184e40';
  const queryDelegateServiceAddressFunctionSelector = '0x03714859';
  const bulkQueryDelegateServiceAddressFunctionSelector = '0xb3690619';

  // let messengerDelegateService: MessengerDelegateService;
  // const IDelegateServiceInterfaceId = '0xd56eb69e';
  // const getServiceDefFunctionSelector = '0xd56eb69e';
  // const IMessengerInterfaceId = "0xf8e6c6ac";
  // const setMessageFunctionSelector = '0x368b8772';
  // const getMessageFunctionSelector = '0xce6d41de';

  let delegateServiceFactory: DelegateServiceFactoryMock;
  const IDelegateServiceFactoryInterfaceId = '0x257a53af';
  const deployDelegateServiceFunctionSelector = '0x325a5ba5';
  const getDelegateServiceRegistryFunctionSelector = '0x1720080a';

  /* -------------------------------------------------------------------------- */
  /*                        SECTION Before All Test Hook                        */
  /* -------------------------------------------------------------------------- */

  before(async function () {
    // Tagging address(0) as "System" in logs.
    tracer.nameTags[ethers.constants.AddressZero] = "System";
  })

  /* -------------------------------------------------------------------------- */
  /*                       !SECTION Before All Test Hook                        */
  /* -------------------------------------------------------------------------- */

  beforeEach(async function () {

    [
      deployer
    ] = await ethers.getSigners();
    tracer.nameTags[deployer.address] = "Deployer";

    delegateServiceRegistry = await new DelegateServiceRegistryMock__factory(deployer).deploy();
    tracer.nameTags[delegateServiceRegistry.address] = "Delegate Service Registry";

    delegateServiceFactory = await new DelegateServiceFactoryMock__factory(deployer).deploy();
    tracer.nameTags[delegateServiceFactory.address] = "Delegate Service Factory";

    // messengerDelegateService = await new MessengerDelegateService__factory(deployer).deploy();
    // tracer.nameTags[messengerDelegateService.address] = "Messenger Delegate Service";

  });

  describe('DelegateServiceFactory', function () {

    describe("Validate interface and function selector computation", function () {
      it("IDelegateServiceRegistryInterfaceId.", async function () {
        expect(await delegateServiceRegistry.IDelegateServiceRegistryInterfaceId())
          .to.equal(IDelegateServiceRegistryInterfaceId);
      });
      it("queryDelegateServiceAddressFunctionSelector.", async function () {
        expect(await delegateServiceRegistry.queryDelegateServiceAddressFunctionSelector())
          .to.equal(queryDelegateServiceAddressFunctionSelector);
      });
      it("bulkQueryDelegateServiceAddressFunctionSelector.", async function () {
        expect(await delegateServiceRegistry.bulkQueryDelegateServiceAddressFunctionSelector())
          .to.equal(bulkQueryDelegateServiceAddressFunctionSelector);
      });
      it("IDelegateServiceFactoryInterfaceId.", async function () {
        expect(await delegateServiceFactory.IDelegateServiceFactoryInterfaceId())
          .to.equal(IDelegateServiceFactoryInterfaceId);
      });
      it("deployDelegateServiceFunctionSelector.", async function () {
        expect(await delegateServiceFactory.deployDelegateServiceFunctionSelector())
          .to.equal(deployDelegateServiceFunctionSelector);
      });
      it("getDelegateServiceRegistryFunctionSelector.", async function () {
        expect(await delegateServiceFactory.getDelegateServiceRegistryFunctionSelector())
          .to.equal(getDelegateServiceRegistryFunctionSelector);
      });
    });

    // describe("Validate interface and function selector computation", function () {
    //   it("IDelegateServiceRegistryInterfaceId.", async function () {
    //     expect(await delegateServiceFactory.IMessengerInterfaceId())
    //       .to.equal(IMessengerInterfaceId);
    //   });
    //   it("queryDelegateServiceAddressFunctionSelector.", async function () {
    //     expect(await messengerDelegateService.setMessageFunctionSelector())
    //       .to.equal(setMessageFunctionSelector);
    //   });
    //   it("bulkQueryDelegateServiceAddressFunctionSelector.", async function () {
    //     expect(await messengerDelegateService.getMessageFunctionSelector())
    //       .to.equal(getMessageFunctionSelector);
    //   });

    // });

    // describe('#_deploy', function () {
    //   describe('(bytes)', function () {
    //     it('deploys bytecode and returns deployment address', async function () {
    //       const initCode = instance.deployTransaction.data;

    //       const address = await instance.callStatic['deploy(bytes)'](initCode);
    //       expect(address).to.be.properAddress;

    //       await instance['deploy(bytes)'](initCode);

    //       expect(await ethers.provider.getCode(address)).to.equal(
    //         await ethers.provider.getCode(instance.address),
    //       );
    //     });

    //     describe('reverts if', function () {
    //       it('contract creation fails', async function () {
    //         const initCode = '0xfe';

    //         await expect(instance['deploy(bytes)'](initCode)).to.revertedWith(
    //           'Factory: failed deployment',
    //         );
    //       });
    //     });
    //   });

    //   describe('(bytes,bytes32)', function () {
    //     it('deploys bytecode and returns deployment address', async function () {
    //       const initCode = await instance.deployTransaction.data;
    //       const initCodeHash = ethers.utils.keccak256(initCode);
    //       const salt = ethers.utils.randomBytes(32);

    //       const address = await instance.callStatic['deployWithSalt(bytes,bytes32)'](
    //         initCode,
    //         salt,
    //       );
    //       expect(address).to.equal(
    //         await instance.callStatic.calculateDeploymentAddress(
    //           initCodeHash,
    //           salt,
    //         ),
    //       );

    //       await instance['deployWithSalt(bytes,bytes32)'](initCode, salt);

    //       expect(await ethers.provider.getCode(address)).to.equal(
    //         await ethers.provider.getCode(instance.address),
    //       );
    //     });

    //     describe('reverts if', function () {
    //       it('contract creation fails', async function () {
    //         const initCode = '0xfe';
    //         const salt = ethers.utils.randomBytes(32);

    //         await expect(
    //           instance['deployWithSalt(bytes,bytes32)'](initCode, salt),
    //         ).to.revertedWith('Factory: failed deployment');
    //       });

    //       it('salt has already been used', async function () {
    //         const initCode = instance.deployTransaction.data;
    //         const salt = ethers.utils.randomBytes(32);

    //         await instance['deployWithSalt(bytes,bytes32)'](initCode, salt);

    //         await expect(
    //           instance['deployWithSalt(bytes,bytes32)'](initCode, salt),
    //         ).to.be.revertedWith('Factory: failed deployment');
    //       });
    //     });
    //   });
    // });

    // describe('#_calculateDeploymentAddress', function () {
    //   it('returns address of not-yet-deployed contract', async function () {
    //     const initCode = instance.deployTransaction.data;
    //     const initCodeHash = ethers.utils.keccak256(initCode);
    //     const salt = ethers.utils.randomBytes(32);

    //     expect(
    //       await instance.callStatic.calculateDeploymentAddress(initCodeHash, salt),
    //     ).to.equal(
    //       ethers.utils.getCreate2Address(instance.address, salt, initCodeHash),
    //     );
    //   });
    // });
  });
});