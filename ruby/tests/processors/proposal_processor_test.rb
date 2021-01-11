require 'minitest/autorun'
require_relative '../../processors/proposal_processor'
require_relative '../../parsers/event_parser'
require_relative '../../models/proposal'

class ProposalProcessorTest < Minitest::Test
  def setup
    @proposals = [create_proposal]
    @proposal_events = File.readlines('tests/files/proposal_events.txt')
  end

  def test_should_process_proposal_created_event
    event = EventParser.new(@proposal_events[0]).call

    ProposalProcessor.new(event, @proposals).call

    proposal = @proposals.last

    assert_equal 2, @proposals.size
    assert_equal '80921e5f-4307-4623-9ddb-5bf826a31dd7', proposal.id
    assert_equal 1141424.0, proposal.loan_value
    assert_equal 240, proposal.installments
  end

  def test_should_process_proposal_updated_event
    event = EventParser.new(@proposal_events[1]).call

    ProposalProcessor.new(event, @proposals).call

    proposal = @proposals.first

    assert_equal 'af6e600b-2622-40d1-89ad-d3e5b6cc2fdf', proposal.id
    assert_equal 123000.0, proposal.loan_value
    assert_equal 140, proposal.installments
  end

  def test_should_process_proposal_deleted_event
    event = EventParser.new(@proposal_events[2]).call

    ProposalProcessor.new(event, @proposals).call

    assert_empty @proposals
  end

  private

  def create_proposal
    Proposal.new(id: 'af6e600b-2622-40d1-89ad-d3e5b6cc2fdf', loan_value: 150000.0, installments: 130)
  end
end
