using AElf.Cryptography.ECDSA;
using AElf.Testing.TestBase;

namespace AElf.Contracts.MyCharacter
{
    // The Module class load the context required for unit testing
    public class Module : ContractTestModule<MyCharacter>
    {
        
    }
    
    // The TestBase class inherit ContractTestBase class, it defines Stub classes and gets instances required for unit testing
    public class TestBase : ContractTestBase<Module>
    {
        // The Stub class for unit testing
        internal readonly MyCharacterContainer.MyCharacterStub MyCharacterStub;
        // A key pair that can be used to interact with the contract instance
        private ECKeyPair DefaultKeyPair => Accounts[0].KeyPair;

        public TestBase()
        {
            MyCharacterStub = GetMyCharacterContractStub(DefaultKeyPair);
        }

        private MyCharacterContainer.MyCharacterStub GetMyCharacterContractStub(ECKeyPair senderKeyPair)
        {
            return GetTester<MyCharacterContainer.MyCharacterStub>(ContractAddress, senderKeyPair);
        }
    }
    
}