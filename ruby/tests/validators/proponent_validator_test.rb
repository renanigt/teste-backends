require 'minitest/autorun'
require_relative '../../models/proponent'
require_relative '../../validators/proponent_validator'

class ProponentValidatorTest < Minitest::Test
  def setup
    @proponent = Proponent.new(
      id: '72ff1d14-756a-4549-9185-e60e326baf1b1',
      name: 'Renan Montenegro',
      age: 34,
      monthly_income: 1000.0,
      main: true
    )
  end

  def test_should_be_invalid_for_age_less_than_18
    @proponent.age = 15
    assert_equal false, ProponentValidator.new(@proponent).validate
  end

  def test_should_be_valid_for_age_equals_or_greater_than_18
    assert ProponentValidator.new(@proponent).validate
  end
end
