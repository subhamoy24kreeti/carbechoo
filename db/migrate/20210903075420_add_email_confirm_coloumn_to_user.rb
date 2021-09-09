class AddEmailConfirmColoumnToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :email_confirmed, :boolean
    add_column :users, :confirm_token_email, :string
    add_column :users, :phone_confirm, :boolean
    add_column :users, :confirm_token_phone, :string
    add_column :users, :expired_token_email_at, :datetime
    add_column :users, :expired_token_phone_at, :datetime
  end
end
