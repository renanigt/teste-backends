class ProposalService
  def initialize(proposals)
    @proposals = proposals
  end

  def find(id)
    proposals.detect { |proposal| proposal.id == id }
  end

  def add_proposal(new_proposal)
    proposals << new_proposal
  end

  def update_proposal(new_proposal)
    proposal = find(new_proposal.id)
    proposal.loan_value = new_proposal.loan_value
    proposal.installments = new_proposal.installments
  end

  def delete_proposal(id)
    proposals.delete_if { |proposal| proposal.id == id }
  end

  private

  attr_reader :proposals
end
