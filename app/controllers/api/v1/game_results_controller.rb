module Api
  module V1
    class GameResultsController < ApplicationController
      def create
        game_results = GameResult.new(game_results_params)
        game_results.user_id = current_user.id
        if game_results.save
          render json: game_results, status: :created
        else
          render json: game_results.errors, status: :unprocessable_entity
        end
      end

      private

      def game_results_params
        params.require(:game_result).permit(:title_id, :mode, :score)
      end
    end
  end
end