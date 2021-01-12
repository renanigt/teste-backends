require_relative '../parsers/event_parser'
require_relative 'event_processor'

class MessagesProcessor
  def initialize(messages)
    @messages = messages
    @processed_events = []
    @proposals = []
  end

  def call
    messages.each do |message|
      event = EventParser.new(message).call

      if valid_event?(event)
        EventProcessor.new(event, proposals).call
        processed_events << event
      end
    end

    proposals
  end

  private

  attr_reader :processed_events, :proposals, :messages

  def valid_event?(event)
    not_processed?(event) && not_delayed?(event)
  end

  def not_delayed?(event)
    processed_events.none? do |processed_event|
      same_schema?(processed_event, event) && processed_event.timestamp > event.timestamp
    end
  end

  def not_processed?(event)
    processed_events.none? { |processed_event| processed_event.id == event.id }
  end

  def same_schema?(processed_event, event)
    processed_event.schema == event.schema && processed_event.schema_id == event.schema_id
  end
end
