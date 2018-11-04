class AddGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.text :description
      t.boolean :public, default: true
      t.timestamps
    end
  end
end
