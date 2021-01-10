require 'minitest/autorun'
require_relative '../../parsers/event_parser'
require_relative '../../parsers/proposal_parser'

class ProposalParserTest < Minitest::Test
  def setup
    events_text = File.readlines('tests/files/proposal_events.txt')
    data = events_text[0]
    @event = EventParser.new(data).parse
  end

  def test_should_parse_proposal_based_on_event_data
    proposal = ProposalParser.new(@event).parse

    assert_equal "80921e5f-4307-4623-9ddb-5bf826a31dd7", proposal.id
    assert_equal 1141424.0, proposal.loan_value
    assert_equal 240, proposal.installments
  end
end
