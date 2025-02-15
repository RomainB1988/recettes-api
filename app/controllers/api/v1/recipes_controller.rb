module Api
  module V1
    class RecipesController < ApplicationController
      before_action :set_recipe, only: [:show, :update, :destroy, :favorite, :unfavorite]
      before_action :authenticate_user!, only: [:create, :update, :destroy, :favorite, :unfavorite, :favorites]

      def index
        @recipes = Recipe.all

        if params[:title].present?
          @recipes = @recipes.where("title ILIKE ?", "%#{params[:title]}%")
        end

        if params[:ingredient].present?
          @recipes = @recipes.where("ingredients ILIKE ?", "%#{params[:ingredient]}%")
        end

        render json: @recipes
      end

      def show
        render json: @recipe
      end

      def create
        @recipe = Recipe.new(recipe_params)
        if @recipe.save
          render json: @recipe, status: :created
        else
          render json: @recipe.errors, status: :unprocessable_entity
        end
      end

      def update
        if @recipe.update(recipe_params)
          render json: @recipe
        else
          render json: @recipe.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @recipe.destroy
        head :no_content
      end

      def favorite
        if current_user.favorite_recipes << @recipe
          render json: { message: "Recipe added to favorites" }, status: :ok
        else
          render json: { message: "Unable to add recipe to favorites" }, status: :unprocessable_entity
        end
      end

      def unfavorite
        if current_user.favorite_recipes.delete(@recipe)
          render json: { message: "Recipe removed from favorites" }, status: :ok
        else
          render json: { message: "Unable to remove recipe from favorites" }, status: :unprocessable_entity
        end
      end

      def favorites
        @recipes = current_user.favorite_recipes
        render json: @recipes
      end

      private

      def set_recipe
        @recipe = Recipe.find(params[:id])
      end

      def recipe_params
        params.require(:recipe).permit(:title, :description, :ingredients, :steps, :user_id)
      end
    end
  end
end
