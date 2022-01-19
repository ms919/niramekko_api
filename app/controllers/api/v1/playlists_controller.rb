module Api
  module V1
    class PlaylistsController < ApplicationController
      def index
        render json: select_videos
      end

      private

      def select_videos
        user_id = logged_in? ? current_user.id : nil
        case params[:mode].to_i
        when GameResult.modes[:normal] then
          Video.filter_videos(user_id).playlist_order
        when GameResult.modes[:dojo] then
          Video.filter_videos(user_id).where(latest_top_flg: true).playlist_order
        when GameResult.modes[:revenge] then
          Video.filter_videos(user_id).revenge_playlists(user_id).playlist_order
        end
      end
    end
  end
end