class Groups::Participant < ApplicationRecord
  self.table_name = :group_participants
  belongs_to :user
  belongs_to :group
  has_one :role, foreign_key: :role_id, class_name: Groups::Role.name

  delegate :first_name, :last_name, to: :user

  enum status: [:requested, :confirmed]

  scope :confirmed, -> { where(status: :confirmed) }
  scope :requested, -> { where(status: :requested) }

  def confirmed?
    status == 'confirmed'
  end
end
