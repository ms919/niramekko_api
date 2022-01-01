module Api
  module V1
    class PlaylistsController < ApplicationController
      def index
        render json: select_videos
      end

      def show
        Video.find(params[:cannot_play_id]).update(cannot_play_flg: true)
        render json: select_videos.where.not(id: params[:video_ids]).order("RANDOM()").limit(1)
      end

      private

      def select_videos
        user_id = logged_in? ? current_user.id : nil
        case params[:mode].to_i
        when GameResult.modes[:normal] then
          Video.filter_videos(user_id).playlist_order
        when GameResult.modes[:dojyo] then
          Video.filter_videos(user_id).where(latest_top_flg: true).playlist_order
        when GameResult.modes[:revenge] then
          Video.filter_videos(user_id).revenge_playlists(user_id).playlist_order
        end
      end
    end
  end
end