require_relative '../models/event'

class EventParser
  def initialize(data)
    @data = data.strip.split(',')
  end

  def call
    event = Event.new(
      id: data[0],
      schema: data[1],
      action: data[2],
      timestamp: data[3],
      proposal_id: data[4],
      data: data
    )

    event.schema_id = data[5] if event.schema != 'proposal'

    event
  end

  private

  attr_reader :data
end
