using System.Diagnostics.CodeAnalysis;
using AElf.Sdk.CSharp.State;
using AElf.Standards.ACS6;
using AElf.Types;

namespace AElf.Contracts.MyCharacter
{
    // The state class is access the blockchain state
    public class MyCharacterState : ContractState 
    {
       //create a storage space for Character
        public BoolState Initialized { get; set; }
        public MappedState<Address, Character> Characters { get; set; }

        //encapsulate AEDPoS consensus contract reference state
        internal RandomNumberProvideacsrContractContainer.RandomNumberProvideacsrContractReferenceState
            RandomNumberContract { get; set; }
    }
}