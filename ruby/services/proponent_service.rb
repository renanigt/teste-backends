require_relative 'proposal_service'

class ProponentService
  def initialize(proposal)
    @proposal = proposal
  end

  def add_proponent(proponent)
    proposal.proponents << proponent
  end

  def update_proponent(proponent)
    remove_proponent(proponent.id)
    proposal.add_proponent(proponent)
  end

  def remove_proponent(id)
    proposal.proponents.delete_if { |proponent| proponent.id == id }
  end

  private

  attr_reader :proposal
end
