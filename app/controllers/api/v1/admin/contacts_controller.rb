module Api
  module V1
    module Admin
      class ContactsController < ApplicationController
        before_action :admin?

        def index
          contacts = Contact.order(:id).page(params[:page]).per(10)
          render json: { users: contacts, total_pages: contacts.total_pages }
        end

        def update
          contact = Contact.find(params[:id])
          if contact.update(contact_params)
            render status: :accepted
          else
            render status: :bad_request
          end
        end

        def destroy
          begin
            Contact.destroy(params[:id])
            render status: :accepted
          rescue
            render status: :bad_request
          end
        end

        private

        def contact_params
          params.require(:contact).permit(:state)
        end
      end
    end
  end
end