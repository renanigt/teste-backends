require 'minitest/autorun'

class ProponentServiceTest < Minitest::Test
  def setup
    @proposal = create_proposal
    @proponent_service = ProponentService.new(@proposal)
  end

  def test_should_update_proponent
    proponent = Proponent.new(
      id: '2213ea91-4a3c-46a3-b3a7-ff55c2888561', name: 'Renan Teixeira Montenegro', age: 33, monthly_income: 3000.0, main: false
    )
    @proponent_service.update_proponent(proponent)

    proponent_updated = @proposal.proponents.detect { |p| p.id == proponent.id }

    assert_equal proponent, proponent_updated
  end

  def test_should_delete_proponent
    @proponent_service.remove_proponent('2213ea91-4a3c-46a3-b3a7-ff55c2888561')
    proponent = @proposal.proponents.detect { |p| p.id == '2213ea91-4a3c-46a3-b3a7-ff55c2888561' }

    assert_equal 1, @proposal.proponents.count
    assert_nil proponent
  end

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
