module Api
  module V1
    class PlaylistsController < ApplicationController
      def index
        case params[:mode].to_i
        when GameResult.modes[:normal] then
          videos = Video.order("RANDOM()").limit(5)
        when GameResult.modes[:dojyo] then
          videos = Video.where(latest_top_flg: true).order("RANDOM()").limit(5)
        when GameResult.modes[:revenge] then
          videos = Video.revenge_playlists(current_user.id).order("RANDOM()").limit(5)
        end
        render json: videos
      end
    end
  end
end