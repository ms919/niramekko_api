module Api
  module V1
    class UsersController < ApplicationController
      def show
        if current_user
          user = User.find(current_user.id)
          render json: user
        else
          render status: :bad_request
        end
      end

      private

      def current_user
        return unless session[:user_id]
        @current_user ||= User.find(session[:user_id])
      end

      def logged_in?
        !!session[:user_id]
      end
    end
  end
end