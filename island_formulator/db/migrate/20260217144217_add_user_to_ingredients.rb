class AddUserToIngredients < ActiveRecord::Migration[8.1]
  def change
    add_reference :ingredients, :user, null: true, foreign_key: true
  end
end
