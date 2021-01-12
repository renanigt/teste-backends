require 'minitest/autorun'

class WarrantyServiceTest < Minitest::Test
  def setup
    @proposal = create_proposal
    @warranty_service = WarrantyService.new(@proposal)
  end

  def test_should_update_warranty
    warranty = Warranty.new(id: '642bd180-e5bb-492f-a0c8-9a41b5f80d5b', value: 5000.0, province: 'CE')
    @warranty_service.update_warranty(warranty)

    warranty_updated = @proposal.warranties.detect { |w| w.id == warranty.id }

    assert_equal warranty, warranty_updated
  end

  def test_should_delete_warranty
    warranty_id = '37113e50-26ae-48d2-aaf4-4cda8fa76c79'
    @warranty_service.remove_warranty(warranty_id)
    warranty = @proposal.warranties.detect { |w| w.id == warranty_id }

    assert_equal 1, @proposal.warranties.count
    assert_nil warranty
  end

  def create_proposal
    proposal = Proposal.new(id: 'af6e600b-2622-40d1-89ad-d3e5b6cc2fdf', loan_value: 150000.0, installments: 130)
    proposal.add_warranty(
      Warranty.new(id: '37113e50-26ae-48d2-aaf4-4cda8fa76c79', value: 300000.0, province: 'CE')
    )
    proposal.add_warranty(
      Warranty.new(id: '642bd180-e5bb-492f-a0c8-9a41b5f80d5b', value: 20000.0, province: 'ES')
    )

    proposal
  end
end
