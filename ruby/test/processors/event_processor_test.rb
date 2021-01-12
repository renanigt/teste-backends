require 'minitest/autorun'
require_relative '../../processors/event_processor'
require_relative '../../parsers/event_parser'
Dir['models/*.rb'].each { |file| require_relative "../../#{file}" }

class EventProcessorTest < Minitest::Test
  def setup
    @proposals = [create_proposal]
    @proposal_events = File.readlines('test/files/proposal_events.txt')
    @warranty_events = File.readlines('test/files/warranty_events.txt')
    @proponent_events = File.readlines('test/files/proponent_events.txt')
  end

  def test_should_process_proposal_created_event
    event = EventParser.new(@proposal_events[0]).call

    EventProcessor.new(event, @proposals).call

    proposal = @proposals.last

    assert_equal 2, @proposals.size
    assert_equal '80921e5f-4307-4623-9ddb-5bf826a31dd7', proposal.id
    assert_equal 1141424.0, proposal.loan_value
    assert_equal 240, proposal.installments
  end

  def test_should_process_proposal_updated_event
    event = EventParser.new(@proposal_events[1]).call

    EventProcessor.new(event, @proposals).call

    proposal = @proposals.first

    assert_equal 'af6e600b-2622-40d1-89ad-d3e5b6cc2fdf', proposal.id
    assert_equal 123000.0, proposal.loan_value
    assert_equal 140, proposal.installments
  end

  def test_should_process_proposal_deleted_event
    event = EventParser.new(@proposal_events[2]).call

    EventProcessor.new(event, @proposals).call

    assert_empty @proposals
  end

  def test_should_process_warranty_added_event
    event = EventParser.new(@warranty_events[0]).call

    EventProcessor.new(event, @proposals).call

    proposal = @proposals.first
    warranty = @proposals.first.warranties.last

    assert_equal 2, proposal.warranties.size
    assert_equal '56f06a68-dcc1-413d-9e44-6c4680d7c2c2', warranty.id
    assert_equal 6040545.22, warranty.value
    assert_equal 'BA', warranty.province
  end

  def test_should_process_warranty_updated_event
    event = EventParser.new(@warranty_events[1]).call

    EventProcessor.new(event, @proposals).call

    proposal = @proposals.first
    warranty = @proposals.first.warranties.last

    assert_equal 1, proposal.warranties.size
    assert_equal '37113e50-26ae-48d2-aaf4-4cda8fa76c79', warranty.id
    assert_equal 123456.01, warranty.value
    assert_equal 'BA', warranty.province
  end

  def test_should_process_warranty_removed_event
    event = EventParser.new(@warranty_events[2]).call

    EventProcessor.new(event, @proposals).call

    proposal = @proposals.first

    assert_empty proposal.warranties
  end

  def test_should_process_proponent_added_event
    event = EventParser.new(@proponent_events[0]).call

    EventProcessor.new(event, @proposals).call

    proposal = @proposals.first
    proponent = proposal.proponents.last

    assert_equal 3, proposal.proponents.size
    assert_equal 'bb8a50f2-5fe8-4d14-9107-eba65129582a', proponent.id
    assert_equal 'Kathline Ferry', proponent.name
    assert_equal 50, proponent.age
    assert_equal 16889.38, proponent.monthly_income
    assert_equal false, proponent.main
  end

  def test_should_process_proponent_updated_event
    event = EventParser.new(@proponent_events[1]).call

    EventProcessor.new(event, @proposals).call
    
    proposal = @proposals.first
    proponent = proposal.proponents.detect { |p| p.id == '2213ea91-4a3c-46a3-b3a7-ff55c2888561' }

    assert_equal 2, proposal.proponents.size
    assert_equal '2213ea91-4a3c-46a3-b3a7-ff55c2888561', proponent.id
    assert_equal 'Renan Teixeira Montenegro', proponent.name
    assert_equal 34, proponent.age
    assert_equal 3000.0, proponent.monthly_income
    assert_equal false, proponent.main
  end

  def test_should_process_proponent_removed_event
    event = EventParser.new(@proponent_events[2]).call

    EventProcessor.new(event, @proposals).call

    proposal = @proposals.first
    proponent = proposal.proponents.detect { |p| p.id == '2213ea91-4a3c-46a3-b3a7-ff55c2888561' }

    assert_equal 1, proposal.proponents.size
    assert_nil proponent
  end

  private

  def create_proposal
    proposal = Proposal.new(id: 'af6e600b-2622-40d1-89ad-d3e5b6cc2fdf', loan_value: 150000.0, installments: 130)
    proposal.add_warranty(
      Warranty.new(id: '37113e50-26ae-48d2-aaf4-4cda8fa76c79', value: 300000.0, province: 'CE')
    )
    proposal.add_proponent(
      Proponent.new(id: '2213ea91-4a3c-46a3-b3a7-ff55c2888561', name: 'Renan Montenegro', age: 30, monthly_income: 2000.0, main: true)
    )
    proposal.add_proponent(
      Proponent.new(id: 'de92d973-15b4-4d69-98e4-c2d93eb590e6', name: 'Fulano Montenegro', age: 28, monthly_income: 1000.0, main: false)
    )

    proposal
  end
end
