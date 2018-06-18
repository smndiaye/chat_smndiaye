# frozen_string_literal: true

module Chat
  class Base < Grape::API
    mount Chat::V1::Base
  end
end
