module Api
  module V1
    class UsersController < ApplicationController
      before_action :logged_in?

      def show
        user = User.find(current_user.id)
        session[:revenge_flg] = Video.revenge_playlists(current_user.id).length >= 3 unless session[:revenge_flg]
        render json: { user: user, revenge_flg: session[:revenge_flg] }
      end
    end
  end
end