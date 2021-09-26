class ChangeUserAddAddressForiegn < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :city, :text
    remove_column :users, :state, :text
    remove_column :users, :country, :string
    add_reference :users, :city,  foreign_key: true
    add_reference :users, :state,  foreign_key: true
    add_reference :users, :country,  foreign_key: true
  end
end
