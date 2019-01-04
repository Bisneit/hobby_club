class CreateGroupRole < ActiveRecord::Migration[5.2]
  def change
    create_table :group_roles do |t|
      t.string     :name, null: false
      t.string     :description
      t.references :group, foreign_key: true

      t.timestamps
    end

    add_reference :group_participants, :group_roles, index: true
  end
end
