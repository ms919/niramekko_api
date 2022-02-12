module Api
  module V1
    class HiddenVideosController < ApplicationController
      before_action :filter_authenticated

      def index
        videos = Video.select(:id, :video_user, :data_video_id).where(id: HiddenVideo.select(:video_id).where(user_id: current_user.id)).order(:id).page(params[:page]).per(5)
        render json: { videos: videos, total_pages: videos.total_pages }
      end

      def create
        hidden_videos = Bulk::HiddenVideosCollection.new(hidden_videos_params, current_user.id)
        if hidden_videos.save
          render status: :created
        else
          render status: :unprocessable_entity
        end
      end

      def destroy
        begin
          HiddenVideo.destroy(params[:id])
          render status: :accepted
        rescue
          render status: :bad_request
        end
      end

      private

      def hidden_videos_params
        params.require(:_json)
      end
    end
  end
end