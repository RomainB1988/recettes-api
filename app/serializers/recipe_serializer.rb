class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :ingredients, :steps, :created_at, :updated_at
  has_many :comments
end
