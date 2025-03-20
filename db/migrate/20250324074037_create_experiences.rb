class CreateExperiences < ActiveRecord::Migration[8.0]
  def change
    create_table :experiences do |t|
      t.date :start_date_at
      t.date :end_date_at
      t.text :description
      t.string :company
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
