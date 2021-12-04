module Api
  module V1
    class SessionsController < ApplicationController
      def create
        t = Time.current
        user = User.find_by(token: session_params[:token], updated_at: t - 60 ... t)
        session[:user_id] = user.id
        render status: :created
      end

      def destroy
        reset_session
        head :ok
      end

      private

      def session_params
        params.require(:session).permit(:token)
      end
    end
  end
end
