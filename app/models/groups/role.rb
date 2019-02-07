class Groups::Role < ApplicationRecord
  self.table_name = :group_roles
  belongs_to :group, class_name: Group.name
  has_many :participants, class_name: Groups::Participant.name, foreign_key: :group_roles_id
end
