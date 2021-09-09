class AddAddressUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :street, :text
    add_column :users, :city, :text
    add_column :users, :state, :text
    add_column :users, :country, :string
    add_column :users, :longitude, :float
    add_column :users, :latitude, :float
    add_column :users, :zip_code, :text
  end
end
