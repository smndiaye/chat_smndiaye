# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string  :username
      t.integer :age
      t.string  :sex
      t.string  :city
      t.string  :country
      t.string  :token

      t.timestamps
    end
  end
end
