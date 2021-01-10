require_relative '../models/proponent'

class ProponentParser
  def initialize(event)
    @event = event
  end

  def call
    Proponent.new(
      id: event.data[5],
      name: event.data[6],
      age: event.data[7].to_i,
      monthly_income: event.data[8].to_f,
      main: event.data[9] == 'true'
    )
  end

  private

  attr_reader :event
end
