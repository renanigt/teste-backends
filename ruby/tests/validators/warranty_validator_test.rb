require 'minitest/autorun'
require_relative '../../models/warranty'
require_relative '../../validators/warranty_validator'

class WarrantyValidatorTest < Minitest::Test
  def setup
    @warranty = Warranty.new(id: '72ff1d14-756a-4549-9185-e60e326baf1b1', value: 30000.0, province: 'CE', proposal_id: 'af6e600b-2622-40d1-89ad-d3e5b6cc2fdf')
  end

  def test_should_be_invalid_for_provinces_not_allowed
    WarrantyValidator::PROVINCES_NOT_ALLOWED.each do |province|
      @warranty.province = province
      assert_equal false, WarrantyValidator.new(@warranty).validate
    end
  end

  def test_should_be_valid_for_provinces_allowed
    ['CE', 'RJ', 'PE', 'PI'].each do |province|
      @warranty.province = province
      assert WarrantyValidator.new(@warranty).validate
    end
  end
end
