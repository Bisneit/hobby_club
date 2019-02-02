class AddAvatarToGroup < ActiveRecord::Migration[5.2]
  def self.up
    change_table :groups do |t|
      t.string :avatar
    end
  end

  def self.down
    drop_attached_file :groups, :avatar
  end
end
