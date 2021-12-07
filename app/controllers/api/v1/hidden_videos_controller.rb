module Api
  module V1
    class HiddenVideosController < ApplicationController
      before_action :filter_unauthenticated

      def create
        hidden_videos = Bulk::HiddenVideosCollection.new(hidden_videos_params, current_user.id)
        if hidden_videos.save
          render status: :created
        else
          render status: :unprocessable_entity
        end
      end

      private

      def hidden_videos_params
        params.require(:_json)
      end
    end
  end
end