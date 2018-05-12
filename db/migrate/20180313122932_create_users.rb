# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string  :username,        null: false, unique: true
      t.integer :age,             null: false
      t.string  :gender,          null: false
      t.string  :city,            null: false
      t.string  :country,         null: false
      t.string  :password_digest, null: false

      t.timestamps
    end
  end
end
