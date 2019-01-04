class Groups::Role < ApplicationRecord
  self.table_name = :group_roles
  belongs_to :group, class_name: Group.name
end
