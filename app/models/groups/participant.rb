class Groups::Participant < ApplicationRecord
  self.table_name = :group_participants
  belongs_to :user
  belongs_to :group
  belongs_to :role, class_name: Groups::Role.name, foreign_key: :group_roles_id

  delegate :first_name, :last_name, to: :user

  enum status: %i[requested confirmed]

  scope :confirmed, -> { where(status: :confirmed) }
  scope :requested, -> { where(status: :requested) }

  def confirmed?
    status == 'confirmed'
  end

  def confirm!
    update(status: :confirmed, confirmed_at: Time.current)
  end
end
