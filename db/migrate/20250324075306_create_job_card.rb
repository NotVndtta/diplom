class CreateJobCard < ActiveRecord::Migration[8.0]
  def change
    create_table :job_cards do |t|
      t.string :farm_name
      t.integer :remuneration
      t.integer :work_amount
      t.text :description
      t.date :date_at
      t.string :location
      t.string :status
      t.integer :count_users
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
