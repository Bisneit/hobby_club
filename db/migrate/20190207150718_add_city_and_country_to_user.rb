class AddCityAndCountryToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :city, :string
    add_column :users, :country, :string
    add_column :users, :age, :integer
    add_column :users, :sex, :integer
    add_column :users, :info, :string
  end
end
