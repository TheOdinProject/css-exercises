using AElf.Sdk.CSharp;
using AElf.Sdk.CSharp.State;
using AElf.Types;
using Google.Protobuf.WellKnownTypes;
using System.Collections.Generic;
using System.Security.Principal;

namespace AElf.Contracts.StackUpDAO
{
    public class StackUpDAO : StackUpDAOContainer.StackUpDAOBase
    {
        const string author = "REPLACE PLACEHOLDER HERE";

        //Step A - Implement Initialize Smart Contract Logic
public override Empty Initialize(Empty input) {
            Assert(!State.Initialized.Value, "already initialized");
            var initialProposal = new Proposal
            {
                Id = "0",
                Title = "Proposal #1",
                Description = "This is the first proposal of the DAO",
                Status = "IN PROGRESS",
                VoteThreshold = 1,            
            };
            State.Proposals[initialProposal.Id] = initialProposal;
            State.NextProposalId.Value = 1;
            State.MemberCount.Value = 0;
            return new Empty();
} 

    //Step B - Implement Join DAO Logic 
public override Empty JoinDAO(Address input) {
            Assert(!State.Members[input], "Member is already in the DAO");
            State.Members[input] = true;
         
            var currentCount = State.MemberCount.Value;
            State.MemberCount.Value = currentCount + 1;
            return new Empty();
}

        //Step C - Implement Create Proposal Logic 
public override Proposal CreateProposal(CreateProposalInput input) {
            Assert(State.Members[input.Creator], "Only DAO members can create proposals");
            var proposalId = State.NextProposalId.Value.ToString();
            var newProposal = new Proposal
            {
                Id = proposalId,
                Title = input.Title,
                Description = input.Description,
                Status = "IN PROGRESS",
                VoteThreshold = input.VoteThreshold,
                YesVotes = {},  // Initialize as empty
                NoVotes = {},   // Initialize as empty
            };
            State.Proposals[proposalId] = newProposal;
            State.NextProposalId.Value += 1;
            return newProposal; // Ensure return
}

       //Step D - Implement Vote on Proposal Logic 
public override Proposal VoteOnProposal(VoteInput input) {
            Assert(State.Members[input.Voter], "Only DAO members can vote");
            var proposal = State.Proposals[input.ProposalId]; // ?? new proposal
            Assert(proposal != null, "Proposal not found");
            Assert(!proposal.YesVotes.Contains(input.Voter) && !proposal.NoVotes.Contains(input.Voter), "Member already voted");

            // Add the vote to the appropriate list
            if (input.Vote) {
            proposal.YesVotes.Add(input.Voter);
            } else {
            proposal.NoVotes.Add(input.Voter);
            }

            // Update the proposal in state
            State.Proposals[input.ProposalId] = proposal;

            // Check if the proposal has reached its vote threshold
            if (proposal.YesVotes.Count >= proposal.VoteThreshold) {
            proposal.Status = "PASSED";
            } else if (proposal.NoVotes.Count >= proposal.VoteThreshold) {
            proposal.Status = "DENIED";
            }
            
            return proposal;
}
        
   //Step E - Implement Get All Proposals Logic 
public override ProposalList GetAllProposals(Empty input) {     
            var proposals = new ProposalList();
            for (int i = 0; i < State.NextProposalId.Value; i++)
            {
                var proposal_count = i.ToString();
                var proposal = State.Proposals[proposal_count];
                proposals.Proposals.Add(proposal);
            }
            return proposals;
}
     }    
  }