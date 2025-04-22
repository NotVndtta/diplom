class CreateJobApplications < ActiveRecord::Migration[8.0]
  def change
    create_table :job_applications do |t|
      t.bigint :job_card_id, null: false
      t.bigint :user_id, null: false
      t.string :status, default: "pending", null: false
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false

      t.index [ :job_card_id, :user_id ], unique: true
      t.index [ :job_card_id ]
      t.index [ :user_id ]
    end

    add_foreign_key :job_applications, :job_cards
    add_foreign_key :job_applications, :users
  end
end
