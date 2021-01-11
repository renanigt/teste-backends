require 'minitest/autorun'
require_relative '../../validators/proposal_validator'
Dir['models/*.rb'].each { |file| require_relative "../../#{file}" }

class ProposalValidatorTest < Minitest::Test
  def setup
    @proposal = Proposal.new(id: '72ff1d14-756a-4549-9185-e60e326baf1b1', loan_value: 40000.0, installments: 150)
    @warranty = Warranty.new(id: 'cff38b44-01f0-4e3f-9a49-f625fd2022ab', value: 80000.0, province: 'CE', proposal_id: @proposal.id)
    @proponent_renan = Proponent.new(
      id: '399c4c93-7456-4b42-8e7c-c89eb8372e78',
      name: 'Renan Montenegro',
      age: 34,
      monthly_income: 1000.0,
      main: true
    )
    @proponent_fulano = Proponent.new(
      id: 'c5fbc6e7-d261-44d2-92f3-e222649a91c7',
      name: 'Fulano Montenegro',
      age: 34,
      monthly_income: 1000.0,
      main: false
    )
    @proposal.add_warranty(@warranty)
    @proposal.add_proponent(@proponent_renan)
    @proposal.add_proponent(@proponent_fulano)
  end

  def test_should_be_valid_if_everything_is_valid
    assert ProposalValidator.new(@proposal).validate
  end

  def test_should_be_invalid_if_proposal_value_is_less_than_min_loan_value
    @proposal.loan_value = ProposalValidator::MIN_LOAN_VALUE - 1
    assert_equal false, ProposalValidator.new(@proposal).validate
  end

  def test_should_be_invalid_if_proposal_value_is_greater_than_max_loan_value
    @proposal.loan_value = ProposalValidator::MAX_LOAN_VALUE + 1

    assert_equal false, ProposalValidator.new(@proposal).validate
  end

  def test_should_be_invalid_if_total_proponents_is_less_than_2
    @proposal.proponents.pop

    assert_equal false, ProposalValidator.new(@proposal).validate
  end

  def test_should_be_invalid_if_at_least_one_proponent_is_less_18_years
    @proponent_fulano.age = 12

    assert_equal false, ProposalValidator.new(@proposal).validate
  end

  def test_should_be_invalid_if_there_is_no_warranties
    @proposal.warranties.clear

    assert_equal false, ProposalValidator.new(@proposal).validate
  end

  def test_should_be_invalid_if_total_warranties_values_is_less_then_the_double_of_loan_value
    @warranty.value = 60000.0

    assert_equal false, ProposalValidator.new(@proposal).validate
  end

  def test_should_be_invalid_if_there_is_at_least_one_warranty_from_not_allowed_province
    @proposal.add_warranty(Warranty.new(id: '121b7334-34a4-4017-8b53-087584d54ac0', value: 80000.0, province: 'SC', proposal_id: @proposal.id))

    assert_equal false, ProposalValidator.new(@proposal).validate
  end

  def test_should_be_invalid_if_main_proponent_age_between_18_and_24_and_monthly_income_less_than_4_times_installment_value
    @proponent_renan.age = 23
    @proponent_renan.monthly_income = (4*@proposal.installment_value) - 1

    assert_equal false, ProposalValidator.new(@proposal).validate
  end

  def test_should_be_invalid_if_main_proponent_age_between_24_and_50_and_monthly_income_less_than_3_times_installment_value
    @proponent_renan.age = 35
    @proponent_renan.monthly_income = (3*@proposal.installment_value) - 1

    assert_equal false, ProposalValidator.new(@proposal).validate
  end

  def test_should_be_invalid_if_main_proponent_age_greater_than_50_and_monthly_income_less_than_2_times_installment_value
    @proponent_renan.age = 55
    @proponent_renan.monthly_income = (2*@proposal.installment_value) - 1

    assert_equal false, ProposalValidator.new(@proposal).validate
  end
end
