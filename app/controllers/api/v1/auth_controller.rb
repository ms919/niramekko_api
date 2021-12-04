module Api
  module V1
    class AuthController < ApplicationController
      def create
        user = User.find_or_create_from_auth(request.env['omniauth.auth'])
        user.update!(token: SecureRandom.urlsafe_base64)
        # redirect_to "http://lvh.me:8080/callback?token=#{user.token}"
        redirect_to Rails.application.credentials.production[:domain] << "/callback?token=#{user.token}"
      end
      def failure
        # redirect_to "http://lvh.me:8080/login"
        redirect_to Rails.application.credentials.production[:domain] << "/login"
      end
    end
  end
end