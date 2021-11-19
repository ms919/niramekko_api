module Api
  module V1
    class VideosController < ApplicationController
      before_action :logged_in?

      def new; end
      def create
        video = current_user.videos.build(video_params)
        if video.save
          render json: video, status: :created
        else
          render status: :unprocessable_entity
        end
      end

      private

      def video_params
        params.require(:video).permit(:video_user, :data_video_id)
      end
    end
  end
end
