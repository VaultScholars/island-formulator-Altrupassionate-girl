class Ingredient < ApplicationRecord
  # This says: "Every ingredient MUST belong to a user."
  belongs_to :user

  # This allows us to say @ingredient.tags and get a list of all tags!
  # It's much easier than saying @ingredient.ingredient_tags.map(&:tag).
  has_many :ingredient_tags, dependent: :destroy
  has_many :tags, through: :ingredient_tags

  validates :name, presence: true
  validates :category, presence: true
  validates :user, presence: true  # Ensures no orphaned ingredients

  has_one_attached :photo
end
