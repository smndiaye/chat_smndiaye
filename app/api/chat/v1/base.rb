# frozen_string_literal: true

module Chat
  module V1
    class Base < Grape::API
      mount Chat::V1::Users
    end
  end
end
