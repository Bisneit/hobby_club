class CreateEventParticipants < ActiveRecord::Migration[5.2]
  def change
    create_table :event_participants do |t|
      t.references :user
      t.references :event
      t.boolean :paid
      t.boolean :appearance
    end
  end
end
