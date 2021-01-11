require 'minitest/autorun'
require_relative '../../parsers/event_parser'
require_relative '../../parsers/proponent_parser'

class ProponentParserTest < Minitest::Test
  def setup
    events_text = File.readlines('tests/files/proponent_events.txt')
    data = events_text[0]
    @event = EventParser.new(data).call
  end

  def test_should_parse_proponent_based_on_event_data
    proponent = ProponentParser.new(@event).call

    assert_equal "bb8a50f2-5fe8-4d14-9107-eba65129582a", proponent.id
    assert_equal "Kathline Ferry", proponent.name
    assert_equal 50, proponent.age
    assert_equal 16889.38, proponent.monthly_income
    assert_equal false, proponent.main
  end
end
