# frozen_string_literal: true

module Chat
  module V1
    class Users < Grape::API
      include Chat::V1::Settings

      resource :users do
        desc 'get all users'
        get '', root: :users do
          User.all
        end

        desc 'get a particular user'
        params do
          requires :id, type: String, desc: 'user ID'
        end
        get ':id', root: 'user' do
          User.where(id: permitted_params[:id]).first!
        end
      end
    end
  end
end
