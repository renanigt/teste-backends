require_relative 'proposal_service'

class WarrantyService
  def initialize(proposal)
    @proposal = proposal
  end

  def add_warranty(warranty)
    proposal.warranties << warranty
  end

  def update_warranty(warranty)
    remove_warranty(warranty.id)
    proposal.add_warranty(warranty)
  end

  def remove_warranty(id)
    proposal.warranties.delete_if { |warranty| warranty.id == id }
  end

  private

  attr_reader :proposal
end
