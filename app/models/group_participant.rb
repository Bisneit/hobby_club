class GroupParticipant < ApplicationRecord
  belongs_to :user
  belongs_to :group

  delegate :first_name, :last_name, to: :user
end
