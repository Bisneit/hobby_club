# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :group
  has_many :participants, class_name: Events::Participant.name
end
