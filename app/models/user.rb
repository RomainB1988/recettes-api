class User < ApplicationRecord
  has_many :favorites
  has_many :favorite_recipes, through: :favorites, source: :recipe
end
