module Api
  module V1
    class LaughedVideosController < ApplicationController
      def create
        laughed_videos = Bulk::LaughedVideosCollection.new(laughed_videos_params, current_user.id)
        if laughed_videos.save
          render status: :created
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