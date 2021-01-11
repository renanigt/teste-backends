class Event
  SCHEMAS = {
    PROPOSAL: 'proposal',
    WARRANTY: 'warranty',
    PROPONENT: 'proponent'
  }

  NAMES = {
    PROPOSAL_CREATED: 'proposal.created',
    PROPOSAL_UPDATED: 'proposal.updated',
    PROPOSAL_DELETED: 'proposal.deleted',
    WARRANTY_ADDED: 'warranty.added',
    WARRANTY_UPDATED: 'warranty.updated',
    WARRANTY_REMOVED: 'warranty.removed',
    PROPONENT_ADDED: 'proponent.added',
    PROPONENT_UPDATED: 'proponent.updated',
    PROPONENT_REMOVED: 'proponent.removed'
  }

  attr_reader :id, :schema, :action, :timestamp, :proposal_id, :data
  attr_accessor :schema_id

  def initialize(id:, schema:, action:, timestamp:, proposal_id:, data:)
    @id = id
    @schema = schema
    @action = action
    @timestamp = timestamp
    @proposal_id = proposal_id
    @data = data
  end

  def name
    "#{schema}.#{action}"
  end
end
