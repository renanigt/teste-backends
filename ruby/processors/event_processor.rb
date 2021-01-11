require_relative 'proposal_processor'
require_relative 'warranty_processor'
require_relative 'proponent_processor'

class EventProcessor
  def initialize(event, proposals)
    @event = event
    @proposals = proposals
  end

  def call
    case event.schema
    when Event::SCHEMAS[:PROPOSAL]
      ProposalProcessor.new(event, proposals).call
    when Event::SCHEMAS[:WARRANTY]
      WarrantyProcessor.new(event, proposal).call
    when Event::SCHEMAS[:PROPONENT]
      ProponentProcessor.new(event, proposal).call
    end
  end

  private

  attr_reader :event, :proposals

  def proposal
    ProposalService.new(proposals).find(event.proposal_id)
  end
end
