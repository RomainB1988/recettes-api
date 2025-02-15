module Api
  module V1
    class CommentsController < ApplicationController
      before_action :set_recipe, only: [:index, :create]
      before_action :set_comment, only: [:destroy]

      def index
        @comments = @recipe.comments
        render json: @comments
      end

      def create
        @comment = @recipe.comments.build(comment_params)
        @comment.user = current_user

        if @comment.save
          render json: @comment, status: :created
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      end

      def destroy
        if @comment.destroy
          head :no_content
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      end

      private

      def set_recipe
        @recipe = Recipe.find(params[:recipe_id])
      end

      def set_comment
        @comment = Comment.find(params[:id])
      end

      def comment_params
        params.require(:comment).permit(:content)
      end
    end
  end
end
