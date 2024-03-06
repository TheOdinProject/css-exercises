using AElf.Cryptography.ECDSA;
using AElf.Testing.TestBase;

namespace AElf.Contracts.StackUpDAO
{
    // The Module class load the context required for unit testing
    public class Module : ContractTestModule<StackUpDAO>
    {
        
    }
    
    // The TestBase class inherit ContractTestBase class, it defines Stub classes and gets instances required for unit testing
    public class TestBase : ContractTestBase<Module>
    {
        // The Stub class for unit testing
        internal readonly StackUpDAOContainer.StackUpDAOStub StackUpDAOStub;
        // A key pair that can be used to interact with the contract instance
        private ECKeyPair DefaultKeyPair => Accounts[0].KeyPair;

        public TestBase()
        {
            StackUpDAOStub = GetStackUpDAOContractStub(DefaultKeyPair);
        }

        private StackUpDAOContainer.StackUpDAOStub GetStackUpDAOContractStub(ECKeyPair senderKeyPair)
        {
            return GetTester<StackUpDAOContainer.StackUpDAOStub>(ContractAddress, senderKeyPair);
        }
    }
    
}