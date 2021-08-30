class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :username 
      t.string :password_digest, null: false
      t.string :email, null: false, index: { unique: true }
      t.string :phone
      t.text   :address
      t.string :avatar
      t.string :cover_image
      t.string :role, null: false
      t.integer :email_verified, :limit => 1
      t.integer :phone_verified, :limit => 1
      t.timestamps
    end
  end
end
