module Api
  module V1
    class LaughedVideosController < ApplicationController
      def create
        user_id = logged_in? ? current_user.id : nil
        laughed_videos = Bulk::LaughedVideosCollection.new(laughed_videos_params, user_id)
        if laughed_videos.save
          session[:revenge_flg] ||= Video.can_create_revenge_playlists?(user_id) if logged_in?
          render json: { revenge_flg: session[:revenge_flg] }
        else
          render status: :unprocessable_entity
        end
      end

      private

      def laughed_videos_params
          params.require(:_json)
      end
    end
  end
end