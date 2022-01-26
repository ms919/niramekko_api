module Api
  module V1
    class GameResultsController < ApplicationController

      def create
        if logged_in?
          game_result = current_user.game_results.build(game_results_params)
        else
          game_result = GameResult.new(game_results_params)
        end

        if game_result.save!
          render json: game_result.title
        else
          render status: :unprocessable_entity
        end
      end

      private

      def game_results_params
        params.require(:game_result).permit(:mode, :score)
      end
    end
  end
end