module Api
  module V1
    class PlaylistsController < ApplicationController
      def index
        user_id = logged_in? ? current_user.id : nil
        case params[:mode].to_i
        when GameResult.modes[:normal] then
          videos = Video.filter_hidden_videos(user_id).order("RANDOM()").limit(5)
        when GameResult.modes[:dojyo] then
          videos = Video.filter_hidden_videos(user_id).where(latest_top_flg: true).order("RANDOM()").limit(5)
        when GameResult.modes[:revenge] then
          videos = Video.filter_hidden_videos(user_id).revenge_playlists(user_id).order("RANDOM()").limit(5)
        end
        render json: videos
      end
    end
  end
end