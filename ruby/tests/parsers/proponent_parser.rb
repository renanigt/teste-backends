require 'minitest/autorun'
require_relative '../../parsers/event_parser'
require_relative '../../parsers/proponent_parser'

class ProposalParserTest < Minitest::Test
  def setup
    events_text = File.readlines('tests/files/proponent_events.txt')
    data = events_text[0]
    @event = EventParser.new(data).parse
  end

  def test_should_parse_proponent_based_on_event_data
    proponent = ProponentParser.new(@event).parse

    assert_equal "2213ea91-4a3c-46a3-b3a7-ff55c2888561", proponent.id
    assert_equal "Kathline Ferry", proponent.name
    assert_equal 50, proponent.age
    assert_equal 168896.38, proponent.monthly_income
    assert proponent.main
  end
end
