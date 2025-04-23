class CreateForemanDescription < ActiveRecord::Migration[8.0]
  def change
    create_table :foreman_descriptions do |t|
      t.string :farm_name
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
