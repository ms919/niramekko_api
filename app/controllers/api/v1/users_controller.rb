module Api
  module V1
    class UsersController < ApplicationController
      before_action :filter_authenticated

      def show
        # userページ表示に必要な情報を集める
        user_id = current_user.id
        user = User.select(:name, :image_url).find(user_id)
        game_results = GameResult.where(user_id: user_id).group(:title).count
        total_score = GameResult.where(user_id: user_id).sum(:score) + LatestTopRecord.where(user_id: user_id).sum(:avg_score)
        user_notifications = UserNotification.not_read_notifications(user_id)
        session[:revenge_flg] ||= Video.can_create_revenge_playlists?(user_id)
        render json: { user: user, total_score: total_score.ceil(1), game_results: game_results, notifications: user_notifications, revenge_flg: session[:revenge_flg] }
      end

      def update
        if current_user.update(user_params)
          render status: :accepted
        else
          render status: :unprocessable_entity
        end
      end

      def destroy
        if current_user.destroy
          reset_session
          render status: :accepted
        else
          render status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:name)
      end
    end
  end
end