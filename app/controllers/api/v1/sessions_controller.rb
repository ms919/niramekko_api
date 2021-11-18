module Api
  module V1
    class SessionsController < ApplicationController
      def create
        # user = User.find_by(params[:uid], params[:provider])
        # if user.id != params[:id] then user = nil end
        user = User.find_or_create_from_auth(request.env['omniauth.auth'])
        session[:user_id] = user.id
        redirect_to "http://localhost:8080/user"
        # render json: user
      end
      def destroy
        reset_session
        head :ok
      end
      def failure
        render json: 'failure auth!!!'
      end
    end
  end
end
