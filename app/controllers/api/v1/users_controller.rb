module Api
  module V1
    class UsersController < ApplicationController

      def show
        render status: :unauthorized unless logged_in?
        user_id = current_user.id
        user = User.select(:name, :image_url).find(user_id)
        game_results = GameResult.where(user_id: user_id).group(:title).count
        total_score = GameResult.where(user_id: user_id).sum(:score)
        user_notifications = UserNotification.select(:message).where(user_id: user_id, read_flg: false)
        user_notifications = nil if user_notifications.length == 0
        session[:revenge_flg] = Video.revenge_playlists(user_id).length >= 3 unless session[:revenge_flg]
        render json: { user: user, total_score: total_score, game_results: game_results, notifications: user_notifications, revenge_flg: session[:revenge_flg] }
      end
    end
  end
end