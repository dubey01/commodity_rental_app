# frozen_string_literal: true

# create categories table migration
class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :code

      t.boolean :active

      t.timestamps
    end
  end
end
