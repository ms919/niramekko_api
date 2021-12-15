module Api
  module V1
    class AuthController < ApplicationController
      def create
        begin
          user = User.find_or_create_from_auth(request.env['omniauth.auth'])
          user.update!(token: SecureRandom.urlsafe_base64)
          # redirect_to "http://localhost:8080/callback?token=#{user.token}"
          redirect_to "https://" << Rails.application.credentials.production[:domain] << "/callback?token=#{user.token}?auth=#{request.env['omniauth.auth']}"
        rescue
          failure
        end
      end

      def failure
        # redirect_to "http://localhost:8080/login"
        redirect_to "https://" << Rails.application.credentials.production[:domain] << "/login"
      end
    end
  end
end