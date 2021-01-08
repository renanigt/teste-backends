require_relative 'proponent_validator'
require_relative 'warranty_validator'

class ProposalValidator
  MIN_LOAN_VALUE = 30_000
  MAX_LOAN_VALUE = 3_000_000
  MIN_INSTALLMENTS = 24
  MAX_INSTALLMENTS = 180
  MIN_PROPONENTS = 2
  MAX_MAIN_PROPONENTS = 1
  MIN_WARRANTIES = 1

  def initialize(proposal)
    @proposal = proposal
  end

  def validate
    valid_value? &&
    valid_total_installments? &&
    valid_total_proponents? &&
    valid_total_main_proponents? &&
    valid_proponents? &&
    valid_total_warranties? &&
    valid_warranties_values? &&
    valid_warranties? &&
    valid_main_proponent_monthly_income?
  end

  private

  attr_reader :proposal

  def valid_value?
    proposal.loan_value >= MIN_LOAN_VALUE && proposal.loan_value <= MAX_LOAN_VALUE
  end

  def valid_total_installments?
    proposal.installments >= MIN_INSTALLMENTS && proposal.installments <= MAX_INSTALLMENTS
  end

  def valid_total_proponents?
    proposal.proponents.size >= MIN_PROPONENTS
  end

  def valid_total_main_proponents?
    proposal.proponents.count { |proponent| proponent.main == true } == MAX_MAIN_PROPONENTS
  end

  def valid_proponents?
    proposal.proponents.all? { |proponent| ProponentValidator.new(proponent).validate }
  end

  def valid_total_warranties?
    proposal.warranties.size >= MIN_WARRANTIES
  end

  def valid_warranties_values?
    proposal.warranties.sum(&:value) >= 2*proposal.loan_value
  end

  def valid_warranties?
    proposal.warranties.all? { |warranty| WarrantyValidator.new(warranty).validate  }
  end

  def valid_main_proponent_monthly_income?
    main_proponent = proposal.main_proponent
    installment_value = proposal.installment_value

    (main_proponent.age >= 18 && main_proponent.age <= 24 && main_proponent.monthly_income >= 4*installment_value) ||
      (main_proponent.age > 24 && main_proponent.age <= 50 && main_proponent.monthly_income >= 3*installment_value) ||
        (main_proponent.age > 50 && main_proponent.monthly_income >= 2*installment_value)
  end
end
