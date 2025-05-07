class CreateMediaFiles < ActiveRecord::Migration[8.0]
  def change
    create_table :media_files do |t|
      t.string :file, null: false
      t.bigint :user_id, null: false
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.index :user_id
    end

    add_foreign_key :media_files, :users
  end
end
