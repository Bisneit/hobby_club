# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :group
  has_many :participants, class_name: Events::Participant.name
  attr_accessor :type, :repeat_number, :without_weekends, :days
  validates :description, :date, :start_at, :end_at, presence: true
end
