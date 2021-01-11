require 'minitest/autorun'
require_relative '../../processors/warranty_processor'
require_relative '../../parsers/event_parser'
require_relative '../../models/proposal'
require_relative '../../models/warranty'

class WarrantyProcessorTest < Minitest::Test
  def setup
    @proposal = create_proposal
    @warranty_events = File.readlines('tests/files/warranty_events.txt')
  end

  def test_should_process_warranty_added_event
    event = EventParser.new(@warranty_events[0]).call

    WarrantyProcessor.new(event, @proposal).call

    warranty = @proposal.warranties.last

    assert_equal 2, @proposal.warranties.size
    assert_equal '56f06a68-dcc1-413d-9e44-6c4680d7c2c2', warranty.id
    assert_equal 6040545.22, warranty.value
    assert_equal 'BA', warranty.province
  end

  def test_should_process_warranty_updated_event
    event = EventParser.new(@warranty_events[1]).call

    WarrantyProcessor.new(event, @proposal).call

    warranty = @proposal.warranties.last

    assert_equal 1, @proposal.warranties.size
    assert_equal '37113e50-26ae-48d2-aaf4-4cda8fa76c79', warranty.id
    assert_equal 123456.01, warranty.value
    assert_equal 'BA', warranty.province
  end

  def test_should_process_warranty_removed_event
    event = EventParser.new(@warranty_events[2]).call

    WarrantyProcessor.new(event, @proposal).call


    assert_empty @proposal.warranties
  end

  private

  def create_proposal
    proposal = Proposal.new(id: 'af6e600b-2622-40d1-89ad-d3e5b6cc2fdf', loan_value: 150000.0, installments: 130)
    proposal.add_warranty(
      Warranty.new(id: '37113e50-26ae-48d2-aaf4-4cda8fa76c79', value: 300000.0, province: 'CE', proposal_id: proposal.id)
    )

    proposal
  end
end
