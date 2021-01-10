require_relative '../models/warranty'

class WarrantyParser
  def initialize(event)
    @event = event
  end

  def call
    Warranty.new(
      id: event.data[5],
      value: event.data[6].to_f,
      province: event.data[7]
    )
  end

  private

  attr_reader :event
end
