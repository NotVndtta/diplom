class AddVineyardTokenToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :vineyard_token, :string
  end
end
