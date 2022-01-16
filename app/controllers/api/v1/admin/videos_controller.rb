module Api
  module V1
    module Admin
      class VideosController < ApplicationController
        before_action :admin?

        def index
          videos = Video.select(:id, :user_id, :latest_top_flg, :video_user, :data_video_id).where(cannot_play_flg: params[:cannot_play_flg]).order(:id).page(params[:page]).per(5)
          render json: { videos: videos, total_pages: videos.total_pages }
        end

        def destroy
          begin
            Video.destroy(params[:id])
            render status: :accepted
          rescue
            render status: :bad_request
          end
        end
      end
    end
  end
end