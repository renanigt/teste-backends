require 'minitest/autorun'

class ProposalServiceTest < Minitest::Test
  def setup
    @proposals = create_proposals
    @proposal_service = ProposalService.new(@proposals)
  end

  def test_should_find_proposal_by_id
    proposal = @proposal_service.find('4e110577-ee8b-4e02-8824-f1ea5b6e8811')

    assert_equal 130000.0, proposal.loan_value
    assert_equal 110, proposal.installments
  end

  def test_should_add_new_proposal
    proposal = Proposal.new(id: '03e771b7-c0af-49d3-8ab4-b76ae4995b9c', loan_value: 30000.0, installments: 60)
    @proposal_service.add_proposal(proposal)

    assert_equal 4, @proposals.count
    assert_equal proposal, @proposals.last
  end

  def test_should_update_proposal
    proposal = Proposal.new(id: '4e110577-ee8b-4e02-8824-f1ea5b6e8811', loan_value: 20000.0, installments: 40)
    @proposal_service.update_proposal(proposal)
    updated_proposal = @proposals.detect { |p| p.id == proposal.id }

    assert_equal 20000.0, updated_proposal.loan_value
    assert_equal 40, updated_proposal.installments
  end

  def test_should_delete_proposal
    proposal_id = '4e110577-ee8b-4e02-8824-f1ea5b6e8811'
    @proposal_service.delete_proposal(proposal_id)
    proposal = @proposals.detect { |p| p.id == proposal_id }

    assert_equal 2, @proposals.count
    assert_nil proposal
  end

  def create_proposals
    [
      Proposal.new(id: 'baf7386c-4dc9-47c5-bb0b-641519abc36a', loan_value: 120000.0, installments: 80),
      Proposal.new(id: '4e110577-ee8b-4e02-8824-f1ea5b6e8811', loan_value: 130000.0, installments: 110),
      Proposal.new(id: '225c8fb9-843c-46a0-9769-9e82b56dae4c', loan_value: 140000.0, installments: 130)
    ]
  end
end
