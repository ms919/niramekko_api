module Api
  module V1
    class UsersController < ApplicationController
      before_action :logged_in?

      def show
        user = User.find(current_user.id)
        render json: user
      end
    end
  end
end