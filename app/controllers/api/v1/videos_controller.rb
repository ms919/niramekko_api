module Api
  module V1
    class VideosController < ApplicationController
      def create
        video = Video.new(video_params)
        if video.save
          render json: video, status: :created
        else
          render json: video.errors, status: :unprocessable_entity
        end
      end

      private

      def video_params
        params.require(:video).permit(:video_user, :data_video_id)
      end
    end
  end
end
