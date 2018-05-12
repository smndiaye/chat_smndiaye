# frozen_string_literal: true

class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.string  :content, limit: 1000
      t.integer :sender_id, references: 'user'
      t.integer :receiver_id, references: 'user'

      t.timestamps
    end
  end
end
