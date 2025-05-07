class CreateJobCardMedia < ActiveRecord::Migration[8.0]
  def change
    create_table :job_card_media do |t|
      t.bigint :job_card_id, null: false
      t.bigint :media_file_id, null: false
      t.text :description
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.index :job_card_id
      t.index :media_file_id
    end

    add_foreign_key :job_card_media, :job_cards
    add_foreign_key :job_card_media, :media_files
  end
end
