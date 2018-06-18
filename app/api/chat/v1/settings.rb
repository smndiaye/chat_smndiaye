# frozen_string_literal: true

module Chat
  module V1
    module Settings
      extend ActiveSupport::Concern
      included do
        prefix :api
        version 'v1', using: :path
        default_format :json
        format :json

        helpers do
          def permitted_params
            @permitted_params ||= declared(params, include_missing: false)
          end

          def logger
            Rails.logger
          end
        end

        rescue_from ActiveRecord::RecordNotFound do |error|
          error_response(message: error.message, status: 404)
        end

        rescue_from ActiveRecord::RecordInvalid do |error|
          error_response(message: error.message, status: 422)
        end
      end
    end
  end
end
