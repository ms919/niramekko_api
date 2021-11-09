module Api
  module V1
    class PlaylistsController < ApplicationController
      def index
        videos = Video.order("RANDOM()").limit(5)
        render json: videos
      end
    end
  end
end