class Warranty
  attr_reader :id, :proposal_id
  attr_accessor :value, :province

  def initialize(id:, value:, province:)
    @id = id
    @value = value
    @province = province
  end
end
