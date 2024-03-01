using AElf.Sdk.CSharp;
using AElf.Types;
using Google.Protobuf.WellKnownTypes;

namespace AElf.Contracts.MyCharacter
{
    // Contract class must inherit the base class generated from the proto file
    public class MyCharacter : MyCharacterContainer.MyCharacterBase
    {
        // adding this line is for preparing the contract deployment later,
        // to differentiate each person's contract.
        // This is because our testnet does not allow the deployment of two identical contracts.
        const string author = "your name";

        public override Empty Initialize(Empty input)
        {
            Assert(!State.Initialized.Value, "already initialized");
            State.RandomNumberContract.Value =
                Context.GetContractAddressByName(SmartContractConstants.ConsensusContractSystemName);
            return new Empty();
        }

        public override Character CreateCharacter(Empty input)
        {
            var randomBytes = State.RandomNumberContract.GetRandomBytes
                .Call(new Int64Value { Value = Context.CurrentHeight - 1 }.ToBytesValue()).Value.ToByteArray();
            var hash = HashHelper.ComputeFrom(Context.Sender).Value.ToByteArray();

            var character = new Character
            {
                Health = 60 + (randomBytes[2] ^ hash[2]) % 41, // Health is 60 ~ 100
                Strength = 40 + (randomBytes[3] ^ hash[3]) % 61, // Strength is 40 ~ 100
                Speed = 100 + (randomBytes[4] ^ hash[4]) % 101 // Speed is 100 ~ 200
            };
            State.Characters[Context.Sender] = character;
            return character;
        }

        public override Character GetMyCharacter(Address input)
        {
            return State.Characters[input] ?? new Character();
        }
    }   
}