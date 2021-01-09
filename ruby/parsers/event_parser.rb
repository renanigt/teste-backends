require_relative '../models/event'

class EventParser
  def initialize(data)
    @data = data.split(',')
  end

  def parse
    Event.new(
      id: data[0],
      schema: data[1],
      action: data[2],
      timestamp: data[3],
      proposal_id: data[4],
      data: data
    )
  end

  private

  attr_reader :data
end
