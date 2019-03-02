# frozen_string_literal: true

module Events
  class Group < ApplicationRecord
    self.table_name = :event_groups

    has_many :events, foreign_key: :event_groups_id
  end
end
