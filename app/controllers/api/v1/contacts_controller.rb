module Api
  module V1
    class ContactsController < ApplicationController
      def create
        contact = Contact.new(contact_params)
        if contact.save
          render status: :created
        else
          render status: :unprocessable_entity
        end
      end

      private

      def contact_params
        params.require(:contact).permit(:type, :message)
      end
    end
  end
end