require_relative '../parsers/proponent_parser'
require_relative '../services/proponent_service'

class ProponentProcessor
  def initialize(event, proposal)
    @event = event
    @proposal = proposal
  end

  def call
    proponent = ProponentParser.new(event).call
    proponent_service = ProponentService.new(proposal)

    case event.name
    when Event::NAMES[:PROPONENT_ADDED]
      proposal.add_proponent(proponent)
    when Event::NAMES[:PROPONENT_UPDATED]
      proponent_service.update_proponent(proponent)
    when Event::NAMES[:PROPONENT_REMOVED]
      proponent_service.remove_proponent(proponent.id)
    end
  end

  private

  attr_reader :event, :proposal
end
