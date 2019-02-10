# frozen_string_literal: true

module Events
  class Participant < ApplicationRecord
    self.table_name = :event_participants
    
    belongs_to :event
    belongs_to :user
  end
end
