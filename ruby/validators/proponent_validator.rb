class ProponentValidator
  MIN_AGE = 18

  def initialize(proponent)
    @proponent = proponent
  end

  def validate
    valid_age?
  end

  private

  attr_reader :proponent

  def valid_age?
    proponent.age >= MIN_AGE
  end
end
