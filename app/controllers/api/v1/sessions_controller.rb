module Api
  module V1
    class SessionsController < ApplicationController
      before_action :filter_unauthenticated, only: :destroy

      def create
        t = Time.current
        user = User.find_by(token: session_params[:token], updated_at: t - 60 ... t)
        if user
          session[:user_id] = user.id
          render status: :ok
        else
          render status: :not_acceptable
        end
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
