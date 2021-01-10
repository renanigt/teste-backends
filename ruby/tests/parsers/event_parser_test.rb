require 'minitest/autorun'
require_relative '../../parsers/event_parser'

class EventParserTest < Minitest::Test
  def setup
    events_text = File.readlines('tests/files/events.txt')
    @data = events_text[0]
  end

  def test_should_parse_event
    event = EventParser.new(@data).call

    assert_equal "72ff1d14-756a-4549-9185-e60e326baf1b", event.id
    assert_equal "proposal", event.schema
    assert_equal "created", event.action
    assert_equal "2019-11-11T14:28:01Z", event.timestamp
    assert_equal "80921e5f-4307-4623-9ddb-5bf826a31dd7", event.proposal_id
    assert_equal @data, event.data.join(',')
  end
end
