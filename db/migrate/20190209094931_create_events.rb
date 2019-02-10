class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :description
      t.references :group, foreign_key: true
      t.integer :duration
      t.string :place
      t.datetime :start_date
      t.datetime :end_date
    end
  end
end
