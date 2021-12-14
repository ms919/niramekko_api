module Api
  module V1
    class UsersController < ApplicationController
      before_action :filter_unauthenticated

      def show
        # userページ表示に必要な情報を集める
        user_id = current_user.id
        user = User.select(:name, :image_url).find(user_id)
        game_results = GameResult.where(user_id: user_id).group(:title).count
        total_score = GameResult.where(user_id: user_id).sum(:score) + LatestTopRecord.where(user_id: user_id).sum(:avg_score)
        user_notifications = UserNotification.where(user_id: user_id, read_flg: false).order(:id).select(:id, :message)
        user_notifications = nil if user_notifications.length == 0
        session[:revenge_flg] = Video.filter_hidden_videos(user_id).revenge_playlists(user_id).length >= 3 unless session[:revenge_flg]
        render json: { user: user, total_score: total_score, game_results: game_results, notifications: user_notifications, revenge_flg: session[:revenge_flg] }
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