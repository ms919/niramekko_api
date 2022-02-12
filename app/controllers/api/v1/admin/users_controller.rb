module Api
  module V1
    module Admin
      class UsersController < ApplicationController
        before_action :filter_admin

        def index
          users = User.select(:id, :name, :role).order(:id).page(params[:page]).per(10)
          render json: { users: users, total_pages: users.total_pages }
        end

        def destroy
          begin
            User.destroy(params[:id])
            render status: :accepted
          rescue
            render status: :bad_request
          end
        end
      end
    end
  end
end