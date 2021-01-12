require_relative '../parsers/warranty_parser'
require_relative '../services/warranty_service'

class WarrantyProcessor
  def initialize(event, proposal)
    @event = event
    @proposal = proposal
  end

  def call
    warranty = WarrantyParser.new(event).call
    warranty_service = WarrantyService.new(proposal)

    case event.name
    when Event::NAMES[:WARRANTY_ADDED]
      proposal.add_warranty(warranty)
    when Event::NAMES[:WARRANTY_UPDATED]
      warranty_service.update_warranty(warranty)
    when Event::NAMES[:WARRANTY_REMOVED]
      warranty_service.remove_warranty(warranty.id)
    end
  end

  private

  attr_reader :event, :proposal
end
