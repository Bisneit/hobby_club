class AddEventGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :event_groups do |t|
      t.timestamps null: false
    end

    add_reference :events, :event_groups
  end
end
