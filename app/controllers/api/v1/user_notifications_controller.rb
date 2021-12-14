module Api
  module V1
    class UserNotificationsController < ApplicationController
      before_action :filter_unauthenticated

      def update
        user_notification = UserNotification.find(params[:id])
        if user_notification.update(read_flg: true)
          user_notifications = UserNotification.where(user_id: current_user.id, read_flg: false).order(:id).select(:id, :message)
          user_notifications = nil if user_notifications.length == 0
          render json: user_notifications
        else
          render status: :unprocessable_entity
        end
      end
    end
  end
end