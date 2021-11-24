module Api
  module V1
    class SessionsController < ApplicationController
      def create
        user = User.find_or_create_from_auth(request.env['omniauth.auth'])
        session[:user_id] = user.id
        # byebug
        # redirect_to "http://localhost:8080/user"
        redirect_to "http://lvh.me:8080/user"
        # redirect_to Rails.application.credentials.production[:auth_user_url]
      end
      def destroy
        reset_session
        head :ok
      end
      def failure
        render status: :bad_request
      end
    end
  end
end
