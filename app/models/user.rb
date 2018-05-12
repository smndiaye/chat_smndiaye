# frozen_string_literal: true

class User < ApplicationRecord
  has_many :sent_messages,     class_name: 'Message', foreign_key: 'sender_id'
  has_many :received_messages, class_name: 'Message', foreign_key: 'receiver_id'

  validates :age,      presence: true,
                       numericality: { greater_than_or_equal_to: 18 }
  validates :gender,   presence: true
  validates :city,     presence: true
  validates :country,  presence: true
  validates :username, presence: true, uniqueness: true

  enum gender: { male: 0, female: 1 }
end
