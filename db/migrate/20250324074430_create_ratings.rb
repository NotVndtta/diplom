class CreateRatings < ActiveRecord::Migration[8.0]
  def change
    create_table :ratings do |t|
      t.text :comment, null: false
      t.integer :grade, null: false
      t.references :rateable, polymorphic: true, null: false, index: true

      t.timestamps
    end

    add_index :ratings, [ :rateable_type, :rateable_id ], unique: false
  end
end
