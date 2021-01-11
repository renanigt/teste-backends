class Warranty
  attr_reader :id, :proposal_id
  attr_accessor :value, :province

  def initialize(id:, value:, province:, proposal_id:)
    @id = id
    @value = value
    @province = province
    @proposal_id = proposal_id
  end
end
