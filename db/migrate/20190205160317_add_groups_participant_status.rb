class AddGroupsParticipantStatus < ActiveRecord::Migration[5.2]
  def change
    add_column :group_participants, :status, :integer, index: true
    add_column :group_participants, :confirmed_at, :datetime
  end
end
