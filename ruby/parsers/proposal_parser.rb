require_relative '../models/proposal'

class ProposalParser
  def initialize(event)
    @event = event
  end

  def call
    Proposal.new(
      id: event.data[4],
      loan_value: event.data[5].to_f,
      installments: event.data[6].to_i
    )
  end

  private

  attr_reader :event
end
