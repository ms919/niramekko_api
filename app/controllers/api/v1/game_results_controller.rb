module Api
  module V1
    class GameResultsController < ApplicationController
      include TITLES

      def create
        if logged_in?
          game_result = current_user.game_results.build(game_results_params)
        else
          game_result = GameResult.new(game_results_params)
        end
        game_result.title = calc_title(game_result.score)

        if game_result.save!
          render json: game_result.title_before_type_cast
        else
          render status: :unprocessable_entity
        end
      end

      private

      def game_results_params
        params.require(:game_result).permit(:mode, :score)
      end

      def calc_title(score)
        if score >= SCORE_LEVELS[GOLD]
          return GOLD
        elsif score >= SCORE_LEVELS[IRON]
          return IRON
        elsif score >= SCORE_LEVELS[SOIL]
          return SOIL
        elsif score >= SCORE_LEVELS[SMILE]
          return SMILE
        elsif score < SCORE_LEVELS[SMILE]
          return LAUGH
        end
      end
    end
  end
end