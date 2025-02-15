class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  validates :user_id, uniqueness: { scope: :recipe_id, message: "You already favorited this recipe" }
end
