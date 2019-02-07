class AddPost < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string     :body
      t.references :author
      t.references :user

      t.timestamps
    end
  end
end
