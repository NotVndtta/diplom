class AddUserToRatings < ActiveRecord::Migration[8.0]
  def change
    add_reference :ratings, :user, null: false, foreign_key: true, if_not_exists: true
  end
end
