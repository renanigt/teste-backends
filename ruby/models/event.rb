class Event
  attr_reader :id, :schema, :action, :timestamp, :proposal_id, :data

  def initialize(id:, schema:, action:, timestamp:, proposal_id:, data:)
    @id = id
    @schema = schema
    @action = action
    @timestamp = timestamp
    @proposal_id = proposal_id
    @data = data
  end
end
