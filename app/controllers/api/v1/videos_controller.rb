module Api
  module V1
    class VideosController < ApplicationController
      before_action :filter_authenticated, only: %i(index new create destroy)

      def index
        videos = Video.select(:id, :video_user, :data_video_id).where(user_id: current_user.id).order(:id).page(params[:page]).per(5)
        render json: { videos: videos, total_pages: videos.total_pages }
      end

      def new; end

      def create
        video = current_user.videos.build(video_params)
        if video.save
          render json: video, status: :created
        else
          render status: :unprocessable_entity
        end
      end

      def update
        video = Video.find(params[:id])
        if video.update(cannot_play_flg: true)
          render status: :accepted
        else
          render status: :unprocessable_entity
        end
      end

      def destroy
        begin
          Video.destroy(params[:id])
          render status: :accepted
        rescue
          render status: :bad_request
        end
      end

      private

      def video_params
        params.require(:video).permit(:video_user, :data_video_id)
      end
    end
  end
end
