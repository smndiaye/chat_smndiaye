# frozen_string_literal: true

module Chat
  module Entities
    module V1
      class User < Grape::Entity
        expose :username
        expose :age
        expose :sex
        expose :city
        expose :country
      end
    end
  end
end
