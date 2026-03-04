class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :inventory_items, dependent: :destroy
  # This is duplicated. Check back the weeks to see if it's tagging or something else
  has_many :ingredients, dependent: :destroy
  # This says: "A user can have many ingredients. If the user is deleted, delete their ingredients too."
  has_many :ingredients, dependent: :destroy
  has_many :recipes, dependent: :destroy
  has_many :batches, dependent: :destroy

  # Add validations for better error messages
  validates :email_address, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 8 }, confirmation: true
  validates :password_confirmation, presence: true

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
