# frozen_string_literal: true

class User < ApplicationRecord
  has_many :sent_messages,     class_name: 'Message', foreign_key: 'sender_id'
  has_many :received_messages, class_name: 'Message', foreign_key: 'receiver_id'
end
