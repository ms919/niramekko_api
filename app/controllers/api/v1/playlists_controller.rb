module Api
  module V1
    class PlaylistsController < ApplicationController
      def index
        user_id = logged_in? ? current_user.id : nil
        render json: Video.select_videos(params[:mode].to_i, user_id)
      end
    end
  end
end