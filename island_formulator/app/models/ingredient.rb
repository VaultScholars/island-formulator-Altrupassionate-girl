class Ingredient < ApplicationRecord
  # This says: "Every ingredient MUST belong to a user."
  belongs_to :user

  validates :name, presence: true
  validates :category, presence: true
  validates :user, presence: true  # Ensures no orphaned ingredients
end
