module Api
  module V1
    class UserNotificationsController < ApplicationController
      before_action :filter_authenticated

      def update
        user_notification = UserNotification.find(params[:id])
        if user_notification.update(read_flg: true)
          render json: UserNotification.not_read_notifications(current_user.id)
        else
          render status: :unprocessable_entity
        end
      end
    end
  end
end