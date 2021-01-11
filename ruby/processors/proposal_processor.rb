require_relative '../parsers/proposal_parser'
require_relative '../services/proposal_service'

class ProposalProcessor
  def initialize(event, proposals)
    @event = event
    @proposals = proposals
  end

  def call
    proposal = ProposalParser.new(event).call
    proposal_service = ProposalService.new(proposals)

    case event.name
    when Event::NAMES[:PROPOSAL_CREATED]
      proposal_service.add_proposal(proposal)
    when Event::NAMES[:PROPOSAL_UPDATED]
      proposal_service.update_proposal(proposal)
    when Event::NAMES[:PROPOSAL_DELETED]
      proposal_service.delete_proposal(proposal.id)
    end
  end

  private

  attr_reader :event, :proposals
end
