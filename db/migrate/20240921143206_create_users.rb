# frozen_string_literal: true

# create users table migration
class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.string :email
      t.string :phone_no

      t.column :type, :smallint

      t.boolean :active

      t.timestamps
    end
  end
end
