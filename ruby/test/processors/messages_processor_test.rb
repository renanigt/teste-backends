require 'minitest/autorun'
require_relative '../../processors/messages_processor'

class MessagesProcessorTest < Minitest::Test
  def setup
    @events = File.readlines('test/files/events.txt')
    @messages_processor = MessagesProcessor.new(@events)
  end

  def test_should_process_proposal
    proposals = @messages_processor.call
    proposal = proposals.first

    assert_equal 1, proposals.count
    assert_equal '80921e5f-4307-4623-9ddb-5bf826a31dd7', proposal.id
    assert_equal 1141424.0, proposal.loan_value
    assert_equal 240, proposal.installments
  end

  def test_should_process_warranties
    proposals = @messages_processor.call
    warranties = proposals.first.warranties
    warranty = warranties.first

    assert_equal 1, warranties.count
    assert_equal '31c1dd83-8fb7-44ff-8cb7-947e604f6293', warranty.id
    assert_equal 3245356.0, warranty.value
    assert_equal 'DF', warranty.province
  end

  def test_should_process_proponents
    proposals = @messages_processor.call
    proponents = proposals.first.proponents
    
    assert_equal 2, proponents.count

    proponent = proponents.detect { |p| p.id == '3f52890a-7e9a-4447-a19b-bb5008a09672' }

    assert_equal 'Ismael Streich Jr.', proponent.name
    assert_equal 42, proponent.age
    assert_equal 62615.64, proponent.monthly_income
    assert proponent.main

    proponent = proponents.detect { |p| p.id == '542c49bc-fde5-44f5-92c0-3d2a3d2d92a2' }

    assert_equal 'Mrs. Peter Wisozk', proponent.name
    assert_equal 41, proponent.age
    assert_equal 67745.71, proponent.monthly_income
    assert_equal false, proponent.main
  end
end
