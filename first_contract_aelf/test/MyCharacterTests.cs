using System.Threading.Tasks;
using Google.Protobuf.WellKnownTypes;
using Shouldly;
using Xunit;
using System;
using AElf.Sdk.CSharp;

namespace AElf.Contracts.MyCharacter
{
    // This class is unit test class, and it inherit TestBase. Write your unit test code inside it
    public class MyCharacterTests : TestBase
    {
        [Fact]
        public async Task Rng_Test()
        {
            await MyCharacterStub.Initialize.SendAsync(new Empty());
            var result = await MyCharacterStub.CreateCharacter.SendAsync(new Empty());
            var character = await MyCharacterStub.GetMyCharacter.CallAsync(Accounts[0].Address);

           Assert.NotEqual(new Character(), character);
           Assert.Equal(result.Output, character);
        }
    }    
}