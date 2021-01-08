class WarrantyValidator
  PROVINCES_NOT_ALLOWED = ['PR', 'SC', 'RS']

  def initialize(warrranty)
    @warrranty = warrranty
  end

  def validate
    valid_state?
  end

  private

  attr_reader :warrranty

  def valid_state?
    !PROVINCES_NOT_ALLOWED.include?(warrranty.province)
  end
end
