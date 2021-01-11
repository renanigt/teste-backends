require 'minitest/autorun'
require_relative '../../processors/event_processor'
require_relative '../../parsers/event_parser'
require_relative '../../models/proposal'
require_relative '../../models/proponent'

class ProponentProcessorTest < Minitest::Test
  def setup
    @proposal = create_proposal
    @proponent_events = File.readlines('tests/files/proponent_events.txt')
  end

  def test_should_process_proponent_added_event
    event = EventParser.new(@proponent_events[0]).call

    ProponentProcessor.new(event, @proposal).call

    proponent = @proposal.proponents.last

    assert_equal 3, @proposal.proponents.size
    assert_equal 'bb8a50f2-5fe8-4d14-9107-eba65129582a', proponent.id
    assert_equal 'Kathline Ferry', proponent.name
    assert_equal 50, proponent.age
    assert_equal 16889.38, proponent.monthly_income
    assert_equal false, proponent.main
  end

  def test_should_process_proponent_updated_event
    event = EventParser.new(@proponent_events[1]).call

    ProponentProcessor.new(event, @proposal).call
    
    proponent = @proposal.proponents.detect { |p| p.id == '2213ea91-4a3c-46a3-b3a7-ff55c2888561' }

    assert_equal 2, @proposal.proponents.size
    assert_equal '2213ea91-4a3c-46a3-b3a7-ff55c2888561', proponent.id
    assert_equal 'Renan Teixeira Montenegro', proponent.name
    assert_equal 34, proponent.age
    assert_equal 3000.0, proponent.monthly_income
    assert_equal false, proponent.main
  end

  def test_should_process_proponent_removed_event
    event = EventParser.new(@proponent_events[2]).call

    ProponentProcessor.new(event, @proposal).call

    proponent = @proposal.proponents.detect { |p| p.id == '2213ea91-4a3c-46a3-b3a7-ff55c2888561' }

    assert_equal 1, @proposal.proponents.size
    assert_nil proponent
  end

  private

  def create_proposal
    proposal = Proposal.new(id: 'af6e600b-2622-40d1-89ad-d3e5b6cc2fdf', loan_value: 150000.0, installments: 130)
    proposal.add_proponent(
      Proponent.new(id: '2213ea91-4a3c-46a3-b3a7-ff55c2888561', name: 'Renan Montenegro', age: 30, monthly_income: 2000.0, main: true)
    )
    proposal.add_proponent(
      Proponent.new(id: 'de92d973-15b4-4d69-98e4-c2d93eb590e6', name: 'Fulano Montenegro', age: 28, monthly_income: 1000.0, main: false)
    )

    proposal
  end
end
