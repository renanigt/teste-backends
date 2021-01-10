require 'minitest/autorun'
require_relative '../../parsers/event_parser'
require_relative '../../parsers/warranty_parser'

class WarrantyParserTest < Minitest::Test
  def setup
    events_text = File.readlines('tests/files/warranty_events.txt')
    data = events_text[0]
    @event = EventParser.new(data.strip).parse
  end

  def test_should_parse_warranty_based_on_event_data
    warranty = WarrantyParser.new(@event).parse

    assert_equal "56f06a68-dcc1-413d-9e44-6c4680d7c2c2", warranty.id
    assert_equal 6040545.22, warranty.value
    assert_equal 'BA', warranty.province
  end
end
