class Proposal
  def initialize(id:, loan_value:, installments:)
    @id = id
    @loan_value = loan_value
    @installments = installments
    @warranties = []
    @proponents = []
  end

  def add_warranty(warranty)
    @warranties << warranty
  end

  def add_proponent(proponent)
    @proponents << proponent
  end

  def main_proponent
    proponents.select { |proponent| proponent.main }.first
  end

  def installment_value
    loan_value.to_f / installments
  end
end
